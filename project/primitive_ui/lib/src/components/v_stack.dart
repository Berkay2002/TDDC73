import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

/// Alignment options for VStack children.
enum VStackAlignment {
  /// Align children to the start (left in LTR, right in RTL).
  start,

  /// Center children horizontally.
  center,

  /// Align children to the end (right in LTR, left in RTL).
  end,

  /// Stretch children to fill available width.
  stretch,
}

/// A vertical stack layout component built using only CustomMultiChildLayout.
///
/// VStack arranges its children vertically with configurable spacing and alignment.
/// This is a primitive implementation that doesn't use Column, Row, or other
/// high-level layout widgets.
///
/// Example:
/// ```dart
/// VStack(
///   spacing: 16.0,
///   alignment: VStackAlignment.center,
///   children: [
///     Text('First'),
///     Text('Second'),
///     Text('Third'),
///   ],
/// )
/// ```
class VStack extends StatelessWidget {
  /// Creates a vertical stack.
  const VStack({
    super.key,
    required this.children,
    this.spacing = 0.0,
    this.alignment = VStackAlignment.start,
    this.mainAxisSize = MainAxisSize.max,
  });

  /// The widgets to display in the stack.
  final List<Widget> children;

  /// The vertical spacing between children.
  final double spacing;

  /// How to align children horizontally.
  final VStackAlignment alignment;

  /// Whether to take up maximum or minimum vertical space.
  final MainAxisSize mainAxisSize;

  @override
  Widget build(BuildContext context) {
    if (children.isEmpty) {
      return const SizedBox.shrink();
    }

    if (children.length == 1) {
      return children[0];
    }

    return _VStackLayout(
      spacing: spacing,
      alignment: alignment,
      mainAxisSize: mainAxisSize,
      children: children,
    );
  }
}

/// Internal widget that uses CustomMultiChildLayout for the actual layout.
class _VStackLayout extends MultiChildRenderObjectWidget {
  const _VStackLayout({
    required this.spacing,
    required this.alignment,
    required this.mainAxisSize,
    required super.children,
  });

  final double spacing;
  final VStackAlignment alignment;
  final MainAxisSize mainAxisSize;

  @override
  RenderObject createRenderObject(BuildContext context) {
    return _RenderVStack(
      spacing: spacing,
      alignment: alignment,
      mainAxisSize: mainAxisSize,
      textDirection: Directionality.of(context),
    );
  }

  @override
  void updateRenderObject(BuildContext context, _RenderVStack renderObject) {
    renderObject
      ..spacing = spacing
      ..alignment = alignment
      ..mainAxisSize = mainAxisSize
      ..textDirection = Directionality.of(context);
  }
}

