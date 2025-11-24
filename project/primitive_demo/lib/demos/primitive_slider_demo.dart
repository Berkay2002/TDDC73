import 'package:flutter/material.dart';
import 'package:primitive_ui/primitive_ui.dart';

class PrimitiveSliderDemo extends StatefulWidget {
  const PrimitiveSliderDemo({super.key});

  @override
  State<PrimitiveSliderDemo> createState() => _PrimitiveSliderDemoState();
}

class _PrimitiveSliderDemoState extends State<PrimitiveSliderDemo> {
  double _value1 = 0.5;
  double _value2 = 25.0;
  double _value3 = 0.75;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('PrimitiveSlider Demo')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: VStack(
          spacing: 32.0,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Basic Slider
            VStack(
              spacing: 8.0,
              children: [
                const Text(
                  'Basic Slider (0.0 - 1.0)',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Text('Value: ${_value1.toStringAsFixed(2)}'),
                PrimitiveSlider(
                  value: _value1,
                  onChanged: (value) => setState(() => _value1 = value),
                ),
              ],
            ),

            // Custom Range
            VStack(
              spacing: 8.0,
              children: [
                const Text(
                  'Custom Range (0 - 100)',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Text('Value: ${_value2.toStringAsFixed(1)}'),
                PrimitiveSlider(
                  value: _value2,
                  min: 0.0,
                  max: 100.0,
                  activeColor: Colors.orange,
                  inactiveColor: Colors.orange.withValues(alpha: 0.2),
                  onChanged: (value) => setState(() => _value2 = value),
                ),
              ],
            ),

            // Custom Style
            VStack(
              spacing: 8.0,
              children: [
                const Text(
                  'Custom Style (Large Thumb)',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Text('Value: ${_value3.toStringAsFixed(2)}'),
                PrimitiveSlider(
                  value: _value3,
                  thumbRadius: 16.0,
                  trackHeight: 8.0,
                  activeColor: Colors.purple,
                  inactiveColor: Colors.purple.withValues(alpha: 0.2),
                  onChanged: (value) => setState(() => _value3 = value),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
