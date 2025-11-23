import 'package:flutter/material.dart';
import 'package:primitive_ui/primitive_ui.dart';

class ZStackPositionedDemo extends StatelessWidget {
  const ZStackPositionedDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('ZStack Positioned Demo')),
      body: Center(
        child: Container(
          width: 300,
          height: 300,
          color: Colors.grey[300],
          child: ZStack(
            children: [
              Container(width: 300, height: 300, color: Colors.blue[100]),
              // Top Left
              CustomPositioned(
                left: 10,
                top: 10,
                child: Container(width: 50, height: 50, color: Colors.red),
              ),
              // Top Right
              CustomPositioned(
                right: 10,
                top: 10,
                child: Container(width: 50, height: 50, color: Colors.green),
              ),
              // Bottom Left
              CustomPositioned(
                left: 10,
                bottom: 10,
                child: Container(width: 50, height: 50, color: Colors.orange),
              ),
              // Bottom Right
              CustomPositioned(
                right: 10,
                bottom: 10,
                child: Container(width: 50, height: 50, color: Colors.purple),
              ),
              // Center (using alignment for non-positioned)
              Container(width: 80, height: 80, color: Colors.black26),
            ],
          ),
        ),
      ),
    );
  }
}
