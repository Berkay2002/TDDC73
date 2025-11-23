import 'dart:math' as math;
import 'package:flutter/widgets.dart';

/// A custom circular progress indicator built using [CustomPaint] and [AnimationController].
///
/// This component renders a spinning arc to indicate an indeterminate progress state.
class CustomCircularProgress extends StatefulWidget {
  /// The color of the progress arc.
  final Color color;

  /// The width of the stroke.
  final double strokeWidth;

  /// The size of the indicator.
  final double size;

  const CustomCircularProgress({
    super.key,
    this.color = const Color(0xFF2196F3),
    this.strokeWidth = 4.0,
    this.size = 40.0,
  });

  @override
  State<CustomCircularProgress> createState() => _CustomCircularProgressState();
}

class _CustomCircularProgressState extends State<CustomCircularProgress>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.size,
      height: widget.size,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return CustomPaint(
            painter: _CircularProgressPainter(
              progress: _controller.value,
              color: widget.color,
              strokeWidth: widget.strokeWidth,
            ),
          );
        },
      ),
    );
  }
}

class _CircularProgressPainter extends CustomPainter {
  final double progress;
  final Color color;
  final double strokeWidth;

  _CircularProgressPainter({
    required this.progress,
    required this.color,
    required this.strokeWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    final double center = size.width / 2;
    final double radius = (size.width - strokeWidth) / 2;

    // We want the arc to grow and shrink while rotating
    // This mimics the Material design progress indicator behavior roughly

    // Rotate the whole canvas based on progress
    canvas.save();
    canvas.translate(center, center);
    canvas.rotate(progress * 2 * math.pi);

    // Draw the arc
    // The sweep angle can vary to create the "worm" effect
    // For simplicity in this primitive version, we can just do a fixed arc that rotates
    // Or we can do a simple varying arc.

    // Let's do a simple fixed arc for now as a "primitive" implementation
    // const double startAngle = -math.pi / 2;
    // const double sweepAngle = 3 * math.pi / 2; // 270 degrees

    // canvas.drawArc(
    //   Rect.fromCircle(center: Offset.zero, radius: radius),
    //   startAngle,
    //   sweepAngle,
    //   false,
    //   paint,
    // );

    // Better: "Worm" effect
    // 0.0 -> 0.5: Head moves faster than tail (growing)
    // 0.5 -> 1.0: Tail moves faster than head (shrinking)

    // This is a bit complex for a "primitive" demo, but let's try a simplified version.
    // Just a rotating arc of 270 degrees is fine for a basic primitive.

    canvas.drawArc(
      Rect.fromCircle(center: Offset.zero, radius: radius),
      0.0,
      math.pi * 1.5,
      false,
      paint,
    );

    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant _CircularProgressPainter oldDelegate) {
    return oldDelegate.progress != progress ||
        oldDelegate.color != color ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
