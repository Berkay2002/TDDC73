import 'package:flutter/material.dart';
import 'package:primitive_ui/primitive_ui.dart';
import 'package:provider/provider.dart'; // For the Provider example

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

class ComplexFormLayoutSnippet extends StatefulWidget {
  const ComplexFormLayoutSnippet({super.key});
  @override
  State<ComplexFormLayoutSnippet> createState() => _ComplexFormLayoutSnippetState();
}

class _ComplexFormLayoutSnippetState extends State<ComplexFormLayoutSnippet> {
  bool _emailNotifications = true;
  bool _pushNotifications = false;
  bool _smsNotifications = false;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: VStack(
          spacing: 24.0,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Header
            const Text(
              'Profile Settings',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),

            // Personal Info Section
            _buildSection(
              title: 'Personal Information',
              children: const [
                TextField(
                  decoration: InputDecoration(labelText: 'Name'),
                ),
                SizedBox(height: 16),
                TextField(
                  decoration: InputDecoration(labelText: 'Email'),
                ),
              ],
            ),

            // Notification Preferences
            _buildSection(
              title: 'Notifications',
              children: [
                _buildToggleRow(
                  'Email Notifications',
                  _emailNotifications,
                  (v) => setState(() => _emailNotifications = v),
                ),
                _buildToggleRow(
                  'Push Notifications',
                  _pushNotifications,
                  (v) => setState(() => _pushNotifications = v),
                ),
                _buildToggleRow(
                  'SMS Notifications',
                  _smsNotifications,
                  (v) => setState(() => _smsNotifications = v),
                ),
              ],
            ),

            // Actions
            ElevatedButton(
              onPressed: _saveSettings,
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 48),
              ),
              child: const Text('Save Changes'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection({
    required String title,
    required List<Widget> children,
  }) {
    return CustomCard(
      elevation: 2.0,
      child: VStack(
        spacing: 16.0,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          ...children,
        ],
      ),
    );
  }

  Widget _buildToggleRow(
    String label,
    bool value,
    ValueChanged<bool> onChanged,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label),
        CustomToggleSwitch(value: value, onChanged: onChanged),
      ],
    );
  }

  void _saveSettings() {
    // Save settings logic
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Settings saved!')),
    );
  }
}

class ConditionalRenderingSnippet extends StatefulWidget {
  const ConditionalRenderingSnippet({super.key});
  @override
  State<ConditionalRenderingSnippet> createState() => _ConditionalRenderingSnippetState();
}

class _ConditionalRenderingSnippetState extends State<ConditionalRenderingSnippet> {
  bool _isLoading = false;
  bool _hasError = false;
  List<String> _items = ['Item 1', 'Item 2', 'Item 3'];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: VStack(
        spacing: 16.0,
        children: [
          // Conditionally show loading state
          if (_isLoading)
            const CustomCard(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ),

          // Conditionally show error
          if (_hasError)
            CustomCard(
              color: const Color(0xFFFFEBEE),
              child: VStack(
                spacing: 8.0,
                children: [
                  const Icon(Icons.error, color: Colors.red),
                  const Text('Error loading data'),
                  ElevatedButton(
                    onPressed: _retry,
                    child: const Text('Retry'),
                  ),
                ],
              ),
            ),

          // Show items if not loading and no error
          if (!_isLoading && !_hasError)
            ..._items.map((item) => CustomCard(
              child: Text(item),
            )),

          // Show empty state
          if (!_isLoading && !_hasError && _items.isEmpty)
            CustomCard(
              child: VStack(
                spacing: 12.0,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [
                  Icon(Icons.inbox, size: 64, color: Colors.grey),
                  Text('No items yet'),
                ],
              ),
            ),
          
          ElevatedButton(
            onPressed: () {
              setState(() {
                if (_items.isEmpty) {
                  _items = ['Item 1', 'Item 2', 'Item 3'];
                  _hasError = false;
                  _isLoading = false;
                } else if (_isLoading) {
                  _isLoading = false;
                  _hasError = true;
                } else if (_hasError) {
                  _hasError = false;
                  _items = [];
                } else {
                  _isLoading = true;
                }
              });
            },
            child: const Text('Toggle State'),
          )
        ],
      ),
    );
  }

  void _retry() {
    setState(() {
      _hasError = false;
      _isLoading = true;
    });
    // Simulate loading
    Future.delayed(const Duration(seconds: 2), () {
      setState(() => _isLoading = false);
    });
  }
}

