import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import '../utils/intrinsic_helpers.dart';

/// How children should be sized to fit the stack.
enum ZStackFit {
  /// Children are constrained to the incoming stack constraints.
  loose,

  /// Children are expanded to fill the stack's incoming constraints.
  expand,

  /// Children are constrained to the size determined by the stack's
  /// incoming constraints, with no flexibility.
  passthrough,
}

/// A layered stack layout component built using only custom render objects.
///
/// ZStack layers its children on top of each other (z-ordering) with
/// configurable alignment. It supports positioned children via [CustomPositioned].
///
/// Example:
/// ```dart
/// ZStack(
///   alignment: Alignment.center,
///   children: [
///     Container(width: 100, height: 100, color: Colors.red),
///     CustomPositioned(
///       right: 10,
///       top: 10,
///       child: Icon(Icons.close),
///     ),
///   ],
/// )
/// ```
class ZStack extends StatelessWidget {
  /// Creates a layered stack.
  const ZStack({
    super.key,
    required this.children,
    this.alignment = Alignment.center,
    this.fit = ZStackFit.loose,
  });

  /// The widgets to display in the stack.
  final List<Widget> children;

  /// How to align children within the stack.
  final AlignmentGeometry alignment;

  /// How to size children.
  final ZStackFit fit;

  @override
  Widget build(BuildContext context) {
    if (children.isEmpty) {
      return const SizedBox.shrink();
    }

    return _ZStackLayout(alignment: alignment, fit: fit, children: children);
  }
}

/// A widget that controls where a child of a [ZStack] is positioned.
class CustomPositioned extends ParentDataWidget<_ZStackParentData> {
  const CustomPositioned({
    super.key,
    this.left,
    this.top,
    this.right,
    this.bottom,
    this.width,
    this.height,
    required super.child,
  });

  final double? left;
  final double? top;
  final double? right;
  final double? bottom;
  final double? width;
  final double? height;

  @override
  void applyParentData(RenderObject renderObject) {
    final _ZStackParentData parentData = renderObject.parentData! as _ZStackParentData;
    bool needsLayout = false;

    if (parentData.left != left) {
      parentData.left = left;
      needsLayout = true;
    }
    if (parentData.top != top) {
      parentData.top = top;
      needsLayout = true;
    }
    if (parentData.right != right) {
      parentData.right = right;
      needsLayout = true;
    }
    if (parentData.bottom != bottom) {
      parentData.bottom = bottom;
      needsLayout = true;
    }
    if (parentData.width != width) {
      parentData.width = width;
      needsLayout = true;
    }
    if (parentData.height != height) {
      parentData.height = height;
      needsLayout = true;
    }

    if (needsLayout) {
      final targetParent = renderObject.parent;
      if (targetParent is RenderObject) {
        targetParent.markNeedsLayout();
      }
    }
  }

  @override
  Type get debugTypicalAncestorWidgetClass => ZStack;
}

/// Internal widget that uses a custom render object for the actual layout.
class _ZStackLayout extends MultiChildRenderObjectWidget {
  const _ZStackLayout({
    required this.alignment,
    required this.fit,
    required super.children,
  });

  final AlignmentGeometry alignment;
  final ZStackFit fit;

  @override
  RenderObject createRenderObject(BuildContext context) {
    return _RenderZStack(
      alignment: alignment,
      fit: fit,
      textDirection: Directionality.of(context),
    );
  }

  @override
  void updateRenderObject(BuildContext context, _RenderZStack renderObject) {
    renderObject
      ..alignment = alignment
      ..fit = fit
      ..textDirection = Directionality.of(context);
  }
}

