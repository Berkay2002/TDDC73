/// Primitive UI Demo Application
///
/// This app demonstrates all components from the Primitive UI library,
/// which is built using only primitive Flutter components (CustomPaint,
/// Canvas, GestureDetector, and custom RenderBox).
///
/// Components demonstrated:
/// - PrimitiveCard: Container with shadow, rounded corners, and padding
/// - PrimitiveToggleSwitch: Animated toggle switch
/// - VStack: Vertical stack layout with spacing and alignment
/// - ZStack: Layered stack layout with z-ordering
///
/// The demo is organized into 6 sections:
/// 1. Header with dark mode toggle
/// 2. PrimitiveCard variations (different elevations, border radii)
/// 3. PrimitiveToggleSwitch examples (interactive toggles)
/// 4. VStack layout demos (all alignment modes)
/// 5. ZStack layout demos (layering examples)
/// 6. Combined components (practical usage patterns)
library;

import 'package:flutter/material.dart';
import 'package:primitive_ui/primitive_ui.dart';
import 'package:primitive_demo/demos/primitive_slider_demo.dart';
import 'package:primitive_demo/demos/primitive_circular_progress_demo.dart';
import 'package:primitive_demo/demos/v_stack_demo.dart';
import 'package:primitive_demo/demos/h_stack_flex_demo.dart';
import 'package:primitive_demo/demos/z_stack_positioned_demo.dart';
import 'package:primitive_demo/demos/accessibility_demo.dart';
import 'package:primitive_demo/demos/animations_demo.dart';
import 'package:primitive_demo/snippets.dart';

void main() {
  // Manual route parsing for robust deep linking
  String? initialRoute;
  try {
    final fragment = Uri.base.fragment;
    if (fragment.isNotEmpty) {
      // Remove leading # if present (though fragment usually doesn't have it)
      // and ensure it starts with /
      initialRoute = fragment.startsWith('/') ? fragment : '/$fragment';
      print('Parsed initial route from fragment: $initialRoute');
    }
  } catch (e) {
    print('Error parsing initial route: $e');
  }

  runApp(PrimitiveUIDemo(initialRoute: initialRoute));
}

/// Root application widget.
///
/// Sets up Material app with theme and navigation.
class PrimitiveUIDemo extends StatelessWidget {
  final String? initialRoute;
  
