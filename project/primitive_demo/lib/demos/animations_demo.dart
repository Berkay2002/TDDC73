import 'package:flutter/material.dart';
import 'package:primitive_ui/primitive_ui.dart';

class AnimationsDemo extends StatefulWidget {
  const AnimationsDemo({super.key});

  @override
  State<AnimationsDemo> createState() => _AnimationsDemoState();
}

class _AnimationsDemoState extends State<AnimationsDemo> {
  bool _isCardSelected = false;
  double _sliderValue = 0.2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Implicit Animations Demo')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: VStack(
          spacing: 32.0,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Implicit Animations',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const Text(
              'Primitive UI components now automatically animate style changes.',
              style: TextStyle(color: Colors.grey),
            ),

            // Animated Card
            VStack(
              spacing: 16.0,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Animated PrimitiveCard',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                PrimitiveCard(
                  // Style properties animate automatically
                  color: _isCardSelected ? Colors.indigo : Colors.white,
                  elevation: _isCardSelected ? 12.0 : 2.0,
                  shadowColor: _isCardSelected ? Colors.indigo.withValues(alpha: 0.5) : Colors.black,
                  borderRadius: _isCardSelected ? 24.0 : 8.0,
                  
                  // Animation configuration
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeInOutBack,
                  
                  onTap: () => setState(() => _isCardSelected = !_isCardSelected),
                  child: Container(
                    height: 150,
                    padding: const EdgeInsets.all(16),
                    child: Center(
                      child: Text(
                        _isCardSelected ? 'Selected!\n(Elevation: 12)' : 'Tap Me\n(Elevation: 2)',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: _isCardSelected ? Colors.white : Colors.black87,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                const Text(
                  'Tap the card to toggle style (Color, Elevation, Radius)',
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),

            // Animated Slider
            VStack(
              spacing: 16.0,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Animated PrimitiveSlider',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                PrimitiveSlider(
                  value: _sliderValue,
                  onChanged: (v) => setState(() => _sliderValue = v),
                  activeColor: Colors.purple,
                  duration: const Duration(milliseconds: 800),
                  curve: Curves.elasticOut,
                ),
                HStack(
                  spacing: 8.0,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () => setState(() => _sliderValue = 0.0),
                      child: const Text('0%'),
                    ),
                    ElevatedButton(
                      onPressed: () => setState(() => _sliderValue = 0.5),
                      child: const Text('50%'),
                    ),
                    ElevatedButton(
                      onPressed: () => setState(() => _sliderValue = 1.0),
                      child: const Text('100%'),
                    ),
                  ],
                ),
                const Text(
                  'Buttons trigger smooth animations (800ms elastic). Dragging is still immediate.',
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
