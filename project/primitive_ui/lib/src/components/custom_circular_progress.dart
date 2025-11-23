import 'dart:math' as math;
import 'package:flutter/widgets.dart';

/// A custom circular progress indicator built using [CustomPaint] and [AnimationController].
///
/// This component renders a spinning arc to indicate an indeterminate progress state,
/// or a fixed arc for determinate progress.
class CustomCircularProgress extends StatefulWidget {
  /// The current progress value, between 0.0 and 1.0.
  ///
  /// If null, the indicator is indeterminate and spins.
  final double? value;

  /// The color of the progress arc.
  final Color color;

  /// The width of the stroke.
  final double strokeWidth;

  /// The size of the indicator.
  final double size;

  const CustomCircularProgress({
    super.key,
    this.value,
    this.color = const Color(0xFF2196F3),
    this.strokeWidth = 4.0,
    this.size = 40.0,
  }) : assert(value == null || (value >= 0.0 && value <= 1.0), 'Value must be between 0.0 and 1.0');

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
    );
    if (widget.value == null) {
      _controller.repeat();
    }
  }

  @override
  void didUpdateWidget(CustomCircularProgress oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.value == null && !_controller.isAnimating) {
      _controller.repeat();
    } else if (widget.value != null && _controller.isAnimating) {
      _controller.stop();
    }
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
              progress: widget.value ?? _controller.value,
              isIndeterminate: widget.value == null,
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
  final bool isIndeterminate;
  final Color color;
  final double strokeWidth;

  _CircularProgressPainter({
    required this.progress,
    required this.isIndeterminate,
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

    canvas.save();
    canvas.translate(center, center);

    if (isIndeterminate) {
        // Rotate the whole canvas based on animation value
        canvas.rotate(progress * 2 * math.pi);
        
        // Fixed arc for indeterminate
        canvas.drawArc(
          Rect.fromCircle(center: Offset.zero, radius: radius),
          0.0,
          math.pi * 1.5,
          false,
          paint,
        );
    } else {
        // Rotate -90 degrees to start from top
        canvas.rotate(-math.pi / 2);
        
        // Draw arc based on progress value
        canvas.drawArc(
          Rect.fromCircle(center: Offset.zero, radius: radius),
          0.0,
          progress * 2 * math.pi,
          false,
          paint,
        );
    }

    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant _CircularProgressPainter oldDelegate) {
    return oldDelegate.progress != progress ||
        oldDelegate.isIndeterminate != isIndeterminate ||
        oldDelegate.color != color ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}