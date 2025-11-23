import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

/// Alignment options for HStack children.
enum HStackAlignment {
  /// Align children to the top.
  top,

  /// Center children vertically.
  center,

  /// Align children to the bottom.
  bottom,

  /// Stretch children to fill available height.
  stretch,
}

/// A horizontal stack layout component built using only CustomMultiChildLayout.
///
/// HStack arranges its children horizontally with configurable spacing and alignment.
/// This is a primitive implementation that doesn't use Column, Row, or other
/// high-level layout widgets.
///
/// Example:
/// ```dart
/// HStack(
///   spacing: 16.0,
///   alignment: HStackAlignment.center,
///   children: [
///     Text('First'),
///     HCustomExpanded(
///       child: Container(color: Colors.red),
///     ),
///     Text('Third'),
///   ],
/// )
/// ```
class HStack extends StatelessWidget {
  /// Creates a horizontal stack.
  const HStack({
    super.key,
    required this.children,
    this.spacing = 0.0,
    this.alignment = HStackAlignment.top,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.mainAxisSize = MainAxisSize.max,
  }) : assert(spacing >= 0.0, 'Spacing must be non-negative');

  /// The widgets to display in the stack.
  final List<Widget> children;

  /// The horizontal spacing between children.
  final double spacing;

  /// How to align children vertically.
  final HStackAlignment alignment;

  /// How to align children horizontally.
  final MainAxisAlignment mainAxisAlignment;

  /// Whether to take up maximum or minimum horizontal space.
  final MainAxisSize mainAxisSize;

  @override
  Widget build(BuildContext context) {
    if (children.isEmpty) {
      return const SizedBox.shrink();
    }

    return _HStackLayout(
      spacing: spacing,
      alignment: alignment,
      mainAxisAlignment: mainAxisAlignment,
      mainAxisSize: mainAxisSize,
      children: children,
    );
  }
}

/// A widget that controls how a child of a [HStack] flexes.
class HCustomFlexible extends ParentDataWidget<_HStackParentData> {
  /// Creates a widget that controls how a child of a [HStack] flexes.
  const HCustomFlexible({
    super.key,
    this.flex = 1,
    this.fit = FlexFit.loose,
    required super.child,
  });

  /// The flex factor to use for this child.
  final int flex;

  /// How a flexible child is inscribed into the available space.
  final FlexFit fit;

