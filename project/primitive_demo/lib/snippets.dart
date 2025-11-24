import 'package:flutter/material.dart';
import 'package:primitive_ui/primitive_ui.dart';

// --- Basic Usage Snippets ---

class SimpleCardSnippet extends StatelessWidget {
  const SimpleCardSnippet({super.key});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: CustomCard(
        child: const Text('Hello, Primitive UI!'),
      ),
    );
  }
}

class CustomStyledCardSnippet extends StatelessWidget {
  const CustomStyledCardSnippet({super.key});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: CustomCard(
        color: const Color(0xFFF5F5F5), // Light grey
        borderRadius: 12.0,
        elevation: 4.0,
        padding: const EdgeInsets.all(20.0),
        child: const Text(
          'Custom Styled Card',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}

class BasicToggleSnippet extends StatefulWidget {
  const BasicToggleSnippet({super.key});
  @override
  State<BasicToggleSnippet> createState() => _BasicToggleSnippetState();
}

class _BasicToggleSnippetState extends State<BasicToggleSnippet> {
  bool _isEnabled = false;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CustomToggleSwitch(
        value: _isEnabled,
        onChanged: (newValue) {
          setState(() {
            _isEnabled = newValue;
          });
        },
      ),
    );
  }
}

class VStackSimpleSnippet extends StatelessWidget {
  const VStackSimpleSnippet({super.key});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: CustomCard(
        child: VStack(
          spacing: 16.0,
          children: const [
            Text('Item 1'),
            Text('Item 2'),
            Text('Item 3'),
          ],
        ),
      ),
    );
  }
}

class VStackAlignedSnippet extends StatelessWidget {
  const VStackAlignedSnippet({super.key});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: CustomCard(
        child: VStack(
          spacing: 12.0,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text('Centered'),
            Container(width: 100, height: 50, color: Colors.blue),
            const Text('All Centered'),
          ],
        ),
      ),
    );
  }
}

class ZStackSimpleSnippet extends StatelessWidget {
  const ZStackSimpleSnippet({super.key});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ZStack(
        alignment: Alignment.center,
        children: [
          Container(
            width: 200,
            height: 200,
            color: Colors.blue,
          ),
          const Icon(Icons.star, size: 100, color: Colors.yellow),
        ],
      ),
    );
  }
}

class CardWithToggleSnippet extends StatefulWidget {
  const CardWithToggleSnippet({super.key});
  @override
  State<CardWithToggleSnippet> createState() => _CardWithToggleSnippetState();
}

class _CardWithToggleSnippetState extends State<CardWithToggleSnippet> {
  bool _enabled = false;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: CustomCard(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Enable Feature'),
              CustomToggleSwitch(
                value: _enabled,
                onChanged: (value) {
                  setState(() => _enabled = value);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class VStackWithCardsSnippet extends StatelessWidget {
  const VStackWithCardsSnippet({super.key});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: VStack(
          spacing: 16.0,
          children: [
            CustomCard(child: const Text('Card 1')),
            CustomCard(child: const Text('Card 2')),
            CustomCard(child: const Text('Card 3')),
          ],
        ),
      ),
    );
  }
}

class CardWithVStackSnippet extends StatelessWidget {
  const CardWithVStackSnippet({super.key});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: CustomCard(
        elevation: 4.0,
        child: VStack(
          spacing: 12.0,
          children: const [
            Text(
              'Title',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text('Subtitle'),
            Text('Content goes here...'),
          ],
        ),
      ),
    );
  }
}

class SettingsListSnippet extends StatefulWidget {
  const SettingsListSnippet({super.key});
  @override
  State<SettingsListSnippet> createState() => _SettingsListSnippetState();
}

class _SettingsListSnippetState extends State<SettingsListSnippet> {
  bool _notifications = true;
  bool _darkMode = false;
  bool _autoSave = true;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: VStack(
          spacing: 12.0,
          children: [
            _buildSettingItem('Notifications', _notifications, (v) {
              setState(() => _notifications = v);
            }),
            _buildSettingItem('Dark Mode', _darkMode, (v) {
              setState(() => _darkMode = v);
            }),
            _buildSettingItem('Auto-save', _autoSave, (v) {
              setState(() => _autoSave = v);
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingItem(
    String label,
    bool value,
    ValueChanged<bool> onChanged,
  ) {
    return CustomCard(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontSize: 16)),
          CustomToggleSwitch(value: value, onChanged: onChanged),
        ],
      ),
    );
  }
}

