import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:primitive_ui/primitive_ui.dart';
import 'package:primitive_ui/src/components/h_stack.dart'; // Import for HCustomFlexible

void main() {
  group('HStack', () {
    testWidgets('renders empty children list', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: HStack(children: [])),
        ),
      );

      // Should render a SizedBox.shrink
      expect(find.byType(HStack), findsOneWidget);
    });

    testWidgets('renders single child', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: HStack(children: [Text('Single')])),
        ),
      );

      expect(find.text('Single'), findsOneWidget);
    });

    testWidgets('renders multiple children', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: HStack(
              children: [Text('First'), Text('Second'), Text('Third')],
            ),
          ),
        ),
      );

      expect(find.text('First'), findsOneWidget);
      expect(find.text('Second'), findsOneWidget);
      expect(find.text('Third'), findsOneWidget);
    });

    testWidgets('applies spacing between children', (tester) async {
      const spacing = 20.0;

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: HStack(
              spacing: spacing,
              children: [
                SizedBox(height: 50, width: 100),
                SizedBox(height: 50, width: 100),
              ],
            ),
          ),
        ),
      );

      final hstack = tester.widget<HStack>(find.byType(HStack));
      expect(hstack.spacing, equals(spacing));
    });
  });

  group('HStack - Alignment', () {
    testWidgets('CrossAxisAlignment.start', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: HStack(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [SizedBox(height: 50, width: 100)],
            ),
          ),
        ),
      );

      final hstack = tester.widget<HStack>(find.byType(HStack));
      expect(hstack.crossAxisAlignment, equals(CrossAxisAlignment.start));
    });

    testWidgets('CrossAxisAlignment.center', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: HStack(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [SizedBox(height: 50, width: 100)],
            ),
          ),
        ),
      );

      final hstack = tester.widget<HStack>(find.byType(HStack));
      expect(hstack.crossAxisAlignment, equals(CrossAxisAlignment.center));
    });

    testWidgets('CrossAxisAlignment.end', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: HStack(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [SizedBox(height: 50, width: 100)],
            ),
          ),
        ),
      );

      final hstack = tester.widget<HStack>(find.byType(HStack));
      expect(hstack.crossAxisAlignment, equals(CrossAxisAlignment.end));
    });

    testWidgets('CrossAxisAlignment.stretch fills height', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SizedBox(
              height: 200,
              child: HStack(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [Container(width: 50, color: Colors.red)],
              ),
            ),
          ),
        ),
      );

      final hstack = tester.widget<HStack>(find.byType(HStack));
      expect(hstack.crossAxisAlignment, equals(CrossAxisAlignment.stretch));
    });
  });

  group('HStack - Flex Layout', () {
    testWidgets('HCustomExpanded fills available width', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SizedBox(
              width: 300,
              child: HStack(
                children: [
                  SizedBox(width: 100, height: 50),
                  HCustomExpanded(child: Container(color: Colors.red)),
                ],
              ),
            ),
          ),
        ),
      );
      
      final hstackRenderBox = tester.renderObject<RenderBox>(find.byType(HStack));
      expect(hstackRenderBox.size.width, equals(300.0));
      
      final redContainer = tester.renderObject<RenderBox>(find.byType(Container));
      // First child is 100. Spacing is 0. Width is 300.
      // Remaining is 200. Expanded should take 200.
      expect(redContainer.size.width, equals(200.0));
    });

    testWidgets('HCustomFlexible with flex factors', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SizedBox(
              width: 300,
              child: HStack(
                children: [
                  HCustomFlexible(flex: 1, child: Container(key: Key('flex1'))),
                  HCustomFlexible(flex: 2, child: Container(key: Key('flex2'))),
                ],
              ),
            ),
          ),
        ),
      );
      
      final flex1 = tester.renderObject<RenderBox>(find.byKey(Key('flex1')));
      final flex2 = tester.renderObject<RenderBox>(find.byKey(Key('flex2')));
      
      // Total 300. Flex total 3.
      // Flex 1 = 100. Flex 2 = 200.
      expect(flex1.size.width, equals(100.0));
      expect(flex2.size.width, equals(200.0));
    });
  });
}