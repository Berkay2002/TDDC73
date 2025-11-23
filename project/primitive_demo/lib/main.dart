import 'package:flutter/material.dart';
import 'package:primitive_ui/primitive_ui.dart';

void main() {
  runApp(const PrimitiveUIDemo());
}

class PrimitiveUIDemo extends StatelessWidget {
  const PrimitiveUIDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Primitive UI Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const DemoHomePage(),
    );
  }
}

class DemoHomePage extends StatefulWidget {
  const DemoHomePage({super.key});

  @override
  State<DemoHomePage> createState() => _DemoHomePageState();
}

class _DemoHomePageState extends State<DemoHomePage> {
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
        child: VStack(
          spacing: 24.0,
          alignment: VStackAlignment.stretch,
          children: [
            // Header Section
            _buildHeader(),

            // CustomCard Demo Section
            _buildCardDemoSection(),

            // CustomToggleSwitch Demo Section
            _buildToggleSwitchSection(),

            // VStack Demo Section
            _buildVStackDemoSection(),

            // ZStack Demo Section
            _buildZStackDemoSection(),

            // Combined Example
            _buildCombinedExample(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return CustomCard(
      color: _darkMode ? Colors.grey[850]! : Colors.white,
      elevation: 4.0,
      borderRadius: 12.0,
      padding: const EdgeInsets.all(20.0),
      child: VStack(
        spacing: 12.0,
        alignment: VStackAlignment.center,
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
              CustomToggleSwitch(
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

  Widget _buildCardDemoSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 12.0),
          child: Text(
            'CustomCard Variations',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: _darkMode ? Colors.white : Colors.black87,
            ),
          ),
        ),
        VStack(
          spacing: 16.0,
          alignment: VStackAlignment.stretch,
          children: [
            CustomCard(
              color: Colors.blue[50]!,
              elevation: 1.0,
              borderRadius: 8.0,
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Low Elevation (1.0)',
                style: TextStyle(color: Colors.blue[900]),
              ),
            ),
            CustomCard(
              color: Colors.green[50]!,
              elevation: 4.0,
              borderRadius: 12.0,
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Medium Elevation (4.0)',
                style: TextStyle(color: Colors.green[900]),
              ),
            ),
            CustomCard(
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

  Widget _buildToggleSwitchSection() {
    return CustomCard(
      color: _darkMode ? Colors.grey[850]! : Colors.white,
      elevation: 2.0,
      borderRadius: 12.0,
      padding: const EdgeInsets.all(20.0),
      child: VStack(
        spacing: 16.0,
        alignment: VStackAlignment.stretch,
        children: [
          Text(
            'CustomToggleSwitch Examples',
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
              CustomToggleSwitch(
                value: _showCard,
                onChanged: (value) => setState(() => _showCard = value),
                activeColor: Colors.green,
              ),
            ],
          ),
          if (_showCard)
            CustomCard(
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
        CustomToggleSwitch(value: value, onChanged: onChanged),
      ],
    );
  }

  Widget _buildVStackDemoSection() {
    return CustomCard(
      color: _darkMode ? Colors.grey[850]! : Colors.white,
      elevation: 2.0,
      borderRadius: 12.0,
      padding: const EdgeInsets.all(20.0),
      child: VStack(
        spacing: 16.0,
        alignment: VStackAlignment.stretch,
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
          _buildAlignmentDemo('Start Alignment', VStackAlignment.start),
          _buildAlignmentDemo('Center Alignment', VStackAlignment.center),
          _buildAlignmentDemo('End Alignment', VStackAlignment.end),
          _buildAlignmentDemo('Stretch Alignment', VStackAlignment.stretch),
        ],
      ),
    );
  }

  Widget _buildAlignmentDemo(String title, VStackAlignment alignment) {
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
            alignment: alignment,
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

  Widget _buildZStackDemoSection() {
    return CustomCard(
      color: _darkMode ? Colors.grey[850]! : Colors.white,
      elevation: 2.0,
      borderRadius: 12.0,
      padding: const EdgeInsets.all(20.0),
      child: VStack(
        spacing: 16.0,
        alignment: VStackAlignment.stretch,
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

  Widget _buildCombinedExample() {
    return CustomCard(
      color: _darkMode ? Colors.grey[850]! : Colors.white,
      elevation: 3.0,
      borderRadius: 12.0,
      padding: const EdgeInsets.all(20.0),
      child: VStack(
        spacing: 16.0,
        alignment: VStackAlignment.stretch,
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
            alignment: VStackAlignment.center,
            children: [
              CustomCard(
                color: Colors.indigo[100]!,
                elevation: 2.0,
                borderRadius: 8.0,
                padding: const EdgeInsets.all(16.0),
                child: VStack(
                  spacing: 12.0,
                  alignment: VStackAlignment.center,
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
                      alignment: VStackAlignment.stretch,
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
            '✓ CustomCard + VStack + CustomToggleSwitch',
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
          Text(label, style: const TextStyle(fontSize: 16)),
          CustomToggleSwitch(
            value: value,
            onChanged: onChanged,
            activeColor: Colors.indigo,
          ),
        ],
      ),
    );
  }
}
