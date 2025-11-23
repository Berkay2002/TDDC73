import 'package:flutter/widgets.dart';

/// A custom slider component built using [CustomPaint] and [GestureDetector].
///
/// This component renders a horizontal track and a draggable thumb.
/// It does not use the material [Slider] widget.
class CustomSlider extends StatefulWidget {
  /// The current value of the slider, between [min] and [max].
  final double value;

  /// The minimum value of the slider. Defaults to 0.0.
  final double min;

  /// The maximum value of the slider. Defaults to 1.0.
  final double max;

  /// Called when the value of the slider changes.
  final ValueChanged<double>? onChanged;

  /// The color of the active track and thumb.
  final Color activeColor;

  /// The color of the inactive track.
  final Color inactiveColor;

  /// The radius of the thumb.
  final double thumbRadius;

  /// The height of the track.
  final double trackHeight;

  const CustomSlider({
    super.key,
    required this.value,
    this.onChanged,
    this.min = 0.0,
    this.max = 1.0,
    this.activeColor = const Color(0xFF2196F3),
    this.inactiveColor = const Color(0xFFE0E0E0),
    this.thumbRadius = 10.0,
    this.trackHeight = 4.0,
  }) : assert(value >= min && value <= max);

  @override
  State<CustomSlider> createState() => _CustomSliderState();
}

class _CustomSliderState extends State<CustomSlider> {
  void _handleDragUpdate(
    DragUpdateDetails details,
    BoxConstraints constraints,
  ) {
    if (widget.onChanged == null) return;

    final RenderBox box = context.findRenderObject() as RenderBox;
    final double localDx = box.globalToLocal(details.globalPosition).dx;
    final double width = constraints.maxWidth;

    // Account for padding/thumb radius if necessary, but for simplicity we map 0..width
    // A more robust implementation would inset by thumbRadius.
    final double effectiveWidth = width - (widget.thumbRadius * 2);
    final double relativeDx = localDx - widget.thumbRadius;

    double percent = relativeDx / effectiveWidth;
    percent = percent.clamp(0.0, 1.0);

    final double newValue = widget.min + percent * (widget.max - widget.min);

    if (newValue != widget.value) {
      widget.onChanged!(newValue);
    }
  }

  void _handleTapDown(TapDownDetails details, BoxConstraints constraints) {
    if (widget.onChanged == null) return;

    final double localDx = details.localPosition.dx;
    final double width = constraints.maxWidth;

    final double effectiveWidth = width - (widget.thumbRadius * 2);
    final double relativeDx = localDx - widget.thumbRadius;

    double percent = relativeDx / effectiveWidth;
    percent = percent.clamp(0.0, 1.0);

    final double newValue = widget.min + percent * (widget.max - widget.min);

    if (newValue != widget.value) {
      widget.onChanged!(newValue);
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // If unbounded width, give it a default
        final double width = constraints.hasBoundedWidth
            ? constraints.maxWidth
            : 200.0;
        final double height = widget.thumbRadius * 2;

        return GestureDetector(
          onHorizontalDragUpdate: (details) =>
              _handleDragUpdate(details, BoxConstraints(maxWidth: width)),
          onTapDown: (details) =>
              _handleTapDown(details, BoxConstraints(maxWidth: width)),
          child: SizedBox(
            width: width,
            height: height,
            child: CustomPaint(
              painter: _SliderPainter(
                value: widget.value,
                min: widget.min,
                max: widget.max,
                activeColor: widget.activeColor,
                inactiveColor: widget.inactiveColor,
                thumbRadius: widget.thumbRadius,
                trackHeight: widget.trackHeight,
              ),
            ),
          ),
        );
      },
    );
  }
}

class _SliderPainter extends CustomPainter {
  final double value;
  final double min;
  final double max;
  final Color activeColor;
  final Color inactiveColor;
  final double thumbRadius;
  final double trackHeight;

  _SliderPainter({
    required this.value,
    required this.min,
    required this.max,
    required this.activeColor,
    required this.inactiveColor,
    required this.thumbRadius,
    required this.trackHeight,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint trackPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = trackHeight
      ..strokeCap = StrokeCap.round;

    final double centerY = size.height / 2;
    final double trackLeft = thumbRadius;
    final double trackRight = size.width - thumbRadius;
    final double trackWidth = trackRight - trackLeft;

    // Calculate thumb position
    final double percent = (value - min) / (max - min);
    final double thumbX = trackLeft + (percent * trackWidth);

    // Draw inactive track
    trackPaint.color = inactiveColor;
    canvas.drawLine(
      Offset(trackLeft, centerY),
      Offset(trackRight, centerY),
      trackPaint,
    );

    // Draw active track
    trackPaint.color = activeColor;
    canvas.drawLine(
      Offset(trackLeft, centerY),
      Offset(thumbX, centerY),
      trackPaint,
    );

    // Draw thumb
    final Paint thumbPaint = Paint()
      ..color = activeColor
      ..style = PaintingStyle.fill;

    canvas.drawCircle(Offset(thumbX, centerY), thumbRadius, thumbPaint);

    // Optional: Draw shadow for thumb
    final Path thumbPath = Path()
      ..addOval(
        Rect.fromCircle(center: Offset(thumbX, centerY), radius: thumbRadius),
      );
    canvas.drawShadow(thumbPath, const Color(0x44000000), 2.0, true);
  }

  @override
  bool shouldRepaint(covariant _SliderPainter oldDelegate) {
    return oldDelegate.value != value ||
        oldDelegate.min != min ||
        oldDelegate.max != max ||
        oldDelegate.activeColor != activeColor ||
        oldDelegate.inactiveColor != inactiveColor ||
        oldDelegate.thumbRadius != thumbRadius ||
        oldDelegate.trackHeight != trackHeight;
  }
}
