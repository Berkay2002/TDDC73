import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import '../utils/intrinsic_helpers.dart';

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
///     Text('Second'),
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
///
/// This implementation manually calculates child positions and sizes
/// without using Flexible, Expanded, or other high-level layout helpers.
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
    // If no children, size to zero
    if (childCount == 0) {
      size = constraints.smallest;
      return;
    }

    // Measure all children and calculate total width
    double maxHeight = 0.0;
    double totalChildrenWidth = 0.0;
    RenderBox? child = firstChild;

    while (child != null) {
      final childParentData = child.parentData! as _HStackParentData;

      // Create constraints based on alignment
      BoxConstraints childConstraints;
      if (alignment == HStackAlignment.stretch) {
        // Force child to take full height
        childConstraints = BoxConstraints(
          minWidth: 0,
          maxWidth: constraints.maxWidth,
          minHeight: constraints.maxHeight,
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

      maxHeight = maxHeight > child.size.height ? maxHeight : child.size.height;
      totalChildrenWidth += child.size.width;

      child = childParentData.nextSibling;
    }

    // Calculate total width including spacing
    double totalWidthWithSpacing = totalChildrenWidth;
    if (childCount > 1) {
      totalWidthWithSpacing += spacing * (childCount - 1);
    }

    // Determine our own size
    final double height = constraints.maxHeight;
    final double width = mainAxisSize == MainAxisSize.max
        ? (constraints.hasBoundedWidth
              ? constraints.maxWidth
              : totalWidthWithSpacing)
        : totalWidthWithSpacing.clamp(
            constraints.minWidth,
            constraints.maxWidth,
          );

    size = Size(width, height);

    // Calculate distribution parameters
    double leadingSpace = 0.0;
    double betweenSpace = spacing;

    if (mainAxisSize == MainAxisSize.max && width > totalWidthWithSpacing) {
      final double freeSpace = width - totalChildrenWidth;

      switch (mainAxisAlignment) {
        case MainAxisAlignment.start:
          leadingSpace = 0.0;
          betweenSpace = spacing;
          break;
        case MainAxisAlignment.end:
          leadingSpace = width - totalWidthWithSpacing;
          betweenSpace = spacing;
          break;
        case MainAxisAlignment.center:
          leadingSpace = (width - totalWidthWithSpacing) / 2.0;
          betweenSpace = spacing;
          break;
        case MainAxisAlignment.spaceBetween:
          leadingSpace = 0.0;
          betweenSpace = childCount > 1 ? freeSpace / (childCount - 1) : 0.0;
          break;
        case MainAxisAlignment.spaceAround:
          betweenSpace = childCount > 0 ? freeSpace / childCount : 0.0;
          leadingSpace = betweenSpace / 2.0;
          break;
        case MainAxisAlignment.spaceEvenly:
          betweenSpace = childCount > 0 ? freeSpace / (childCount + 1) : 0.0;
          leadingSpace = betweenSpace;
          break;
      }
    }

    // Position children horizontally
    double currentX = leadingSpace;

    // Handle RTL
    if (textDirection == TextDirection.rtl) {
      currentX = width - leadingSpace;
    }

    child = firstChild;

    while (child != null) {
      final childParentData = child.parentData! as _HStackParentData;

      // Calculate vertical position based on alignment
      double y;
      switch (alignment) {
        case HStackAlignment.top:
          y = 0.0;
          break;
        case HStackAlignment.center:
          y = (height - child.size.height) / 2;
          break;
        case HStackAlignment.bottom:
          y = height - child.size.height;
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
    double width = 0.0;
    int childIndex = 0;
    RenderBox? child = firstChild;
    while (child != null) {
      final childParentData = child.parentData! as _HStackParentData;
      width += child.getMinIntrinsicWidth(height);
      if (childIndex < childCount - 1) {
        width += spacing;
      }
      childIndex++;
      child = childParentData.nextSibling;
    }
    return width;
  }

  @override
  double computeMaxIntrinsicWidth(double height) {
    double width = 0.0;
    int childIndex = 0;
    RenderBox? child = firstChild;
    while (child != null) {
      final childParentData = child.parentData! as _HStackParentData;
      width += child.getMaxIntrinsicWidth(height);
      if (childIndex < childCount - 1) {
        width += spacing;
      }
      childIndex++;
      child = childParentData.nextSibling;
    }
    return width;
  }

  @override
  double computeMinIntrinsicHeight(double width) {
    return computeMinIntrinsicHeightFromChildren(firstChild, double.infinity);
  }

  @override
  double computeMaxIntrinsicHeight(double width) {
    return computeMaxIntrinsicHeightFromChildren(firstChild, double.infinity);
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
class _HStackParentData extends ContainerBoxParentData<RenderBox> {}
