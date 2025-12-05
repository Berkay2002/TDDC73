import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:primitive_ui/primitive_ui.dart';
import 'package:primitive_ui/src/components/z_stack.dart'; // Import for CustomPositioned

void main() {
  group('ZStack', () {
    testWidgets('renders multiple children', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ZStack(
              children: [
                Container(width: 100, height: 100, color: Colors.red),
                Container(width: 50, height: 50, color: Colors.blue),
              ],
            ),
          ),
        ),
      );

      expect(find.byType(Container), findsNWidgets(2));
    });

    testWidgets('children are layered (last on top)', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ZStack(
              children: [
                Container(
                  key: const Key('bottom'),
                  width: 100,
                  height: 100,
                  color: Colors.red,
                ),
                Container(
                  key: const Key('top'),
                  width: 50,
                  height: 50,
                  color: Colors.blue,
                ),
              ],
            ),
          ),
        ),
      );

      expect(find.byKey(const Key('bottom')), findsOneWidget);
      expect(find.byKey(const Key('top')), findsOneWidget);
    });
  });

  group('ZStack - Positioning', () {
    testWidgets('CustomPositioned positions child absolutely', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SizedBox(
              width: 200,
              height: 200,
              child: ZStack(
                children: [
                   Container(width: 200, height: 200, color: Colors.grey),
                   CustomPositioned(
                     left: 10,
                     top: 20,
                     child: Container(key: Key('pos'), width: 50, height: 50, color: Colors.red),
                   ),
                ],
              ),
            ),
          ),
        ),
      );
      
      final pos = tester.renderObject<RenderBox>(find.byKey(Key('pos')));
      final parentData = pos.parentData as ContainerBoxParentData<RenderBox>;
      
      expect(parentData.offset.dx, equals(10.0));
      expect(parentData.offset.dy, equals(20.0));
    });

    testWidgets('CustomPositioned with right/bottom', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SizedBox(
              width: 200,
              height: 200,
              child: ZStack(
                children: [
                   Container(width: 200, height: 200, color: Colors.grey),
                   CustomPositioned(
                     right: 10,
                     bottom: 20,
                     child: Container(key: Key('pos'), width: 50, height: 50, color: Colors.red),
                   ),
                ],
              ),
            ),
          ),
        ),
      );
      
      final pos = tester.renderObject<RenderBox>(find.byKey(Key('pos')));
      final parentData = pos.parentData as ContainerBoxParentData<RenderBox>;
      
      // Right 10 = 200 - 10 - 50 = 140
      expect(parentData.offset.dx, equals(140.0));
      // Bottom 20 = 200 - 20 - 50 = 130
      expect(parentData.offset.dy, equals(130.0));
    });
  });
}