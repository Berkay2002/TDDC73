import 'package:flutter/widgets.dart';
import 'package:flutter/rendering.dart';

/// A card component built from scratch using CustomPaint.
///
/// Features:
/// - Rounded corners (customizable border radius)
/// - Shadow/elevation effect
/// - Custom background color
/// - Padding for child content
///
/// This component uses only primitive Flutter APIs:
/// - CustomPaint for rendering
/// - Canvas for drawing
/// - CustomSingleChildLayout for child positioning
class CustomCard extends StatelessWidget {
  /// The child widget to display inside the card
  final Widget child;

  /// Background color of the card
  final Color color;

  /// Border radius for rounded corners
  final double borderRadius;

  /// Elevation (shadow depth)
  final double elevation;

  /// Padding around the child
  final EdgeInsets padding;

  const CustomCard({
    super.key,
    required this.child,
    this.color = const Color(0xFFFFFFFF), // White
    this.borderRadius = 8.0,
    this.elevation = 2.0,
    this.padding = const EdgeInsets.all(16.0),
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _CardPainter(
        color: color,
        borderRadius: borderRadius,
        elevation: elevation,
      ),
      child: _CardLayout(padding: padding, child: child),
    );
  }
}

/// Custom painter that draws the card background and shadow
class _CardPainter extends CustomPainter {
  final Color color;
  final double borderRadius;
  final double elevation;

  _CardPainter({
    required this.color,
    required this.borderRadius,
    required this.elevation,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // Create rounded rectangle for the card shape
    final RRect cardRect = RRect.fromRectAndRadius(
      Rect.fromLTWH(0, 0, size.width, size.height),
      Radius.circular(borderRadius),
    );

    // Draw shadow if elevation > 0
    if (elevation > 0) {
      final Path shadowPath = Path()..addRRect(cardRect);

      // Calculate shadow color based on elevation
      // Higher elevation = darker shadow
      final double shadowOpacity = (elevation / 24.0).clamp(0.0, 0.3);
      final Color shadowColor = Color.fromRGBO(0, 0, 0, shadowOpacity);

      // Draw shadow using drawShadow
      canvas.drawShadow(
        shadowPath,
        shadowColor,
        elevation,
        true, // Transparent occluder
      );
    }

    // Draw the card background
    final Paint cardPaint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    canvas.drawRRect(cardRect, cardPaint);
  }

  @override
  bool shouldRepaint(_CardPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.borderRadius != borderRadius ||
        oldDelegate.elevation != elevation;
  }
}

/// Custom layout that applies padding to the child
/// Uses CustomSingleChildLayout to manually calculate child position
class _CardLayout extends SingleChildRenderObjectWidget {
  final EdgeInsets padding;

  const _CardLayout({required this.padding, required Widget child})
    : super(child: child);

  @override
  RenderObject createRenderObject(BuildContext context) {
    return _RenderCardLayout(padding: padding);
  }

  @override
  void updateRenderObject(
    BuildContext context,
    _RenderCardLayout renderObject,
  ) {
    renderObject.padding = padding;
  }
}

/// RenderObject that handles the card layout with padding
class _RenderCardLayout extends RenderShiftedBox {
  EdgeInsets _padding;

  _RenderCardLayout({required EdgeInsets padding, RenderBox? child})
    : _padding = padding,
      super(child);

  EdgeInsets get padding => _padding;

  set padding(EdgeInsets value) {
    if (_padding == value) return;
    _padding = value;
    markNeedsLayout();
  }

  @override
  double computeMinIntrinsicWidth(double height) {
    final child = this.child;
    if (child != null) {
      return child.getMinIntrinsicWidth(height) + _padding.horizontal;
    }
    return _padding.horizontal;
  }

  @override
  double computeMaxIntrinsicWidth(double height) {
    final child = this.child;
    if (child != null) {
      return child.getMaxIntrinsicWidth(height) + _padding.horizontal;
    }
    return _padding.horizontal;
  }

  @override
  double computeMinIntrinsicHeight(double width) {
    final child = this.child;
    if (child != null) {
      return child.getMinIntrinsicHeight(width) + _padding.vertical;
    }
    return _padding.vertical;
  }

  @override
  double computeMaxIntrinsicHeight(double width) {
    final child = this.child;
    if (child != null) {
      return child.getMaxIntrinsicHeight(width) + _padding.vertical;
    }
    return _padding.vertical;
  }

  @override
  void performLayout() {
    final child = this.child;
    if (child != null) {
      // Calculate available space for child (subtract padding)
      final BoxConstraints childConstraints = constraints.deflate(_padding);

      // Layout the child with the constrained size
      child.layout(childConstraints, parentUsesSize: true);

      // Set the card's size (child size + padding)
      size = Size(
        child.size.width + _padding.horizontal,
        child.size.height + _padding.vertical,
      );

      // Position the child with padding offset
      final BoxParentData childParentData = child.parentData as BoxParentData;
      childParentData.offset = Offset(_padding.left, _padding.top);
    } else {
      // No child, just use padding
      size = constraints.constrain(
        Size(_padding.horizontal, _padding.vertical),
      );
    }
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    final child = this.child;
    if (child != null) {
      final BoxParentData childParentData = child.parentData as BoxParentData;
      context.paintChild(child, childParentData.offset + offset);
    }
  }

  @override
  bool hitTestChildren(BoxHitTestResult result, {required Offset position}) {
    final child = this.child;
    if (child != null) {
      final BoxParentData childParentData = child.parentData as BoxParentData;
      return result.addWithPaintOffset(
        offset: childParentData.offset,
        position: position,
        hitTest: (BoxHitTestResult result, Offset transformed) {
          return child.hitTest(result, position: transformed);
        },
      );
    }
    return false;
  }
}
