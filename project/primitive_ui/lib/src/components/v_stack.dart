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
///     CustomExpanded(
///       child: Container(color: Colors.red),
///     ),
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
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.mainAxisSize = MainAxisSize.max,
  }) : assert(spacing >= 0.0, 'Spacing must be non-negative');

  /// The widgets to display in the stack.
  final List<Widget> children;

  /// The vertical spacing between children.
  final double spacing;

  /// How to align children horizontally.
  final VStackAlignment alignment;

  /// How to align children vertically.
  final MainAxisAlignment mainAxisAlignment;

  /// Whether to take up maximum or minimum vertical space.
  final MainAxisSize mainAxisSize;

  @override
  Widget build(BuildContext context) {
    if (children.isEmpty) {
      return const SizedBox.shrink();
    }

    return _VStackLayout(
      spacing: spacing,
      alignment: alignment,
      mainAxisAlignment: mainAxisAlignment,
      mainAxisSize: mainAxisSize,
      children: children,
    );
  }
}

/// A widget that controls how a child of a [VStack] flexes.
class CustomFlexible extends ParentDataWidget<_VStackParentData> {
  /// Creates a widget that controls how a child of a [VStack] flexes.
  const CustomFlexible({
    super.key,
    this.flex = 1,
    this.fit = FlexFit.loose,
    required super.child,
  });

  /// The flex factor to use for this child.
  ///
  /// If null or 0, the child is inflexible and determines its own size.
  /// If non-zero, the child can be flexible and its size is determined by
  /// the ratio of its flex factor to the sum of all flex factors.
  final int flex;

  /// How a flexible child is inscribed into the available space.
  ///
  /// If [FlexFit.tight], the child is forced to fill the available space.
  /// If [FlexFit.loose], the child can be smaller than the available space.
  final FlexFit fit;

  @override
  void applyParentData(RenderObject renderObject) {
    final _VStackParentData parentData = renderObject.parentData! as _VStackParentData;
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
  Type get debugTypicalAncestorWidgetClass => VStack;
}

/// A widget that forces a child of a [VStack] to fill the available space.
///
/// This is a shorthand for [CustomFlexible] with [FlexFit.tight].
class CustomExpanded extends CustomFlexible {
  /// Creates a widget that forces a child of a [VStack] to fill the available space.
  const CustomExpanded({
    super.key,
    super.flex,
    required super.child,
  }) : super(fit: FlexFit.tight);
}

/// Internal widget that uses CustomMultiChildLayout for the actual layout.
class _VStackLayout extends MultiChildRenderObjectWidget {
  const _VStackLayout({
    required this.spacing,
    required this.alignment,
    required this.mainAxisAlignment,
    required this.mainAxisSize,
    required super.children,
  });

  final double spacing;
  final VStackAlignment alignment;
  final MainAxisAlignment mainAxisAlignment;
  final MainAxisSize mainAxisSize;

  @override
  RenderObject createRenderObject(BuildContext context) {
    return _RenderVStack(
      spacing: spacing,
      alignment: alignment,
      mainAxisAlignment: mainAxisAlignment,
      mainAxisSize: mainAxisSize,
      textDirection: Directionality.of(context),
    );
  }

