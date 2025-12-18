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
    final _ZStackParentData parentData =
        renderObject.parentData! as _ZStackParentData;
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
    // ═══════════════════════════════════════════════════════════════════
    // STEP 1: Handle Empty Case
    // ═══════════════════════════════════════════════════════════════════
    // If there are no children, just size ourselves to the smallest
    // allowed size by our constraints (usually 0x0)
    if (childCount == 0) {
      size = constraints.smallest;
      return;
    }

    // ═══════════════════════════════════════════════════════════════════
    // STEP 2: Determine Constraints for Non-Positioned Children
    // ═══════════════════════════════════════════════════════════════════
    // Non-positioned children (those without CustomPositioned wrapper)
    // need constraints. The "fit" parameter controls how we constrain them:
    //
    // - loose: Children can be smaller than stack (0 to max)
    // - expand: Children MUST fill entire stack size
    // - passthrough: Children get exact same constraints as stack
    BoxConstraints nonPositionedConstraints;
    switch (fit) {
      case ZStackFit.loose:
        // loosen() means: minWidth/minHeight become 0, but max stays same
        // Example: constraints(100-200, 100-200) → constraints(0-200, 0-200)
        nonPositionedConstraints = constraints.loosen();
        break;
      case ZStackFit.expand:
        // tight() means: min = max (child MUST be exact size)
        // Example: constraints(100-200, 100-200) → constraints(200-200, 200-200)
        nonPositionedConstraints = BoxConstraints.tight(constraints.biggest);
        break;
      case ZStackFit.passthrough:
        // Just pass through whatever constraints we received
        nonPositionedConstraints = constraints;
        break;
    }

    // ═══════════════════════════════════════════════════════════════════
    // STEP 3: Measure Non-Positioned Children (First Pass)
    // ═══════════════════════════════════════════════════════════════════
    // We need to know how big non-positioned children want to be,
    // so we can determine the stack's size (in loose mode)
    double maxWidth = 0.0;
    double maxHeight = 0.0;

    // Loop through all children
    RenderBox? child = firstChild;
    while (child != null) {
      final childParentData = child.parentData! as _ZStackParentData;

      // Only layout non-positioned children in this pass
      // Positioned children (with CustomPositioned wrapper) are handled later
      if (!childParentData.isPositioned) {
        // layout() tells child to measure itself with given constraints
        // parentUsesSize: true means we care about the child's size
        child.layout(nonPositionedConstraints, parentUsesSize: true);

        // Track the largest child size - this helps determine stack size
        maxWidth = maxWidth > child.size.width ? maxWidth : child.size.width;
        maxHeight = maxHeight > child.size.height
            ? maxHeight
            : child.size.height;
      }
      // Move to next sibling in the linked list
      child = childParentData.nextSibling;
    }

    // ═══════════════════════════════════════════════════════════════════
    // STEP 4: Determine Stack's Final Size
    // ═══════════════════════════════════════════════════════════════════
    Size stackSize;
    if (fit == ZStackFit.expand) {
      // In expand mode, stack is as big as constraints allow
      stackSize = constraints.biggest;
    } else {
      // Otherwise, stack is sized to fit its largest child
      // but constrained by incoming constraints (can't exceed max)
      stackSize = constraints.constrain(Size(maxWidth, maxHeight));
    }
    // Set our size! This is what Flutter will use for this widget
    size = stackSize;

    // ═══════════════════════════════════════════════════════════════════
    // STEP 5: Handle Positioned Children & Position All Children
    // ═══════════════════════════════════════════════════════════════════
    // Now we know the stack's size, we can:
    // 1. Layout positioned children (need to know stack size first)
    // 2. Calculate offset (x, y position) for ALL children
    child = firstChild;
    while (child != null) {
      final childParentData = child.parentData! as _ZStackParentData;

      if (childParentData.isPositioned) {
        // ──────────────────────────────────────────────────────────
        // POSITIONED CHILD (has CustomPositioned wrapper)
        // ──────────────────────────────────────────────────────────
        // Read positioning parameters from parent data
        double? width = childParentData.width;
        double? height = childParentData.height;
        double? top = childParentData.top;
        double? bottom = childParentData.bottom;
        double? left = childParentData.left;
        double? right = childParentData.right;

        // ──────────────────────────────────────────────────────────
        // Calculate Horizontal Constraints
        // ──────────────────────────────────────────────────────────
        double minW = 0.0;
        double maxW = double.infinity;

        if (width != null) {
          // Explicit width: child MUST be this width
          minW = maxW = width;
        } else if (left != null && right != null) {
          // Both left and right set: child fills space between them
          // Example: left=10, right=10, stackWidth=100 → child width = 80
          minW = maxW = size.width - left - right;
        } else {
          // Only left OR right set (or neither): child can be any size
          // but can't exceed available space
          maxW = size.width - (left ?? 0) - (right ?? 0);
        }

        // ──────────────────────────────────────────────────────────
        // Calculate Vertical Constraints
        // ──────────────────────────────────────────────────────────
        double minH = 0.0;
        double maxH = double.infinity;

        if (height != null) {
          // Explicit height: child MUST be this height
          minH = maxH = height;
        } else if (top != null && bottom != null) {
          // Both top and bottom set: child fills space between them
          minH = maxH = size.height - top - bottom;
        } else {
          // Only top OR bottom set (or neither)
          maxH = size.height - (top ?? 0) - (bottom ?? 0);
        }

        // ──────────────────────────────────────────────────────────
        // Layout the positioned child with calculated constraints
        // ──────────────────────────────────────────────────────────
        // Clamp values to ensure they're valid (can't be negative or exceed stack size)
        child.layout(
          BoxConstraints(
            minWidth: minW.clamp(0, size.width),
            maxWidth: maxW.clamp(0, size.width),
            minHeight: minH.clamp(0, size.height),
            maxHeight: maxH.clamp(0, size.height),
          ),
          parentUsesSize: true,
        );

        // ──────────────────────────────────────────────────────────
        // Calculate X Position (horizontal)
        // ──────────────────────────────────────────────────────────
        double x = 0.0;

        if (left != null) {
          // Left is set: position from left edge
          x = left;
        } else if (right != null) {
          // Right is set: position from right edge
          // Example: right=10, childWidth=50, stackWidth=100 → x=40
          x = size.width - right - child.size.width;
        } else {
          // Neither left nor right set: default to left edge (0)
          // Note: Positioned children typically ignore alignment
          x = 0.0;
        }

        // ──────────────────────────────────────────────────────────
        // Calculate Y Position (vertical)
        // ──────────────────────────────────────────────────────────
        double y = 0.0;

        if (top != null) {
          // Top is set: position from top edge
          y = top;
        } else if (bottom != null) {
          // Bottom is set: position from bottom edge
          y = size.height - bottom - child.size.height;
        } else {
          // Neither top nor bottom set: default to top edge (0)
          y = 0.0;
        }

        // Set the child's position!
        childParentData.offset = Offset(x, y);
      } else {
        // ──────────────────────────────────────────────────────────
        // NON-POSITIONED CHILD (no CustomPositioned wrapper)
        // ──────────────────────────────────────────────────────────
        // This child was already laid out in step 3
        // Now we just need to position it according to alignment

        // Resolve alignment for the current text direction
        // (e.g., AlignmentDirectional.start becomes Alignment.left or right)
        final resolvedAlignment = alignment.resolve(textDirection);

        // alongOffset() calculates how much to shift the child
        // to achieve the desired alignment within the available space
        // Example: Alignment.center on space(100, 100) with child(50, 50)
        //          → offset(25, 25) to center it
        final double dx = resolvedAlignment
            .alongOffset(size - child.size as Offset)
            .dx;
        final double dy = resolvedAlignment
            .alongOffset(size - child.size as Offset)
            .dy;

        // Set the child's position!
        childParentData.offset = Offset(dx, dy);
      }

      // Move to next child
      child = childParentData.nextSibling;
    }
    // ═══════════════════════════════════════════════════════════════════
    // DONE! All children are laid out and positioned.
    // Flutter will now paint them in order (first child painted first,
    // last child painted on top - z-ordering)
    // ═══════════════════════════════════════════════════════════════════
  }

  // ═══════════════════════════════════════════════════════════════════
  // INTRINSIC SIZE CALCULATIONS
  // ═══════════════════════════════════════════════════════════════════
  // Intrinsic size: "What's the smallest/largest size I'd ideally want to be?"
  // Used by Flutter's layout system for things like IntrinsicWidth/Height widgets
  // For ZStack, we defer to helper functions that ask all children
  // (Positioned children usually don't contribute to intrinsic size)

  @override
  double computeMinIntrinsicWidth(double height) {
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

  // ═══════════════════════════════════════════════════════════════════
  // HIT TESTING (Touch/Click Detection)
  // ═══════════════════════════════════════════════════════════════════
  @override
  bool hitTestChildren(BoxHitTestResult result, {required Offset position}) {
    // Hit test children in reverse paint order (last painted = on top = first tested)
    // This ensures that widgets on top respond to touches before widgets below
    return defaultHitTestChildren(result, position: position);
  }

  // ═══════════════════════════════════════════════════════════════════
  // PAINTING
  // ═══════════════════════════════════════════════════════════════════
  @override
  void paint(PaintingContext context, Offset offset) {
    // Paint all children in order (first child painted first, last child on top)
    // This creates the z-ordering effect
    defaultPaint(context, offset);
  }
}

// ═══════════════════════════════════════════════════════════════════
// PARENT DATA
// ═══════════════════════════════════════════════════════════════════
/// Parent data attached to each child of ZStack.
///
/// This stores positioning information for each child.
/// It's attached to each child's RenderObject and set by CustomPositioned.
class _ZStackParentData extends ContainerBoxParentData<RenderBox> {
  // Positioning parameters from CustomPositioned widget
  double? left; // Distance from left edge
  double? top; // Distance from top edge
  double? right; // Distance from right edge
  double? bottom; // Distance from bottom edge
  double? width; // Explicit width
  double? height; // Explicit height

  /// Helper: Is this child positioned (wrapped in CustomPositioned)?
  /// If ANY positioning parameter is set, it's considered positioned
  bool get isPositioned =>
      left != null ||
      top != null ||
      right != null ||
      bottom != null ||
      width != null ||
      height != null;
}