class ImageCardWithOverlaySnippet extends StatelessWidget {
  const ImageCardWithOverlaySnippet({super.key});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 300, // Constrain width for better demo
        height: 200,
        child: buildImageCard(
          imageUrl: 'https://picsum.photos/id/1018/300/200',
          title: 'Forest Landscape',
          subtitle: 'A serene view of nature',
          onTap: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Image Card Tapped!')),
            );
          },
        ),
      ),
    );
  }

  Widget buildImageCard({
    required String imageUrl,
    required String title,
    required String subtitle,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: CustomCard(
        padding: EdgeInsets.zero,
        child: ZStack(
          fit: ZStackFit.expand,
          children: [
            // Background image
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                imageUrl,
                fit: BoxFit.cover,
                height: 200,
              ),
            ),

            // Gradient overlay
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black.withOpacity(0.7),
                  ],
                ),
              ),
            ),

            // Text content
            CustomPositioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: VStack(
                  spacing: 4.0,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      subtitle,
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MultiLayerStatusIndicatorSnippet extends StatelessWidget {
  const MultiLayerStatusIndicatorSnippet({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ZStack(
        children: [
          // Base Circle (Outer Ring)
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.blue.withOpacity(0.2), width: 8),
            ),
          ),
          // Inner Indicator
          const CustomPositioned(
            top: 20,
            right: 20,
            child: Icon(Icons.check_circle, color: Colors.green, size: 30),
          ),
          // Centered Text
          const CustomPositioned(
            child: Text('95%', style: TextStyle(fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }
}

class PrimitiveButtonSnippet extends StatefulWidget {
  const PrimitiveButtonSnippet({super.key});

  @override
  State<PrimitiveButtonSnippet> createState() => _PrimitiveButtonSnippetState();
}

class _PrimitiveButtonSnippetState extends State<PrimitiveButtonSnippet> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Theme.of(context).dividerColor),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Variants', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 16),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                PrimitiveButton(
                  onPressed: () {},
                  child: const Text('Primary'),
                ),
                PrimitiveButton(
                  variant: PrimitiveButtonVariant.secondary,
                  onPressed: () {},
                  child: const Text('Secondary'),
                ),
                PrimitiveButton(
                  variant: PrimitiveButtonVariant.destructive,
                  onPressed: () {},
                  child: const Text('Destructive'),
                ),
                PrimitiveButton(
                  variant: PrimitiveButtonVariant.outline,
                  onPressed: () {},
                  child: const Text('Outline'),
                ),
                PrimitiveButton(
                  variant: PrimitiveButtonVariant.ghost,
                  onPressed: () {},
                  child: const Text('Ghost'),
                ),
                PrimitiveButton(
                  variant: PrimitiveButtonVariant.link,
                  onPressed: () {},
                  child: const Text('Link'),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Text('Sizes', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 16),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                PrimitiveButton(
                  size: PrimitiveButtonSize.sm,
                  onPressed: () {},
                  child: const Text('Small'),
                ),
                PrimitiveButton(
                  size: PrimitiveButtonSize.md,
                  onPressed: () {},
                  child: const Text('Medium'),
                ),
                PrimitiveButton(
                  size: PrimitiveButtonSize.lg,
                  onPressed: () {},
                  child: const Text('Large'),
                ),
                PrimitiveButton(
                  size: PrimitiveButtonSize.icon,
                  onPressed: () {},
                  child: const Icon(Icons.add, size: 16),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Text('States', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 16),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                PrimitiveButton(
                  onPressed: () {
                    setState(() => _isLoading = true);
                    Future.delayed(const Duration(seconds: 2), () {
                      if (mounted) setState(() => _isLoading = false);
                    });
                  },
                  isLoading: _isLoading,
                  child: const Text('Click to Load'),
                ),
                PrimitiveButton(
                  isDisabled: true,
                  onPressed: () {},
                  child: const Text('Disabled'),
                ),
                PrimitiveButton(
                  leading: const Icon(Icons.mail),
                  onPressed: () {},
                  child: const Text('Login with Email'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// Model for Provider example
class Settings {
  bool darkMode;
  bool notifications;

  Settings({
    this.darkMode = false,
    this.notifications = true,
  });
}

class SettingsNotifier extends ChangeNotifier {
  Settings _settings = Settings();

  Settings get settings => _settings;

  void toggleDarkMode() {
    _settings.darkMode = !_settings.darkMode;
    notifyListeners();
  }

  void toggleNotifications() {
    _settings.notifications = !_settings.notifications;
    notifyListeners();
  }
}

class SettingsViewWithProviderSnippet extends StatelessWidget {
  const SettingsViewWithProviderSnippet({super.key});
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SettingsNotifier(),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Consumer<SettingsNotifier>(
          builder: (context, notifier, child) {
            return VStack(
              spacing: 16.0,
              children: [
                CustomCard(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Dark Mode'),
                      CustomToggleSwitch(
                        value: notifier.settings.darkMode,
                        onChanged: (_) => notifier.toggleDarkMode(),
                      ),
                    ],
                  ),
                ),
                CustomCard(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Notifications'),
                      CustomToggleSwitch(
                        value: notifier.settings.notifications,
                        onChanged: (_) => notifier.toggleNotifications(),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class ResponsiveGridSnippet extends StatelessWidget {
  const ResponsiveGridSnippet({super.key});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 400, // Constrain height for the demo
      child: ResponsiveGrid(
        children: List.generate(
          6, // Reduced items for better demo visibility
          (index) => CustomCard(
            child: Center(child: Text('Card ${index + 1}')),
          ),
        ),
      ),
    );
  }
}

class ResponsiveGrid extends StatelessWidget {
  final List<Widget> children;

  const ResponsiveGrid({required this.children});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Determine column count based on width
        int columns = 1;
        if (constraints.maxWidth > 600) columns = 2;
        if (constraints.maxWidth > 900) columns = 3;

        return GridView.count(
          crossAxisCount: columns,
          padding: const EdgeInsets.all(16),
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          children: children,
        );
      },
    );
  }
}

class ThemedComponentsSnippet extends StatelessWidget {
  const ThemedComponentsSnippet({super.key});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: VStack(
          spacing: 16.0,
          children: [
            AppTheme.buildPrimaryCard(
              child: const Text(
                'Primary Themed Card',
                style: TextStyle(color: Colors.white),
              ),
            ),
            AppTheme.buildSurfaceCard(
              child: const Text('Surface Themed Card'),
            ),
            AppTheme.buildPrimaryToggle(
              value: true,
              onChanged: (_) {},
            ),
          ],
        ),
      ),
    );
  }
}

class AppTheme {
  static const Color primaryColor = Color(0xFF2196F3);
  static const Color surfaceColor = Color(0xFFFFFFFF);
  // static const Color errorColor = Color(0xFFF44336); // Not used in snippet

  static CustomCard buildPrimaryCard({required Widget child}) {
    return CustomCard(
      color: primaryColor,
      elevation: 4.0,
      borderRadius: 12.0,
      child: child,
    );
  }

  static CustomCard buildSurfaceCard({required Widget child}) {
    return CustomCard(
      color: surfaceColor,
      elevation: 2.0,
      borderRadius: 8.0,
      child: child,
    );
  }

  static CustomToggleSwitch buildPrimaryToggle({
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return CustomToggleSwitch(
      value: value,
      onChanged: onChanged,
      activeColor: primaryColor,
      inactiveColor: Colors.grey[400]!,
    );
  }
}

class OptimizedListSnippet extends StatefulWidget {
  const OptimizedListSnippet({super.key});
  @override
  State<OptimizedListSnippet> createState() => _OptimizedListSnippetState();
}

class _OptimizedListSnippetState extends State<OptimizedListSnippet> {
  List<String> _items = List.generate(10, (i) => 'Item $i'); // Reduced for demo

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300, // Constrain height for the demo
      child: ListView.builder(
        itemCount: _items.length,
        padding: const EdgeInsets.all(16),
        itemBuilder: (context, index) {
          return Padding(
            key: ValueKey(_items[index]), // Important for performance
            padding: const EdgeInsets.only(bottom: 16),
            child: CustomCard(
              child: Text(_items[index]),
            ),
          );
        },
      ),
    );
  }
}

class SafeCardSnippet extends StatelessWidget {
  const SafeCardSnippet({super.key});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: VStack(
          spacing: 16.0,
          children: [
            const SafeCard(
              child: Text('Content loaded successfully!'),
            ),
            const SafeCard(
              errorMessage: 'Failed to load data. Please try again.',
            ),
          ],
        ),
      ),
    );
  }
}