  @override
  void applyParentData(RenderObject renderObject) {
    final _HStackParentData parentData = renderObject.parentData! as _HStackParentData;
    bool needsLayout = false;

    if (parentData.flex != flex) {
      parentData.flex = flex;
      needsLayout = true;
    }

    if (parentData.fit != fit) {
      parentData.fit = fit;
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
  Type get debugTypicalAncestorWidgetClass => HStack;
}

/// A widget that forces a child of a [HStack] to fill the available space.
class HCustomExpanded extends HCustomFlexible {
  /// Creates a widget that forces a child of a [HStack] to fill the available space.
  const HCustomExpanded({
    super.key,
    super.flex,
    required super.child,
  }) : super(fit: FlexFit.tight);
}

/// Internal widget that uses CustomMultiChildLayout for the actual layout.
class _HStackLayout extends MultiChildRenderObjectWidget {
  const _HStackLayout({
    required this.spacing,
    required this.alignment,
    required this.mainAxisAlignment,
    required this.mainAxisSize,
    required super.children,
  });

  final double spacing;
  final HStackAlignment alignment;
  final MainAxisAlignment mainAxisAlignment;
  final MainAxisSize mainAxisSize;

  @override
  RenderObject createRenderObject(BuildContext context) {
    return _RenderHStack(
      spacing: spacing,
      alignment: alignment,
      mainAxisAlignment: mainAxisAlignment,
      mainAxisSize: mainAxisSize,
      textDirection: Directionality.of(context),
    );
  }

  @override
  void updateRenderObject(BuildContext context, _RenderHStack renderObject) {
    renderObject
      ..spacing = spacing
      ..alignment = alignment
      ..mainAxisAlignment = mainAxisAlignment
      ..mainAxisSize = mainAxisSize
      ..textDirection = Directionality.of(context);
  }
}

/// Custom render object for HStack layout.
class _RenderHStack extends RenderBox
    with
        ContainerRenderObjectMixin<RenderBox, _HStackParentData>,
        RenderBoxContainerDefaultsMixin<RenderBox, _HStackParentData> {
  _RenderHStack({
    required double spacing,
    required HStackAlignment alignment,
    required MainAxisAlignment mainAxisAlignment,
    required MainAxisSize mainAxisSize,
    required TextDirection textDirection,
  }) : _spacing = spacing,
       _alignment = alignment,
       _mainAxisAlignment = mainAxisAlignment,
       _mainAxisSize = mainAxisSize,
       _textDirection = textDirection;

  double _spacing;
  double get spacing => _spacing;
  set spacing(double value) {
    if (_spacing == value) return;
    _spacing = value;
    markNeedsLayout();
  }

  HStackAlignment _alignment;
  HStackAlignment get alignment => _alignment;
  set alignment(HStackAlignment value) {
    if (_alignment == value) return;
    _alignment = value;
    markNeedsLayout();
  }

  MainAxisAlignment _mainAxisAlignment;
  MainAxisAlignment get mainAxisAlignment => _mainAxisAlignment;
  set mainAxisAlignment(MainAxisAlignment value) {
    if (_mainAxisAlignment == value) return;
    _mainAxisAlignment = value;
    markNeedsLayout();
  }

  MainAxisSize _mainAxisSize;
  MainAxisSize get mainAxisSize => _mainAxisSize;
  set mainAxisSize(MainAxisSize value) {
    if (_mainAxisSize == value) return;
    _mainAxisSize = value;
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
    if (child.parentData is! _HStackParentData) {
      child.parentData = _HStackParentData();
    }
  }

  @override
  void performLayout() {
    if (childCount == 0) {
      size = constraints.smallest;
      return;
    }

    double totalNonFlexWidth = 0.0;
    int totalFlex = 0;
    double maxHeight = 0.0;

    // Pass 1: Measure non-flex children
    RenderBox? child = firstChild;
    while (child != null) {
      final childParentData = child.parentData! as _HStackParentData;
      final int flex = childParentData.flex ?? 0;

      if (flex > 0) {
        totalFlex += flex;
      } else {
        BoxConstraints childConstraints;
        if (alignment == HStackAlignment.stretch) {
          childConstraints = BoxConstraints(
            minWidth: 0,
            maxWidth: constraints.maxWidth,
            minHeight: constraints.maxHeight,
            maxHeight: constraints.maxHeight,
          );
        } else {
          childConstraints = BoxConstraints(
            minWidth: 0,
            maxWidth: constraints.maxWidth,
            minHeight: 0,
            maxHeight: constraints.maxHeight,
          );
        }
        child.layout(childConstraints, parentUsesSize: true);
        totalNonFlexWidth += child.size.width;
        maxHeight = maxHeight > child.size.height ? maxHeight : child.size.height;
      }
      child = childParentData.nextSibling;
    }

    final double totalSpacing = childCount > 1 ? spacing * (childCount - 1) : 0.0;
    final double availableWidth = constraints.maxWidth;
    final bool canFlex = constraints.hasBoundedWidth;

    double flexSpace = 0.0;
    if (canFlex && totalFlex > 0) {
      flexSpace = (availableWidth - totalNonFlexWidth - totalSpacing).clamp(0.0, double.infinity);
    }

    // Pass 2: Measure flex children
    child = firstChild;
    while (child != null) {
      final childParentData = child.parentData! as _HStackParentData;
      final int flex = childParentData.flex ?? 0;

      if (flex > 0) {
        double childWidth = 0.0;
        if (totalFlex > 0) {
          childWidth = (flexSpace * flex) / totalFlex;
        }

        BoxConstraints childConstraints;
        double minH = (alignment == HStackAlignment.stretch) ? constraints.maxHeight : 0.0;
        double maxH = constraints.maxHeight;

        if (childParentData.fit == FlexFit.tight) {
          childConstraints = BoxConstraints(
            minWidth: childWidth,
            maxWidth: childWidth,
            minHeight: minH,
            maxHeight: maxH,
          );
        } else {
          childConstraints = BoxConstraints(
            minWidth: 0.0,
            maxWidth: childWidth,
            minHeight: minH,
            maxHeight: maxH,
          );
        }

        child.layout(childConstraints, parentUsesSize: true);
        maxHeight = maxHeight > child.size.height ? maxHeight : child.size.height;
      }
      child = childParentData.nextSibling;
    }
    
    // Determine final size
    double finalWidth;
    if (canFlex && totalFlex > 0) {
        finalWidth = availableWidth;
    } else {
        double measuredWidth = totalNonFlexWidth + totalSpacing;
        // Add actual width of flex items (mostly for loose fit)
         child = firstChild;
         while(child != null) {
             final data = child.parentData as _HStackParentData;
             if ((data.flex ?? 0) > 0) {
                 measuredWidth += child.size.width;
             }
             child = data.nextSibling;
         }
        
        finalWidth = mainAxisSize == MainAxisSize.max
            ? (constraints.hasBoundedWidth ? constraints.maxWidth : measuredWidth)
            : measuredWidth;
    }
    
    finalWidth = finalWidth.clamp(constraints.minWidth, constraints.maxWidth);
    
    // For height, if stretch, use max constraint, else measured max height
    double finalHeight = constraints.hasBoundedHeight ? constraints.maxHeight : maxHeight;
    if (alignment != HStackAlignment.stretch && !constraints.hasBoundedHeight) {
         finalHeight = maxHeight;
    }
    
    size = Size(finalWidth, finalHeight);

    // Distribution
    double totalChildrenWidth = 0.0;
    child = firstChild;
    while (child != null) {
      totalChildrenWidth += child.size.width;
      child = (child.parentData as _HStackParentData).nextSibling;
    }
    
    double freeSpace = finalWidth - totalChildrenWidth - totalSpacing;
    double leadingSpace = 0.0;
    double betweenSpace = spacing;

    if (freeSpace > 0 && totalFlex == 0) {
         switch (mainAxisAlignment) {
        case MainAxisAlignment.start:
          leadingSpace = 0.0;
          break;
        case MainAxisAlignment.end:
          leadingSpace = freeSpace;
          break;
        case MainAxisAlignment.center:
          leadingSpace = freeSpace / 2.0;
          break;
        case MainAxisAlignment.spaceBetween:
          leadingSpace = 0.0;
          betweenSpace = spacing + (childCount > 1 ? freeSpace / (childCount - 1) : 0.0);
          break;
        case MainAxisAlignment.spaceAround:
          double s = childCount > 0 ? freeSpace / childCount : 0.0;
          betweenSpace = spacing + s;
          leadingSpace = s / 2.0;
          break;
        case MainAxisAlignment.spaceEvenly:
          double s = childCount > 0 ? freeSpace / (childCount + 1) : 0.0;
          betweenSpace = spacing + s;
          leadingSpace = s;
          break;
      }
    }
    
    // Positioning
    double currentX = leadingSpace;
    if (textDirection == TextDirection.rtl) {
       currentX = finalWidth - leadingSpace;
    }
    
    child = firstChild;
    while(child != null) {
        final childParentData = child.parentData! as _HStackParentData;
        
        double y;
        switch (alignment) {
            case HStackAlignment.top:
            y = 0.0;
            break;
            case HStackAlignment.center:
            y = (size.height - child.size.height) / 2;
            break;
            case HStackAlignment.bottom:
            y = size.height - child.size.height;
            break;
            case HStackAlignment.stretch:
            y = 0.0;
            break;
        }
        
        if (textDirection == TextDirection.rtl) {
            currentX -= child.size.width;
            childParentData.offset = Offset(currentX, y);
            currentX -= betweenSpace;
        } else {
            childParentData.offset = Offset(currentX, y);
            currentX += child.size.width + betweenSpace;
        }
        
        child = childParentData.nextSibling;
    }
  }

  @override
  double computeMinIntrinsicWidth(double height) {
      // Simplified
    double width = 0.0;
    RenderBox? child = firstChild;
    while (child != null) {
      final childParentData = child.parentData! as _HStackParentData;
      width += child.getMinIntrinsicWidth(height);
      child = childParentData.nextSibling;
    }
    return width + (childCount > 1 ? spacing * (childCount - 1) : 0.0);
  }

  @override
  double computeMaxIntrinsicWidth(double height) {
    double width = 0.0;
    RenderBox? child = firstChild;
    while (child != null) {
      final childParentData = child.parentData! as _HStackParentData;
      width += child.getMaxIntrinsicWidth(height);
      child = childParentData.nextSibling;
    }
    return width + (childCount > 1 ? spacing * (childCount - 1) : 0.0);
  }

  @override
  double computeMinIntrinsicHeight(double width) {
    double height = 0.0;
    RenderBox? child = firstChild;
    while (child != null) {
      final childParentData = child.parentData! as _HStackParentData;
      double h = child.getMinIntrinsicHeight(width);
      if (h > height) height = h;
      child = childParentData.nextSibling;
    }
    return height;
  }

  @override
  double computeMaxIntrinsicHeight(double width) {
    double height = 0.0;
    RenderBox? child = firstChild;
    while (child != null) {
      final childParentData = child.parentData! as _HStackParentData;
      double h = child.getMaxIntrinsicHeight(width);
      if (h > height) height = h;
      child = childParentData.nextSibling;
    }
    return height;
  }

  @override
  bool hitTestChildren(BoxHitTestResult result, {required Offset position}) {
    return defaultHitTestChildren(result, position: position);
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    defaultPaint(context, offset);
  }
}

/// Parent data for HStack children.
class _HStackParentData extends ContainerBoxParentData<RenderBox> {
    int? flex;
    FlexFit fit = FlexFit.tight;
}