class InfoCardSnippet extends StatelessWidget {
  const InfoCardSnippet({super.key});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: CustomCard(
        elevation: 2.0,
        borderRadius: 12.0,
        child: VStack(
          spacing: 8.0,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Icon(Icons.info, size: 40, color: Colors.blue),
            const Text(
              'Information',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'This is an important message.',
              style: TextStyle(color: Colors.grey[600]),
            ),
          ],
        ),
      ),
    );
  }
}

class BadgeOverlaySnippet extends StatelessWidget {
  const BadgeOverlaySnippet({super.key});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ZStack(
        alignment: Alignment.topRight,
        children: [
          CustomCard(
            child: Container(
              width: 100,
              height: 100,
              child: const Center(child: Text('Content')),
            ),
          ),
          Container(
            margin: const EdgeInsets.all(8),
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Text(
              'NEW',
              style: TextStyle(
                color: Colors.white,
                fontSize: 10,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class GridOfCardsSnippet extends StatelessWidget {
  const GridOfCardsSnippet({super.key});
  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      padding: const EdgeInsets.all(16),
      mainAxisSpacing: 16,
      crossAxisSpacing: 16,
      children: [
        CustomCard(child: const Center(child: Text('Card 1'))),
        CustomCard(child: const Center(child: Text('Card 2'))),
        CustomCard(child: const Center(child: Text('Card 3'))),
        CustomCard(child: const Center(child: Text('Card 4'))),
      ],
    );
  }
}

class ScrollableListSnippet extends StatelessWidget {
  const ScrollableListSnippet({super.key});
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: VStack(
          spacing: 16.0,
          children: List.generate(
            20,
            (index) => CustomCard(
              child: Text('Item ${index + 1}'),
            ),
          ),
        ),
      ),
    );
  }
}

class StretchedLayoutSnippet extends StatelessWidget {
  const StretchedLayoutSnippet({super.key});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: VStack(
          spacing: 16.0,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CustomCard(
              child: Container(height: 50, child: const Center(child: Text('Full Width 1'))),
            ),
            CustomCard(
              child: Container(height: 50, child: const Center(child: Text('Full Width 2'))),
            ),
          ],
        ),
      ),
    );
  }
}

class CounterCardSnippet extends StatefulWidget {
  const CounterCardSnippet({super.key});
  @override
  State<CounterCardSnippet> createState() => _CounterCardSnippetState();
}

class _CounterCardSnippetState extends State<CounterCardSnippet> {
  int _count = 0;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CustomCard(
        elevation: 4.0,
        child: VStack(
          spacing: 16.0,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Counter',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Text(
              '$_count',
              style: const TextStyle(fontSize: 48, color: Colors.blue),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () => setState(() => _count--),
                  child: const Icon(Icons.remove),
                ),
                const SizedBox(width: 16),
                ElevatedButton(
                  onPressed: () => setState(() => _count++),
                  child: const Icon(Icons.add),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class FeedbackToggleSnippet extends StatefulWidget {
  const FeedbackToggleSnippet({super.key});
  @override
  State<FeedbackToggleSnippet> createState() => _FeedbackToggleSnippetState();
}

class _FeedbackToggleSnippetState extends State<FeedbackToggleSnippet> {
  bool _isEnabled = false;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CustomCard(
        child: VStack(
          spacing: 12.0,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Feature Status'),
                CustomToggleSwitch(
                  value: _isEnabled,
                  onChanged: (value) {
                    setState(() => _isEnabled = value);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'Feature ${value ? "enabled" : "disabled"}',
                        ),
                        duration: const Duration(seconds: 1),
                      ),
                    );
                  },
                ),
              ],
            ),
            Text(
              'Status: ${_isEnabled ? "ON" : "OFF"}',
              style: TextStyle(
                color: _isEnabled ? Colors.green : Colors.grey,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// --- Advanced Patterns Snippets (Selected) ---

class AnimatedCardSnippet extends StatefulWidget {
  const AnimatedCardSnippet({super.key});
  @override
  State<AnimatedCardSnippet> createState() => _AnimatedCardSnippetState();
}

class _AnimatedCardSnippetState extends State<AnimatedCardSnippet>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _elevationAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _elevationAnimation = Tween<double>(begin: 2.0, end: 8.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTapDown: (_) => _controller.forward(),
        onTapUp: (_) => _controller.reverse(),
        onTapCancel: () => _controller.reverse(),
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Transform.scale(
              scale: _scaleAnimation.value,
              child: CustomCard(
                elevation: _elevationAnimation.value,
                padding: const EdgeInsets.all(32),
                child: const Text('Tap Me (Animated)', style: TextStyle(fontSize: 18)),
              ),
            );
          },
        ),
      ),
    );
  }
}
