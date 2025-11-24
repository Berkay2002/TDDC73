import 'dart:ui';
import 'package:flutter/widgets.dart';
import 'package:flutter/rendering.dart';

/// A card component built from scratch using CustomPaint.
///
/// Features:
/// - Rounded corners (customizable border radius)
/// - Shadow/elevation effect (customizable color)
/// - Custom background color
/// - Padding for child content
/// - Tap interaction with visual feedback
/// - Implicit animations for style changes
///
/// This component uses only primitive Flutter APIs:
/// - CustomPaint for rendering
/// - Canvas for drawing
/// - CustomSingleChildLayout for child positioning
/// - GestureDetector for interaction
class CustomCard extends StatefulWidget {
  /// The child widget to display inside the card
  final Widget child;

  /// Background color of the card
  final Color color;

  /// Border radius for rounded corners
  final double borderRadius;

  /// Elevation (shadow depth)
  final double elevation;

  /// Color of the shadow
  final Color shadowColor;

  /// Padding around the child
  final EdgeInsets padding;

  /// Callback when the card is tapped
  final VoidCallback? onTap;

  /// Semantic label for accessibility
  final String? semanticsLabel;

  /// Duration for implicit style animations
  final Duration duration;

  /// Curve for implicit style animations
  final Curve curve;

  const CustomCard({
    super.key,
    required this.child,
    this.color = const Color(0xFFFFFFFF), // White
    this.borderRadius = 8.0,
    this.elevation = 2.0,
    this.shadowColor = const Color(0xFF000000), // Black
    this.padding = const EdgeInsets.all(16.0),
    this.onTap,
    this.semanticsLabel,
    this.duration = const Duration(milliseconds: 200),
    this.curve = Curves.easeInOut,
  }) : assert(elevation >= 0.0, 'Elevation cannot be negative'),
       assert(borderRadius >= 0.0, 'Border radius cannot be negative');

  @override
  State<CustomCard> createState() => _CustomCardState();
}

class _CardStyle {
  final Color color;
  final double elevation;
  final Color shadowColor;
  final double borderRadius;

  const _CardStyle({
    required this.color,
    required this.elevation,
    required this.shadowColor,
    required this.borderRadius,
  });

  static _CardStyle lerp(_CardStyle a, _CardStyle b, double t) {
    return _CardStyle(
      color: Color.lerp(a.color, b.color, t)!,
      elevation: lerpDouble(a.elevation, b.elevation, t)!,
      shadowColor: Color.lerp(a.shadowColor, b.shadowColor, t)!,
      borderRadius: lerpDouble(a.borderRadius, b.borderRadius, t)!,
    );
  }
}

class _CustomCardState extends State<CustomCard> {
  bool _isPressed = false;

  void _handleTapDown(TapDownDetails details) {
    if (widget.onTap != null) {
      setState(() => _isPressed = true);
    }
  }

  void _handleTapUp(TapUpDetails details) {
    if (widget.onTap != null) {
      setState(() => _isPressed = false);
    }
  }

  void _handleTapCancel() {
    if (widget.onTap != null) {
      setState(() => _isPressed = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    // Reduce elevation when pressed to simulate depth
    final double effectiveElevation =
        _isPressed ? (widget.elevation / 2) : widget.elevation;

    final targetStyle = _CardStyle(
      color: widget.color,
      elevation: effectiveElevation,
      shadowColor: widget.shadowColor,
      borderRadius: widget.borderRadius,
    );

    return Semantics(
      label: widget.semanticsLabel,
      button: widget.onTap != null,
      enabled: widget.onTap != null,
      container: true,
      child: GestureDetector(
        onTap: widget.onTap,
        onTapDown: _handleTapDown,
        onTapUp: _handleTapUp,
        onTapCancel: _handleTapCancel,
        child: TweenAnimationBuilder<_CardStyle>(
          tween: _CardStyleTween(begin: targetStyle, end: targetStyle),
          duration: widget.duration,
          curve: widget.curve,
          builder: (context, style, child) {
            return CustomPaint(
              painter: _CardPainter(
                color: style.color,
                borderRadius: style.borderRadius,
                elevation: style.elevation,
                shadowColor: style.shadowColor,
              ),
              child: child,
            );
          },
          // Optimization: Reuse the layout child
          child: _CardLayout(padding: widget.padding, child: widget.child),
        ),
      ),
    );
  }
}

/// Custom painter that draws the card background and shadow
class _CardPainter extends CustomPainter {
  final Color color;
  final double borderRadius;
  final double elevation;
  final Color shadowColor;

  // Material Design elevation scale - controls shadow opacity
  static const double _kShadowOpacityDivisor = 24.0;

  // Maximum shadow opacity to prevent overly dark shadows
  static const double _kMaxShadowOpacity = 0.3;

  _CardPainter({
    required this.color,
    required this.borderRadius,
    required this.elevation,
    required this.shadowColor,
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

      // Calculate shadow opacity based on elevation
      final double shadowOpacity = (elevation / _kShadowOpacityDivisor).clamp(
        0.0,
        _kMaxShadowOpacity,
      );
      
      final Color effectiveShadowColor = shadowColor.withValues(alpha: shadowOpacity);

      // Draw shadow using drawShadow
      canvas.drawShadow(
        shadowPath,
        effectiveShadowColor,
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
        oldDelegate.elevation != elevation ||
        oldDelegate.shadowColor != shadowColor;
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

// Implement Tween for _CardStyle
class _CardStyleTween extends Tween<_CardStyle> {
  _CardStyleTween({super.begin, super.end});

  @override
  _CardStyle lerp(double t) => _CardStyle.lerp(begin!, end!, t);
}
