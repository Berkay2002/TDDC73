import 'package:flutter/material.dart';
import 'package:primitive_ui/primitive_ui.dart';

class AccessibilityDemo extends StatefulWidget {
  const AccessibilityDemo({super.key});

  @override
  State<AccessibilityDemo> createState() => _AccessibilityDemoState();
}

class _AccessibilityDemoState extends State<AccessibilityDemo> {
  bool _notifications = true;
  double _volume = 0.5;
  double _brightness = 0.8;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Accessibility Demo (v0.0.4)')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: VStack(
          spacing: 24.0,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'WAI-ARIA Compliance Test',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const Text(
              'Enable TalkBack/VoiceOver to test semantic labels and actions.',
              style: TextStyle(color: Colors.grey),
            ),

            // Card with Semantic Label
            PrimitiveCard(
              semanticsLabel: 'Information Card. Double tap to acknowledge.',
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Card acknowledged')),
                );
              },
              child: const VStack(
                spacing: 8.0,
                children: [
                  Text('Accessible Card', style: TextStyle(fontWeight: FontWeight.bold)),
                  Text('This card has a custom semantic label and behaves as a button.'),
                ],
              ),
            ),

            // Toggles with Semantic Labels
            PrimitiveCard(
              child: VStack(
                spacing: 16.0,
                children: [
                  const Text('Settings', style: TextStyle(fontWeight: FontWeight.bold)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Enable Notifications'),
                      PrimitiveToggleSwitch(
                        value: _notifications,
                        onChanged: (v) => setState(() => _notifications = v),
                        semanticsLabel: 'Enable Notifications Switch',
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Sliders with Semantic Steps
            PrimitiveCard(
              child: VStack(
                spacing: 16.0,
                children: [
                  const Text('Audio & Display', style: TextStyle(fontWeight: FontWeight.bold)),
                  VStack(
                    spacing: 8.0,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Text('Volume (Step: 10%)'),
                      PrimitiveSlider(
                        value: _volume,
                        onChanged: (v) => setState(() => _volume = v),
                        semanticsLabel: 'Media Volume',
                        semanticsStep: 0.1, // 10% step
                      ),
                    ],
                  ),
                  VStack(
                    spacing: 8.0,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Text('Brightness (Step: 20%)'),
                      PrimitiveSlider(
                        value: _brightness,
                        onChanged: (v) => setState(() => _brightness = v),
                        activeColor: Colors.orange,
                        semanticsLabel: 'Screen Brightness',
                        semanticsStep: 0.2, // 20% step
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Progress with Semantic Label
            PrimitiveCard(
              child: VStack(
                spacing: 16.0,
                children: [
                  const Text('Status', style: TextStyle(fontWeight: FontWeight.bold)),
                  HStack(
                    spacing: 16.0,
                    children: [
                      const PrimitiveCircularProgress(
                        semanticsLabel: 'Loading user data',
                      ),
                      const Text('Indeterminate Loading'),
                    ],
                  ),
                  HStack(
                    spacing: 16.0,
                    children: [
                      const PrimitiveCircularProgress(
                        value: 0.75,
                        color: Colors.green,
                        semanticsLabel: 'Upload Progress',
                      ),
                      const Text('Determinate (75%)'),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
