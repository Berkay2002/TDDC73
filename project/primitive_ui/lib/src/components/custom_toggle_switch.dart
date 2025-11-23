import 'package:flutter/widgets.dart';

/// A toggle switch component built from scratch using CustomPaint and GestureDetector.
///
/// Features:
/// - Smooth animation when toggling
/// - Customizable colors for active/inactive states
/// - Tap to toggle functionality
/// - Visual feedback during state changes
///
/// This component uses only primitive Flutter APIs:
/// - CustomPaint for rendering
/// - Canvas for drawing
/// - GestureDetector for touch input
/// - AnimationController for smooth transitions
class CustomToggleSwitch extends StatefulWidget {
  /// Current toggle state (on/off)
  final bool value;

  /// Callback when the toggle is tapped
  final ValueChanged<bool> onChanged;

  /// Color when switch is on
  final Color activeColor;

  /// Color when switch is off
  final Color inactiveColor;

  /// Width of the switch
  final double width;

  /// Height of the switch
  final double height;

  /// Semantic label for accessibility
  final String? semanticsLabel;

  const CustomToggleSwitch({
    super.key,
    required this.value,
    required this.onChanged,
    this.activeColor = const Color(0xFF2196F3), // Blue
    this.inactiveColor = const Color(0xFF9E9E9E), // Grey
    this.width = 50.0,
    this.height = 30.0,
    this.semanticsLabel,
  }) : assert(
         width > height,
         'Width must exceed height for proper switch appearance',
       ),
       assert(width > 0 && height > 0, 'Dimensions must be positive');

  @override
  State<CustomToggleSwitch> createState() => _CustomToggleSwitchState();
}

class _CustomToggleSwitchState extends State<CustomToggleSwitch>
    with SingleTickerProviderStateMixin {
  // Animation duration for smooth but responsive feel
  static const int _kAnimationDurationMs = 200;

  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    // Create animation controller for smooth sliding
    _animationController = AnimationController(
      duration: const Duration(milliseconds: _kAnimationDurationMs),
      vsync: this,
    );

    // Create animation from 0.0 to 1.0
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );

    // Set initial animation value based on current state
    if (widget.value) {
      _animationController.value = 1.0;
    }
  }

  @override
  void didUpdateWidget(CustomToggleSwitch oldWidget) {
    super.didUpdateWidget(oldWidget);

    // Animate when value changes
    if (oldWidget.value != widget.value) {
      if (widget.value) {
        _animationController.forward();
      } else {
        _animationController.reverse();
      }
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _handleTap() {
    // Toggle the value
    widget.onChanged(!widget.value);
  }

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: widget.semanticsLabel ?? 'Toggle switch',
      toggled: widget.value,
      enabled: true,
      onTap: _handleTap,
      child: GestureDetector(
        onTap: _handleTap,
        child: SizedBox(
          width: widget.width,
          height: widget.height,
          child: AnimatedBuilder(
            animation: _animation,
            builder: (context, child) {
              return CustomPaint(
                painter: _ToggleSwitchPainter(
                  animationValue: _animation.value,
                  activeColor: widget.activeColor,
                  inactiveColor: widget.inactiveColor,
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

/// Custom painter that draws the toggle switch
class _ToggleSwitchPainter extends CustomPainter {
  final double animationValue; // 0.0 = off, 1.0 = on
  final Color activeColor;
  final Color inactiveColor;

  // Thumb radius ratio ensures visible thumb with comfortable tap target
  static const double _kThumbRadiusRatio = 0.4;

  // Subdued track color when inactive
  static const double _kTrackOpacity = 0.5;

  // Shadow properties for subtle depth effect
  static const double _kShadowBlurRadius = 2.0;
  static const double _kShadowYOffset = 1.0; // Simulates light from above

  _ToggleSwitchPainter({
    required this.animationValue,
    required this.activeColor,
    required this.inactiveColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final double trackHeight = size.height;
    final double trackWidth = size.width;
    final double trackRadius = trackHeight / 2;

    // Calculate thumb properties
    final double thumbRadius =
        trackHeight * _kThumbRadiusRatio; // Slightly smaller than track
    final double thumbPadding = (trackHeight - thumbRadius * 2) / 2;

    // Calculate thumb X position based on animation
    final double thumbMinX = thumbPadding + thumbRadius;
    final double thumbMaxX = trackWidth - thumbPadding - thumbRadius;
    final double thumbX = thumbMinX + (thumbMaxX - thumbMinX) * animationValue;

    // Interpolate colors based on animation value
    final Color trackColor = Color.lerp(
      inactiveColor.withValues(alpha: _kTrackOpacity),
      activeColor,
      animationValue,
    )!;

    // Draw the track (rounded rectangle)
    final RRect trackRect = RRect.fromRectAndRadius(
      Rect.fromLTWH(0, 0, trackWidth, trackHeight),
      Radius.circular(trackRadius),
    );

    final Paint trackPaint = Paint()
      ..color = trackColor
      ..style = PaintingStyle.fill;

    canvas.drawRRect(trackRect, trackPaint);

    // Draw the thumb (circle)
    final Offset thumbCenter = Offset(thumbX, trackHeight / 2);

    final Paint thumbPaint = Paint()
      ..color =
          const Color(0xFFFFFFFF) // White thumb
      ..style = PaintingStyle.fill;

    canvas.drawCircle(thumbCenter, thumbRadius, thumbPaint);

    // Add slight shadow to thumb for depth
    final Paint shadowPaint = Paint()
      ..color =
          const Color(0x40000000) // Semi-transparent black
      ..maskFilter = const MaskFilter.blur(
        BlurStyle.normal,
        _kShadowBlurRadius,
      );

    canvas.drawCircle(
      thumbCenter.translate(0, _kShadowYOffset), // Offset shadow slightly down
      thumbRadius,
      shadowPaint,
    );
  }

  @override
  bool shouldRepaint(_ToggleSwitchPainter oldDelegate) {
    return oldDelegate.animationValue != animationValue ||
        oldDelegate.activeColor != activeColor ||
        oldDelegate.inactiveColor != inactiveColor;
  }
}
