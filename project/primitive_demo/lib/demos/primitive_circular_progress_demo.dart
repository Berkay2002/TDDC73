import 'package:flutter/material.dart';
import 'package:primitive_ui/primitive_ui.dart';

class PrimitiveCircularProgressDemo extends StatelessWidget {
  const PrimitiveCircularProgressDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('PrimitiveCircularProgress Demo')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: VStack(
          spacing: 48.0,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Basic
            VStack(
              spacing: 16.0,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  'Basic',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const PrimitiveCircularProgress(),
              ],
            ),

            // Custom Color & Size
            VStack(
              spacing: 16.0,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  'Custom Color & Size',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const PrimitiveCircularProgress(
                  color: Colors.red,
                  size: 60.0,
                  strokeWidth: 6.0,
                ),
              ],
            ),

            // Large
            VStack(
              spacing: 16.0,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  'Large',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const PrimitiveCircularProgress(
                  color: Colors.green,
                  size: 100.0,
                  strokeWidth: 10.0,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