class SafeCard extends StatelessWidget {
  final Widget? child;
  final String? errorMessage;

  const SafeCard({
    super.key,
    this.child,
    this.errorMessage,
  });

  @override
  Widget build(BuildContext context) {
    if (errorMessage != null) {
      return CustomCard(
        color: const Color(0xFFFFEBEE),
        child: VStack(
          spacing: 8.0,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, color: Colors.red, size: 32),
            const Text(
              'Error',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.red,
              ),
            ),
            Text(
              errorMessage!,
              style: TextStyle(color: Colors.red[700]),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    }

    return CustomCard(child: child ?? const SizedBox.shrink());
  }
}

class CompleteDashboardSnippet extends StatefulWidget {
  const CompleteDashboardSnippet({super.key});
  @override
  State<CompleteDashboardSnippet> createState() => _CompleteDashboardSnippetState();
}

class _CompleteDashboardSnippetState extends State<CompleteDashboardSnippet> {
  bool _autoRefresh = true;
  // int _selectedTab = 0; // Not used in this snippet

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Settings button tapped!')),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: VStack(
            spacing: 24.0,
            children: [
              // Stats row
              _buildStatsRow(),

              // Settings
              CustomCard(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    VStack(
                      spacing: 4.0,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          'Auto Refresh',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Refresh data every 30 seconds',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                    CustomToggleSwitch(
                      value: _autoRefresh,
                      onChanged: (v) => setState(() => _autoRefresh = v),
                    ),
                  ],
                ),
              ),

              // Recent activity
              _buildRecentActivity(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatsRow() {
    return Row(
      children: [
        Expanded(child: _buildStatCard('Users', '1,234', Icons.people)),
        const SizedBox(width: 16),
        Expanded(child: _buildStatCard('Revenue', '\$45K', Icons.attach_money)),
      ],
    );
  }

  Widget _buildStatCard(String label, String value, IconData icon) {
    return CustomCard(
      elevation: 3.0,
      child: VStack(
        spacing: 8.0,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(icon, size: 32, color: Colors.blue),
          Text(
            value,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          Text(
            label,
            style: TextStyle(fontSize: 12, color: Colors.grey[600]),
          ),
        ],
      ),
    );
  }

  Widget _buildRecentActivity() {
    return VStack(
      spacing: 12.0,
      children: [
        const Text(
          'Recent Activity',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        ...List.generate(
          3, // Reduced for demo
          (i) => CustomCard(
            child: Row(
              children: [
                Icon(Icons.circle, size: 8, color: Colors.blue),
                const SizedBox(width: 12),
                Expanded(child: Text('Activity item ${i + 1}')),
                Text(
                  '${i + 1}m ago',
                  style: TextStyle(color: Colors.grey[600], fontSize: 12),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}