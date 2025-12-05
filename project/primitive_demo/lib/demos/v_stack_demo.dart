import 'package:flutter/material.dart';
import 'package:primitive_ui/primitive_ui.dart';

class VStackDemo extends StatefulWidget {
  const VStackDemo({super.key});

  @override
  State<VStackDemo> createState() => _VStackDemoState();
}

class _VStackDemoState extends State<VStackDemo> {
  bool _useExpanded = true;
  double _flex1 = 1.0;
  double _flex2 = 2.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('VStack Flexible Demo')),
      body: VStack(
        spacing: 20.0,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Flex Control',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
          ),
          
          // Controls
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              children: [
                 Row(
                   children: [
                     const Text('Use CustomExpanded: '),
                     Switch(
                       value: _useExpanded,
                       onChanged: (v) => setState(() => _useExpanded = v),
                     ),
                   ],
                 ),
                 if (!_useExpanded) ...[
                   Text('Flex Item 1: ${_flex1.toInt()}'),
                   Slider(
                     min: 1, max: 5, divisions: 4,
                     value: _flex1,
                     onChanged: (v) => setState(() => _flex1 = v),
                   ),
                   Text('Flex Item 2: ${_flex2.toInt()}'),
                   Slider(
                     min: 1, max: 5, divisions: 4,
                     value: _flex2,
                     onChanged: (v) => setState(() => _flex2 = v),
                   ),
                 ],
              ],
            ),
          ),

          // Demo Area
          CustomExpanded(
            child: Container(
              color: Colors.grey[200],
              padding: const EdgeInsets.all(8.0),
              child: VStack(
                spacing: 4.0,
                children: [
                   Container(
                     height: 50, 
                     color: Colors.black12, 
                     child: const Center(child: Text('Fixed Header (50px)')),
                   ),
                   
                   if (_useExpanded)
                     CustomExpanded(
                       child: Container(
                         color: Colors.blue[300],
                         child: const Center(child: Text('CustomExpanded (Fills Remaining)')),
                       ),
                     )
                   else ...[
                     CustomFlexible(
                       flex: _flex1.toInt(),
                       child: Container(
                         color: Colors.red[300],
                         child: Center(child: Text('Flex ${_flex1.toInt()}')),
                       ),
                     ),
                     CustomFlexible(
                       flex: _flex2.toInt(),
                       child: Container(
                         color: Colors.green[300],
                         child: Center(child: Text('Flex ${_flex2.toInt()}')),
                       ),
                     ),
                   ],
                   
                   Container(
                     height: 50, 
                     color: Colors.black12, 
                     child: const Center(child: Text('Fixed Footer (50px)')),
                   ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