  @override
  void updateRenderObject(BuildContext context, _RenderVStack renderObject) {
    renderObject
      ..spacing = spacing
      ..alignment = alignment
      ..mainAxisAlignment = mainAxisAlignment
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

  VStackAlignment _alignment;
  VStackAlignment get alignment => _alignment;
  set alignment(VStackAlignment value) {
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
    if (child.parentData is! _VStackParentData) {
      child.parentData = _VStackParentData();
    }
  }

  @override
  void performLayout() {
    // If no children, size to zero or min constraints
    if (childCount == 0) {
      size = constraints.smallest;
      return;
    }

    double totalNonFlexHeight = 0.0;
    int totalFlex = 0;
    
    // Pass 1: Measure non-flex children and count flex
    RenderBox? child = firstChild;
    while (child != null) {
      final childParentData = child.parentData! as _VStackParentData;
      final int flex = childParentData.flex ?? 0;
      
      if (flex > 0) {
        totalFlex += flex;
      } else {
        // Measure fixed child
        BoxConstraints childConstraints;
        if (alignment == VStackAlignment.stretch) {
          childConstraints = BoxConstraints(
            minWidth: constraints.maxWidth,
            maxWidth: constraints.maxWidth,
            minHeight: 0,
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
        totalNonFlexHeight += child.size.height;
      }
      child = childParentData.nextSibling;
    }

    // Total spacing is calculated between all children (flex or not)
    final double totalSpacing = childCount > 1 ? spacing * (childCount - 1) : 0.0;
    
    final double availableHeight = constraints.maxHeight;
    final bool canFlex = constraints.hasBoundedHeight;

    double flexSpace = 0.0;
    if (canFlex && totalFlex > 0) {
        flexSpace = (availableHeight - totalNonFlexHeight - totalSpacing).clamp(0.0, double.infinity);
    }

    double maxWidth = 0.0;
    double measuredTotalHeight = 0.0;

    // Pass 2: Measure flex children
    child = firstChild;
    while (child != null) {
      final childParentData = child.parentData! as _VStackParentData;
      final int flex = childParentData.flex ?? 0;

      if (flex > 0) {
        double childHeight = 0.0;
        if (totalFlex > 0) {
             childHeight = (flexSpace * flex) / totalFlex;
        }

        BoxConstraints childConstraints;
        
        double minW = (alignment == VStackAlignment.stretch) ? constraints.maxWidth : 0.0;
        double maxW = constraints.maxWidth;
        
        if (childParentData.fit == FlexFit.tight) {
            childConstraints = BoxConstraints(
                minWidth: minW, maxWidth: maxW,
                minHeight: childHeight, maxHeight: childHeight
            );
        } else {
             childConstraints = BoxConstraints(
                minWidth: minW, maxWidth: maxW,
                minHeight: 0.0, maxHeight: childHeight
            );
        }
        
        child.layout(childConstraints, parentUsesSize: true);
      }
      
      maxWidth = maxWidth > child.size.width ? maxWidth : child.size.width;
      measuredTotalHeight += child.size.height;
      
      child = childParentData.nextSibling;
    }
    
    measuredTotalHeight += totalSpacing;

    // Determine final size
    double finalHeight;
    if (canFlex && totalFlex > 0) {
        finalHeight = availableHeight;
    } else {
        finalHeight = mainAxisSize == MainAxisSize.max 
            ? (constraints.hasBoundedHeight ? constraints.maxHeight : measuredTotalHeight)
            : measuredTotalHeight;
    }
    
    // Ensure finalHeight respects constraints
    finalHeight = finalHeight.clamp(constraints.minHeight, constraints.maxHeight);
    
    size = Size(constraints.maxWidth, finalHeight);

    // Positioning
    double freeSpace = size.height - measuredTotalHeight;
    double leadingSpace = 0.0;
    double betweenSpace = spacing;
    
    // Only distribute free space via MainAxisAlignment if we didn't flex to fill it
    // Or if flex didn't consume it all (e.g. all loose flex).
    // In standard Column, MainAxisAlignment works if there is remaining space.
    if (freeSpace > 0) {
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
    
    double currentY = leadingSpace;
    child = firstChild;
    while(child != null) {
      final childParentData = child.parentData! as _VStackParentData;
      
      double x;
      switch (alignment) {
        case VStackAlignment.start:
          x = textDirection == TextDirection.ltr
              ? 0.0
              : size.width - child.size.width;
          break;
        case VStackAlignment.center:
          x = (size.width - child.size.width) / 2;
          break;
        case VStackAlignment.end:
          x = textDirection == TextDirection.ltr
              ? size.width - child.size.width
              : 0.0;
          break;
        case VStackAlignment.stretch:
          x = 0.0;
          break;
      }
      
      childParentData.offset = Offset(x, currentY);
      currentY += child.size.height + betweenSpace;
      child = childParentData.nextSibling;
    }
  }

  @override
  double computeMinIntrinsicWidth(double height) {
    // Simplified: Intrinsic sizing with flex is complex. 
    // We defer to children.
    double width = 0.0;
    RenderBox? child = firstChild;
    while (child != null) {
        final childParentData = child.parentData! as _VStackParentData;
        double w = child.getMinIntrinsicWidth(height);
        if (w > width) width = w;
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
        double w = child.getMaxIntrinsicWidth(height);
        if (w > width) width = w;
        child = childParentData.nextSibling;
    }
    return width;
  }

  @override
  double computeMinIntrinsicHeight(double width) {
    // Does not account for flex shrinking
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
class _VStackParentData extends ContainerBoxParentData<RenderBox> {
    int? flex;
    FlexFit fit = FlexFit.tight;

    @override
    String toString() => '${super.toString()}; flex=$flex; fit=$fit';
}