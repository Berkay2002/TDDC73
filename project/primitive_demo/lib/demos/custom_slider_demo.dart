import 'package:flutter/material.dart';
import 'package:primitive_ui/primitive_ui.dart';

class CustomSliderDemo extends StatefulWidget {
  const CustomSliderDemo({super.key});

  @override
  State<CustomSliderDemo> createState() => _CustomSliderDemoState();
}

class _CustomSliderDemoState extends State<CustomSliderDemo> {
  double _value1 = 0.5;
  double _value2 = 25.0;
  double _value3 = 0.75;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('CustomSlider Demo')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: VStack(
          spacing: 32.0,
          alignment: VStackAlignment.stretch,
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
                CustomSlider(
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
                CustomSlider(
                  value: _value2,
                  min: 0.0,
                  max: 100.0,
                  activeColor: Colors.orange,
                  inactiveColor: Colors.orange.withOpacity(0.2),
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
                CustomSlider(
                  value: _value3,
                  thumbRadius: 16.0,
                  trackHeight: 8.0,
                  activeColor: Colors.purple,
                  inactiveColor: Colors.purple.withOpacity(0.2),
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
