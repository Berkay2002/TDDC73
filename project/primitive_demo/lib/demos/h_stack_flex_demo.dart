import 'package:flutter/material.dart';
import 'package:primitive_ui/primitive_ui.dart';

class HStackFlexDemo extends StatelessWidget {
  const HStackFlexDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('HStack Flex Demo')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Fixed + Expanded:', style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              Container(
                color: Colors.grey[200],
                height: 50,
                child: HStack(
                  children: [
                    Container(width: 50, color: Colors.red),
                    HCustomExpanded(
                      child: Container(color: Colors.blue),
                    ),
                    Container(width: 50, color: Colors.green),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              const Text('Proportional (1:2:1):', style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              Container(
                color: Colors.grey[200],
                height: 50,
                child: HStack(
                  children: [
                    HCustomFlexible(
                      flex: 1,
                      child: Container(color: Colors.red),
                    ),
                    HCustomFlexible(
                      flex: 2,
                      child: Container(color: Colors.blue),
                    ),
                    HCustomFlexible(
                      flex: 1,
                      child: Container(color: Colors.green),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