  const PrimitiveUIDemo({super.key, this.initialRoute});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Primitive UI Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: initialRoute ?? '/',
      routes: {
        '/': (context) => const DemoHomePage(),
        '/slider': (context) => const PrimitiveSliderDemo(),
        '/progress': (context) => const PrimitiveCircularProgressDemo(),
        '/vstack': (context) => const VStackDemo(),
        '/hstack': (context) => const HStackFlexDemo(),
        '/zstack': (context) => const ZStackPositionedDemo(),
        '/accessibility': (context) => const AccessibilityDemo(),
        '/animations': (context) => const AnimationsDemo(),
        
        // Snippets
        '/snippet/simple_card': (context) => const Scaffold(backgroundColor: Colors.transparent, body: SimpleCardSnippet()),
        '/snippet/custom_styled_card': (context) => const Scaffold(backgroundColor: Colors.transparent, body: CustomStyledCardSnippet()),
        '/snippet/basic_toggle': (context) => const Scaffold(backgroundColor: Colors.transparent, body: BasicToggleSnippet()),
        '/snippet/vstack_simple': (context) => const Scaffold(backgroundColor: Colors.transparent, body: VStackSimpleSnippet()),
        '/snippet/vstack_aligned': (context) => const Scaffold(backgroundColor: Colors.transparent, body: VStackAlignedSnippet()),
        '/snippet/zstack_simple': (context) => const Scaffold(backgroundColor: Colors.transparent, body: ZStackSimpleSnippet()),
        '/snippet/card_with_toggle': (context) => const Scaffold(backgroundColor: Colors.transparent, body: CardWithToggleSnippet()),
        '/snippet/vstack_with_cards': (context) => const Scaffold(backgroundColor: Colors.transparent, body: VStackWithCardsSnippet()),
        '/snippet/card_with_vstack': (context) => const Scaffold(backgroundColor: Colors.transparent, body: CardWithVStackSnippet()),
        '/snippet/settings_list': (context) => const Scaffold(backgroundColor: Colors.transparent, body: SettingsListSnippet()),
        '/snippet/info_card': (context) => const Scaffold(backgroundColor: Colors.transparent, body: InfoCardSnippet()),
        '/snippet/badge_overlay': (context) => const Scaffold(backgroundColor: Colors.transparent, body: BadgeOverlaySnippet()),
        '/snippet/grid_of_cards': (context) => const Scaffold(backgroundColor: Colors.transparent, body: GridOfCardsSnippet()),
        '/snippet/scrollable_list': (context) => const Scaffold(backgroundColor: Colors.transparent, body: ScrollableListSnippet()),
        '/snippet/stretched_layout': (context) => const Scaffold(backgroundColor: Colors.transparent, body: StretchedLayoutSnippet()),
        '/snippet/counter_card': (context) => const Scaffold(backgroundColor: Colors.transparent, body: CounterCardSnippet()),
        '/snippet/feedback_toggle': (context) => const Scaffold(backgroundColor: Colors.transparent, body: FeedbackToggleSnippet()),
        '/snippet/complex_form_layout': (context) => const Scaffold(backgroundColor: Colors.transparent, body: ComplexFormLayoutSnippet()),
        '/snippet/conditional_rendering': (context) => const Scaffold(backgroundColor: Colors.transparent, body: ConditionalRenderingSnippet()),
        '/snippet/image_card_with_overlay': (context) => const Scaffold(backgroundColor: Colors.transparent, body: ImageCardWithOverlaySnippet()),
        '/snippet/multi_layer_status': (context) => const Scaffold(
              backgroundColor: Colors.transparent,
              body: MultiLayerStatusIndicatorSnippet(),
            ),
        '/snippet/primitive_button': (context) => const Scaffold(
              backgroundColor: Colors.transparent,
              body: PrimitiveButtonSnippet(),
            ),
        '/snippet/primitive_input': (context) => const Scaffold(
              backgroundColor: Colors.transparent,
              body: PrimitiveInputSnippet(),
            ),
        '/snippet/settings_view_with_provider': (context) => const Scaffold(backgroundColor: Colors.transparent, body: SettingsViewWithProviderSnippet()),
        '/snippet/responsive_grid': (context) => const Scaffold(backgroundColor: Colors.transparent, body: ResponsiveGridSnippet()),
        '/snippet/themed_components': (context) => const Scaffold(backgroundColor: Colors.transparent, body: ThemedComponentsSnippet()),
        '/snippet/optimized_list': (context) => const Scaffold(backgroundColor: Colors.transparent, body: OptimizedListSnippet()),
        '/snippet/safe_card': (context) => const Scaffold(backgroundColor: Colors.transparent, body: SafeCardSnippet()),
        '/snippet/complete_dashboard': (context) => const Scaffold(backgroundColor: Colors.transparent, body: CompleteDashboardSnippet()),
      },
    );
  }
}

/// Main demo page with all component examples.
///
/// Manages state for all interactive components and demonstrates
/// how primitive components can be combined to create complex UIs.
class DemoHomePage extends StatefulWidget {
  const DemoHomePage({super.key});

  @override
  State<DemoHomePage> createState() => _DemoHomePageState();
}

