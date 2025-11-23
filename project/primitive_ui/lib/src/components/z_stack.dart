import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

/// How children should be sized to fit the stack.
enum StackFit {
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
/// configurable alignment. This is a primitive implementation that doesn't
/// use Flutter's Stack or Positioned widgets.
///
/// Children are painted in the order they appear in the list, so the last
/// child appears on top.
///
/// Example:
/// ```dart
/// ZStack(
///   alignment: Alignment.center,
///   children: [
///     Container(width: 100, height: 100, color: Colors.red),
///     Container(width: 50, height: 50, color: Colors.blue),
///   ],
/// )
/// ```
class ZStack extends StatelessWidget {
  /// Creates a layered stack.
  const ZStack({
    super.key,
    required this.children,
    this.alignment = Alignment.center,
    this.fit = StackFit.loose,
  });

  /// The widgets to display in the stack.
  final List<Widget> children;

  /// How to align children within the stack.
  final AlignmentGeometry alignment;

  /// How to size children.
  final StackFit fit;

  @override
  Widget build(BuildContext context) {
    if (children.isEmpty) {
      return const SizedBox.shrink();
    }

    if (children.length == 1) {
      return children[0];
    }

    return _ZStackLayout(alignment: alignment, fit: fit, children: children);
  }
}

/// Internal widget that uses a custom render object for the actual layout.
class _ZStackLayout extends MultiChildRenderObjectWidget {
  const _ZStackLayout({
    required this.alignment,
    required this.fit,
    required super.children,
  });

  final AlignmentGeometry alignment;
  final StackFit fit;

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
///
/// This implementation manually layers children on top of each other,
/// calculating positions based on alignment without using Positioned
/// or other high-level layout helpers.
class _RenderZStack extends RenderBox
    with
        ContainerRenderObjectMixin<RenderBox, _ZStackParentData>,
        RenderBoxContainerDefaultsMixin<RenderBox, _ZStackParentData> {
  _RenderZStack({
    required AlignmentGeometry alignment,
    required StackFit fit,
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

  StackFit _fit;
  StackFit get fit => _fit;
  set fit(StackFit value) {
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
    // If no children, size to zero
    if (childCount == 0) {
      size = constraints.smallest;
      return;
    }

    // Determine constraints for children based on fit mode
    BoxConstraints childConstraints;
    switch (fit) {
      case StackFit.loose:
        childConstraints = constraints.loosen();
        break;
      case StackFit.expand:
        childConstraints = BoxConstraints.tight(constraints.biggest);
        break;
      case StackFit.passthrough:
        childConstraints = constraints;
        break;
    }

    // Layout all children and find the maximum size
    double maxWidth = 0.0;
    double maxHeight = 0.0;
    RenderBox? child = firstChild;

    while (child != null) {
      final childParentData = child.parentData! as _ZStackParentData;
      child.layout(childConstraints, parentUsesSize: true);

      maxWidth = maxWidth > child.size.width ? maxWidth : child.size.width;
      maxHeight = maxHeight > child.size.height ? maxHeight : child.size.height;

      child = childParentData.nextSibling;
    }

    // Determine our own size
    // If fit is expand, use the constraints' biggest size
    // Otherwise, use the maximum child size constrained by our constraints
    if (fit == StackFit.expand) {
      size = constraints.biggest;
    } else {
      size = constraints.constrain(Size(maxWidth, maxHeight));
    }

    // Resolve alignment for text direction
    final resolvedAlignment = alignment.resolve(textDirection);

    // Position all children based on alignment
    child = firstChild;
    while (child != null) {
      final childParentData = child.parentData! as _ZStackParentData;

      // Calculate position based on alignment
      final double dx = resolvedAlignment
          .alongOffset(size - child.size as Offset)
          .dx;
      final double dy = resolvedAlignment
          .alongOffset(size - child.size as Offset)
          .dy;

      childParentData.offset = Offset(dx, dy);

      child = childParentData.nextSibling;
    }
  }

  @override
  double computeMinIntrinsicWidth(double height) {
    double width = 0.0;
    RenderBox? child = firstChild;
    while (child != null) {
      final childParentData = child.parentData! as _ZStackParentData;
      final childWidth = child.getMinIntrinsicWidth(height);
      width = width > childWidth ? width : childWidth;
      child = childParentData.nextSibling;
    }
    return width;
  }

  @override
  double computeMaxIntrinsicWidth(double height) {
    double width = 0.0;
    RenderBox? child = firstChild;
    while (child != null) {
      final childParentData = child.parentData! as _ZStackParentData;
      final childWidth = child.getMaxIntrinsicWidth(height);
      width = width > childWidth ? width : childWidth;
      child = childParentData.nextSibling;
    }
    return width;
  }

  @override
  double computeMinIntrinsicHeight(double width) {
    double height = 0.0;
    RenderBox? child = firstChild;
    while (child != null) {
      final childParentData = child.parentData! as _ZStackParentData;
      final childHeight = child.getMinIntrinsicHeight(width);
      height = height > childHeight ? height : childHeight;
      child = childParentData.nextSibling;
    }
    return height;
  }

  @override
  double computeMaxIntrinsicHeight(double width) {
    double height = 0.0;
    RenderBox? child = firstChild;
    while (child != null) {
      final childParentData = child.parentData! as _ZStackParentData;
      final childHeight = child.getMaxIntrinsicHeight(width);
      height = height > childHeight ? height : childHeight;
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

/// Parent data for ZStack children.
class _ZStackParentData extends ContainerBoxParentData<RenderBox> {}