/// Custom render object for ZStack layout.
class _RenderZStack extends RenderBox
    with
        ContainerRenderObjectMixin<RenderBox, _ZStackParentData>,
        RenderBoxContainerDefaultsMixin<RenderBox, _ZStackParentData> {
  _RenderZStack({
    required AlignmentGeometry alignment,
    required ZStackFit fit,
    required TextDirection textDirection,
  }) : _alignment = alignment,
       _fit = fit,
       _textDirection = textDirection;

  AlignmentGeometry _alignment;
  AlignmentGeometry get alignment => _alignment;
  set alignment(AlignmentGeometry value) {
    if (_alignment == value) return;
    _alignment = value;
    markNeedsLayout();
  }

  ZStackFit _fit;
  ZStackFit get fit => _fit;
  set fit(ZStackFit value) {
    if (_fit == value) return;
    _fit = value;
    markNeedsLayout();
  }

  TextDirection _textDirection;
  TextDirection get textDirection => _textDirection;
  set textDirection(TextDirection value) {
    if (_textDirection == value) return;
    _textDirection = value;
    markNeedsLayout();
  }

  @override
  void setupParentData(RenderBox child) {
    if (child.parentData is! _ZStackParentData) {
      child.parentData = _ZStackParentData();
    }
  }

  @override
  void performLayout() {
    // If no children, size to zero or min constraints
    if (childCount == 0) {
      size = constraints.smallest;
      return;
    }
    
    // First, resolve global non-positioned constraints
    BoxConstraints nonPositionedConstraints;
    switch (fit) {
      case ZStackFit.loose:
        nonPositionedConstraints = constraints.loosen();
        break;
      case ZStackFit.expand:
        nonPositionedConstraints = BoxConstraints.tight(constraints.biggest);
        break;
      case ZStackFit.passthrough:
        nonPositionedConstraints = constraints;
        break;
    }

    double maxWidth = 0.0;
    double maxHeight = 0.0;
    
    // Measure non-positioned children first to help determine stack size (if loose)
    RenderBox? child = firstChild;
    while(child != null) {
        final childParentData = child.parentData! as _ZStackParentData;
        
        if (!childParentData.isPositioned) {
             child.layout(nonPositionedConstraints, parentUsesSize: true);
             maxWidth = maxWidth > child.size.width ? maxWidth : child.size.width;
             maxHeight = maxHeight > child.size.height ? maxHeight : child.size.height;
        }
        child = childParentData.nextSibling;
    }
    
    // Determine stack size
    Size stackSize;
    if (fit == ZStackFit.expand) {
      stackSize = constraints.biggest;
    } else {
      stackSize = constraints.constrain(Size(maxWidth, maxHeight));
    }
    size = stackSize;

    // Now layout positioned children and position everyone
    child = firstChild;
    while(child != null) {
        final childParentData = child.parentData! as _ZStackParentData;
        
        if (childParentData.isPositioned) {
             // Calculate constraints for positioned child
             double? width = childParentData.width;
             double? height = childParentData.height;
             double? top = childParentData.top;
             double? bottom = childParentData.bottom;
             double? left = childParentData.left;
             double? right = childParentData.right;
             
             // If horizontally constrained (left & right, or width)
             double minW = 0.0;
             double maxW = double.infinity;
             
             if (width != null) {
                 minW = maxW = width;
             } else if (left != null && right != null) {
                 minW = maxW = size.width - left - right;
             } else {
                 maxW = size.width - (left ?? 0) - (right ?? 0);
             }
             
             double minH = 0.0;
             double maxH = double.infinity;
             
             if (height != null) {
                 minH = maxH = height;
             } else if (top != null && bottom != null) {
                 minH = maxH = size.height - top - bottom;
             } else {
                 maxH = size.height - (top ?? 0) - (bottom ?? 0);
             }
             
             child.layout(BoxConstraints(
                 minWidth: minW.clamp(0, size.width), 
                 maxWidth: maxW.clamp(0, size.width),
                 minHeight: minH.clamp(0, size.height), 
                 maxHeight: maxH.clamp(0, size.height)
             ), parentUsesSize: true);
             
             // Calculate offset
             double x = 0.0;
             double y = 0.0;
             
             if (left != null) {
                 x = left;
             } else if (right != null) {
                 x = size.width - right - child.size.width;
             } else {
                 // Center horizontally if indeterminate? Or default 0?
                 // Standard Stack defaults to 0 if aligned top/left.
                 // We need to respect alignment if not fully positioned?
                 // Usually positioned children ignore alignment.
                 // If only top is set, x is 0? 
                 // Let's assume standard behavior: if not positioned on an axis, align to start (0).
                 x = 0.0;
             }
             
             if (top != null) {
                 y = top;
             } else if (bottom != null) {
                 y = size.height - bottom - child.size.height;
             } else {
                 y = 0.0;
             }
             
             childParentData.offset = Offset(x, y);

        } else {
            // Position non-positioned child
            // It was already laid out
            final resolvedAlignment = alignment.resolve(textDirection);
            final double dx = resolvedAlignment
                .alongOffset(size - child.size as Offset)
                .dx;
            final double dy = resolvedAlignment
                .alongOffset(size - child.size as Offset)
                .dy;

            childParentData.offset = Offset(dx, dy);
        }
        
        child = childParentData.nextSibling;
    }
  }

  @override
  double computeMinIntrinsicWidth(double height) {
      // Simplified: positioned children usually don't contribute to intrinsic size
    return computeMinIntrinsicWidthFromChildren(firstChild, height);
  }

  @override
  double computeMaxIntrinsicWidth(double height) {
    return computeMaxIntrinsicWidthFromChildren(firstChild, height);
  }

  @override
  double computeMinIntrinsicHeight(double width) {
    return computeMinIntrinsicHeightFromChildren(firstChild, width);
  }

  @override
  double computeMaxIntrinsicHeight(double width) {
    return computeMaxIntrinsicHeightFromChildren(firstChild, width);
  }

  @override
  bool hitTestChildren(BoxHitTestResult result, {required Offset position}) {
     // Hit test in reverse order (top to bottom)
    return defaultHitTestChildren(result, position: position);
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    defaultPaint(context, offset);
  }
}

/// Parent data for ZStack children.
class _ZStackParentData extends ContainerBoxParentData<RenderBox> {
  double? left;
  double? top;
  double? right;
  double? bottom;
  double? width;
  double? height;

  bool get isPositioned =>
      left != null ||
      top != null ||
      right != null ||
      bottom != null ||
      width != null ||
      height != null;
}