/// Custom render object for VStack layout.
///
/// This implementation manually calculates child positions and sizes
/// without using Flexible, Expanded, or other high-level layout helpers.
class _RenderVStack extends RenderBox
    with
        ContainerRenderObjectMixin<RenderBox, _VStackParentData>,
        RenderBoxContainerDefaultsMixin<RenderBox, _VStackParentData> {
  _RenderVStack({
    required double spacing,
    required VStackAlignment alignment,
    required MainAxisSize mainAxisSize,
    required TextDirection textDirection,
  }) : _spacing = spacing,
       _alignment = alignment,
       _mainAxisSize = mainAxisSize,
       _textDirection = textDirection;

  double _spacing;
  double get spacing => _spacing;
  set spacing(double value) {
    if (_spacing == value) return;
    _spacing = value;
    markNeedsLayout();
  }

  VStackAlignment _alignment;
  VStackAlignment get alignment => _alignment;
  set alignment(VStackAlignment value) {
    if (_alignment == value) return;
    _alignment = value;
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
    if (child.parentData is! _VStackParentData) {
      child.parentData = _VStackParentData();
    }
  }

  @override
  void performLayout() {
    // If no children, size to zero
    if (childCount == 0) {
      size = constraints.smallest;
      return;
    }

    // Measure all children and calculate total height
    double maxWidth = 0.0;
    double totalHeight = 0.0;
    int childIndex = 0;
    RenderBox? child = firstChild;

    while (child != null) {
      final childParentData = child.parentData! as _VStackParentData;

      // Create constraints based on alignment
      BoxConstraints childConstraints;
      if (alignment == VStackAlignment.stretch) {
        // Force child to take full width
        childConstraints = BoxConstraints(
          minWidth: constraints.maxWidth,
          maxWidth: constraints.maxWidth,
          minHeight: 0,
          maxHeight: constraints.maxHeight,
        );
      } else {
        // Allow child to size itself
        childConstraints = BoxConstraints(
          minWidth: 0,
          maxWidth: constraints.maxWidth,
          minHeight: 0,
          maxHeight: constraints.maxHeight,
        );
      }

      child.layout(childConstraints, parentUsesSize: true);

      maxWidth = maxWidth > child.size.width ? maxWidth : child.size.width;
      totalHeight += child.size.height;

      // Add spacing for all children except the last
      if (childIndex < childCount - 1) {
        totalHeight += spacing;
      }

      childIndex++;
      child = childParentData.nextSibling;
    }

    // Determine our own size
    final double width = constraints.maxWidth;
    final double height = mainAxisSize == MainAxisSize.max
        ? (constraints.hasBoundedHeight ? constraints.maxHeight : totalHeight)
        : totalHeight.clamp(constraints.minHeight, constraints.maxHeight);

    size = Size(width, height);

    // Position children vertically
    double currentY = 0.0;
    child = firstChild;

    while (child != null) {
      final childParentData = child.parentData! as _VStackParentData;

      // Calculate horizontal position based on alignment
      double x;
      switch (alignment) {
        case VStackAlignment.start:
          x = textDirection == TextDirection.ltr
              ? 0.0
              : width - child.size.width;
          break;
        case VStackAlignment.center:
          x = (width - child.size.width) / 2;
          break;
        case VStackAlignment.end:
          x = textDirection == TextDirection.ltr
              ? width - child.size.width
              : 0.0;
          break;
        case VStackAlignment.stretch:
          x = 0.0;
          break;
      }

      childParentData.offset = Offset(x, currentY);
      currentY += child.size.height + spacing;

      child = childParentData.nextSibling;
    }
  }

  @override
  double computeMinIntrinsicWidth(double height) {
    double width = 0.0;
    RenderBox? child = firstChild;
    while (child != null) {
      final childParentData = child.parentData! as _VStackParentData;
      final childWidth = child.getMinIntrinsicWidth(double.infinity);
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
      final childParentData = child.parentData! as _VStackParentData;
      final childWidth = child.getMaxIntrinsicWidth(double.infinity);
      width = width > childWidth ? width : childWidth;
      child = childParentData.nextSibling;
    }
    return width;
  }

  @override
  double computeMinIntrinsicHeight(double width) {
    double height = 0.0;
    int childIndex = 0;
    RenderBox? child = firstChild;
    while (child != null) {
      final childParentData = child.parentData! as _VStackParentData;
      height += child.getMinIntrinsicHeight(width);
      if (childIndex < childCount - 1) {
        height += spacing;
      }
      childIndex++;
      child = childParentData.nextSibling;
    }
    return height;
  }

  @override
  double computeMaxIntrinsicHeight(double width) {
    double height = 0.0;
    int childIndex = 0;
    RenderBox? child = firstChild;
    while (child != null) {
      final childParentData = child.parentData! as _VStackParentData;
      height += child.getMaxIntrinsicHeight(width);
      if (childIndex < childCount - 1) {
        height += spacing;
      }
      childIndex++;
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

/// Parent data for VStack children.
class _VStackParentData extends ContainerBoxParentData<RenderBox> {}