/// State for the demo page.
///
/// Maintains state for all toggles and interactive elements.
class _DemoHomePageState extends State<DemoHomePage> {
  // State for toggle switches in different sections
  bool _toggle1 = false;
  bool _toggle2 = true;
  bool _toggle3 = false;
  bool _showCard = true;
  bool _darkMode = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _darkMode ? Colors.grey[900] : Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Primitive UI Demo'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        // Main layout using VStack - demonstrates vertical layout component
        child: VStack(
          spacing: 24.0,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // SECTION 1: Header with dark mode toggle
            _buildHeader(),

            // SECTION 2: PrimitiveCard variations
            _buildCardDemoSection(),

            // SECTION 3: PrimitiveToggleSwitch examples
            _buildToggleSwitchSection(),

            // SECTION 4: VStack alignment demonstrations
            _buildVStackDemoSection(),

            // SECTION 5: ZStack layering demonstrations
            _buildZStackDemoSection(),

            // SECTION 6: Combined components in practical patterns
            _buildCombinedExample(),

            // SECTION 7: New Components
            _buildNewComponentsSection(context),
          ],
        ),
      ),
    );
  }

  Widget _buildNewComponentsSection(BuildContext context) {
    return PrimitiveCard(
      color: _darkMode ? Colors.grey[850]! : Colors.white,
      elevation: 2.0,
      borderRadius: 12.0,
      padding: const EdgeInsets.all(20.0),
      child: VStack(
        spacing: 16.0,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Component Demos',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: _darkMode ? Colors.white : Colors.black87,
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, '/slider');
            },
            child: const Text('PrimitiveSlider Demo'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, '/progress');
            },
            child: const Text('PrimitiveCircularProgress Demo'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, '/vstack');
            },
            child: const Text('VStack Flexible Demo'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, '/hstack');
            },
            child: const Text('HStack Flex Demo'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, '/zstack');
            },
            child: const Text('ZStack Positioned Demo'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, '/accessibility');
            },
            child: const Text('Accessibility Demo (v0.0.4)'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, '/animations');
            },
            child: const Text('Implicit Animations Demo (v0.0.5)'),
          ),
        ],
      ),
    );
  }

  /// SECTION 1: Header with Dark Mode Toggle
  ///
  /// Demonstrates:
  /// - PrimitiveCard as a container
  /// - PrimitiveToggleSwitch controlling app-wide state
  /// - VStack for vertical layout inside card
  Widget _buildHeader() {
    return PrimitiveCard(
      color: _darkMode ? Colors.grey[850]! : Colors.white,
      elevation: 4.0,
      borderRadius: 12.0,
      padding: const EdgeInsets.all(20.0),
      child: VStack(
        spacing: 12.0,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Primitive UI Components',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: _darkMode ? Colors.white : Colors.black87,
            ),
          ),
          Text(
            'Built using only CustomPaint, Canvas, and GestureDetector',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              color: _darkMode ? Colors.grey[400] : Colors.grey[600],
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Dark Mode',
                style: TextStyle(
                  color: _darkMode ? Colors.white : Colors.black87,
                ),
              ),
              const SizedBox(width: 12),
              PrimitiveToggleSwitch(
                value: _darkMode,
                onChanged: (value) => setState(() => _darkMode = value),
                activeColor: Colors.deepPurple,
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// SECTION 2: PrimitiveCard Variations
  ///
  /// Demonstrates:
  /// - Different elevation levels (shadow depth)
  /// - Various border radius values
  /// - Custom background colors
  /// - How cards respond to theme changes
  Widget _buildCardDemoSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 12.0),
          child: Text(
            'PrimitiveCard Variations',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: _darkMode ? Colors.white : Colors.black87,
            ),
          ),
        ),
        VStack(
          spacing: 16.0,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            PrimitiveCard(
              color: Colors.blue[50]!,
              elevation: 1.0,
              borderRadius: 8.0,
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Low Elevation (1.0)',
                style: TextStyle(color: Colors.blue[900]),
              ),
            ),
            PrimitiveCard(
              color: Colors.green[50]!,
              elevation: 4.0,
              borderRadius: 12.0,
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Medium Elevation (4.0)',
                style: TextStyle(color: Colors.green[900]),
              ),
            ),
            PrimitiveCard(
              color: Colors.orange[50]!,
              elevation: 8.0,
              borderRadius: 16.0,
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'High Elevation (8.0)',
                style: TextStyle(color: Colors.orange[900]),
              ),
            ),
          ],
        ),
      ],
    );
  }

  /// SECTION 3: PrimitiveToggleSwitch Examples
  ///
  /// Demonstrates:
  /// - Interactive toggle switches
  /// - Smooth animations on state change
  /// - Custom colors (active/inactive)
  /// - Controlling UI visibility with toggles
  /// - Multiple independent toggle states
  Widget _buildToggleSwitchSection() {
    return PrimitiveCard(
      color: _darkMode ? Colors.grey[850]! : Colors.white,
      elevation: 2.0,
      borderRadius: 12.0,
      padding: const EdgeInsets.all(20.0),
      child: VStack(
        spacing: 16.0,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'PrimitiveToggleSwitch Examples',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: _darkMode ? Colors.white : Colors.black87,
            ),
          ),
          _buildToggleRow(
            'Toggle 1',
            _toggle1,
            (value) => setState(() => _toggle1 = value),
          ),
          _buildToggleRow(
            'Toggle 2',
            _toggle2,
            (value) => setState(() => _toggle2 = value),
          ),
          _buildToggleRow(
            'Toggle 3',
            _toggle3,
            (value) => setState(() => _toggle3 = value),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Show/Hide Card: ',
                style: TextStyle(
                  color: _darkMode ? Colors.white : Colors.black87,
                ),
              ),
              PrimitiveToggleSwitch(
                value: _showCard,
                onChanged: (value) => setState(() => _showCard = value),
                activeColor: Colors.green,
              ),
            ],
          ),
          if (_showCard)
            PrimitiveCard(
              color: Colors.green[100]!,
              elevation: 2.0,
              borderRadius: 8.0,
              padding: const EdgeInsets.all(12.0),
              child: const Text(
                '✓ This card is controlled by the toggle above!',
                style: TextStyle(color: Colors.green),
              ),
            ),
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
        Text(
          label,
          style: TextStyle(
            fontSize: 16,
            color: _darkMode ? Colors.white : Colors.black87,
          ),
        ),
        PrimitiveToggleSwitch(value: value, onChanged: onChanged),
      ],
    );
  }

  /// SECTION 4: VStack Layout Demonstrations
  ///
  /// Demonstrates:
  /// - All 4 alignment modes (start, center, end, stretch)
  /// - Custom spacing between children
  /// - How VStack handles different content types
  /// - Manual vertical layout without Column widget
  Widget _buildVStackDemoSection() {
    return PrimitiveCard(
      color: _darkMode ? Colors.grey[850]! : Colors.white,
      elevation: 2.0,
      borderRadius: 12.0,
      padding: const EdgeInsets.all(20.0),
      child: VStack(
        spacing: 16.0,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'VStack Layout Examples',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: _darkMode ? Colors.white : Colors.black87,
            ),
          ),
          Text(
            'Different alignments:',
            style: TextStyle(
              fontSize: 14,
              color: _darkMode ? Colors.grey[400] : Colors.grey[600],
            ),
          ),
          _buildAlignmentDemo('Start Alignment', CrossAxisAlignment.start),
          _buildAlignmentDemo('Center Alignment', CrossAxisAlignment.center),
          _buildAlignmentDemo('End Alignment', CrossAxisAlignment.end),
          _buildAlignmentDemo('Stretch Alignment', CrossAxisAlignment.stretch),
        ],
      ),
    );
  }

  /// Helper: Builds an alignment demo card.
  ///
  /// Shows how VStack children align based on the specified alignment mode.
  Widget _buildAlignmentDemo(String title, CrossAxisAlignment crossAxisAlignment) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 12,
            color: _darkMode ? Colors.grey[500] : Colors.grey[700],
          ),
        ),
        const SizedBox(height: 4),
        Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: _darkMode ? Colors.grey[700]! : Colors.grey[300]!,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.all(8.0),
          child: VStack(
            spacing: 8.0,
            crossAxisAlignment: crossAxisAlignment,
            children: [
              _buildColorBox(Colors.red, 'Item 1'),
              _buildColorBox(Colors.blue, 'Item 2'),
              _buildColorBox(Colors.green, 'Item 3'),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildColorBox(Color color, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(label, style: const TextStyle(color: Colors.white)),
    );
  }

  /// SECTION 5: ZStack Layout Demonstrations
  ///
  /// Demonstrates:
  /// - Layered widgets (z-ordering)
  /// - Alignment-based positioning
  /// - Practical badge overlay example
  /// - How ZStack differs from Flutter's Stack widget
  Widget _buildZStackDemoSection() {
    return PrimitiveCard(
      color: _darkMode ? Colors.grey[850]! : Colors.white,
      elevation: 2.0,
      borderRadius: 12.0,
      padding: const EdgeInsets.all(20.0),
      child: VStack(
        spacing: 16.0,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'ZStack Layout Examples',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: _darkMode ? Colors.white : Colors.black87,
            ),
          ),
          Text(
            'Layered components:',
            style: TextStyle(
              fontSize: 14,
              color: _darkMode ? Colors.grey[400] : Colors.grey[600],
            ),
          ),
          SizedBox(
            height: 200,
            child: ZStack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: 180,
                  height: 180,
                  decoration: BoxDecoration(
                    color: Colors.blue[200],
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                Container(
                  width: 140,
                  height: 140,
                  decoration: BoxDecoration(
                    color: Colors.purple[300],
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.pink[400],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Center(
                    child: Text(
                      'Layered',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Text(
            'Badge example:',
            style: TextStyle(
              fontSize: 14,
              color: _darkMode ? Colors.grey[400] : Colors.grey[600],
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: SizedBox(
              width: 80,
              height: 80,
              child: ZStack(
                alignment: Alignment.topRight,
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: Colors.grey[400],
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.notifications,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                  Container(
                    width: 24,
                    height: 24,
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                    child: const Center(
                      child: Text(
                        '5',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// SECTION 6: Combined Components Example
  ///
  /// Demonstrates:
  /// - Real-world settings panel pattern
  /// - All 4 components working together
  /// - Professional UI layout
  /// - Practical usage patterns for primitive components
  Widget _buildCombinedExample() {
    return PrimitiveCard(
      color: _darkMode ? Colors.grey[850]! : Colors.white,
      elevation: 3.0,
      borderRadius: 12.0,
      padding: const EdgeInsets.all(20.0),
      child: VStack(
        spacing: 16.0,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Combined Components Example',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: _darkMode ? Colors.white : Colors.black87,
            ),
          ),
          Text(
            'All primitive components working together:',
            style: TextStyle(
              fontSize: 14,
              color: _darkMode ? Colors.grey[400] : Colors.grey[600],
            ),
          ),
          VStack(
            spacing: 12.0,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              PrimitiveCard(
                color: Colors.indigo[100]!,
                elevation: 2.0,
                borderRadius: 8.0,
                padding: const EdgeInsets.all(16.0),
                child: VStack(
                  spacing: 12.0,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      'Settings Panel',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    VStack(
                      spacing: 8.0,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        _buildSettingRow(
                          'Notifications',
                          _toggle1,
                          (v) => setState(() => _toggle1 = v),
                        ),
                        _buildSettingRow(
                          'Auto-save',
                          _toggle2,
                          (v) => setState(() => _toggle2 = v),
                        ),
                        _buildSettingRow(
                          'Dark Theme',
                          _toggle3,
                          (v) => setState(() => _toggle3 = v),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            '✓ PrimitiveCard + VStack + PrimitiveToggleSwitch',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              fontStyle: FontStyle.italic,
              color: _darkMode ? Colors.grey[500] : Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingRow(
    String label,
    bool value,
    ValueChanged<bool> onChanged,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(label, style: const TextStyle(fontSize: 16)),
          ),
          PrimitiveToggleSwitch(
            value: value,
            onChanged: onChanged,
            activeColor: Colors.indigo,
          ),
        ],
      ),
    );
  }
}
