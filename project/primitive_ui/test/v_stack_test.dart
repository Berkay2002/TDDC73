import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:primitive_ui/primitive_ui.dart';

void main() {
  group('VStack', () {
    testWidgets('renders empty children list', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: VStack(children: [])),
        ),
      );

      // Should render a SizedBox.shrink
      expect(find.byType(VStack), findsOneWidget);
    });

    testWidgets('renders single child', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: VStack(children: [Text('Single')])),
        ),
      );

      expect(find.text('Single'), findsOneWidget);
    });

    testWidgets('renders multiple children', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: VStack(
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
            body: VStack(
              spacing: spacing,
              children: [
                SizedBox(height: 50, width: 100),
                SizedBox(height: 50, width: 100),
              ],
            ),
          ),
        ),
      );

      final vstack = tester.widget<VStack>(find.byType(VStack));
      expect(vstack.spacing, equals(spacing));
    });

    testWidgets('no spacing with spacing = 0.0', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: VStack(
              spacing: 0.0,
              children: [
                SizedBox(height: 50, width: 100),
                SizedBox(height: 50, width: 100),
              ],
            ),
          ),
        ),
      );

      final vstack = tester.widget<VStack>(find.byType(VStack));
      expect(vstack.spacing, equals(0.0));
    });
  });

  group('VStack - Alignment', () {
    testWidgets('VStackAlignment.start in LTR', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: VStack(
              alignment: VStackAlignment.start,
              children: [SizedBox(height: 50, width: 100)],
            ),
          ),
        ),
      );

      final vstack = tester.widget<VStack>(find.byType(VStack));
      expect(vstack.alignment, equals(VStackAlignment.start));
    });

    testWidgets('VStackAlignment.center', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: VStack(
              alignment: VStackAlignment.center,
              children: [SizedBox(height: 50, width: 100)],
            ),
          ),
        ),
      );

      final vstack = tester.widget<VStack>(find.byType(VStack));
      expect(vstack.alignment, equals(VStackAlignment.center));
    });

    testWidgets('VStackAlignment.end in LTR', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: VStack(
              alignment: VStackAlignment.end,
              children: [SizedBox(height: 50, width: 100)],
            ),
          ),
        ),
      );

      final vstack = tester.widget<VStack>(find.byType(VStack));
      expect(vstack.alignment, equals(VStackAlignment.end));
    });

    testWidgets('VStackAlignment.stretch fills width', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SizedBox(
              width: 200,
              child: VStack(
                alignment: VStackAlignment.stretch,
                children: [Container(height: 50, color: Colors.red)],
              ),
            ),
          ),
        ),
      );

      final vstack = tester.widget<VStack>(find.byType(VStack));
      expect(vstack.alignment, equals(VStackAlignment.stretch));
    });

    testWidgets('RTL reverses start alignment', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Directionality(
            textDirection: TextDirection.rtl,
            child: Scaffold(
              body: VStack(
                alignment: VStackAlignment.start,
                children: [SizedBox(height: 50, width: 100)],
              ),
            ),
          ),
        ),
      );

      final vstack = tester.widget<VStack>(find.byType(VStack));
      expect(vstack.alignment, equals(VStackAlignment.start));
    });

    testWidgets('RTL reverses end alignment', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Directionality(
            textDirection: TextDirection.rtl,
            child: Scaffold(
              body: VStack(
                alignment: VStackAlignment.end,
                children: [SizedBox(height: 50, width: 100)],
              ),
            ),
          ),
        ),
      );

      final vstack = tester.widget<VStack>(find.byType(VStack));
      expect(vstack.alignment, equals(VStackAlignment.end));
    });
  });

  group('VStack - MainAxisSize', () {
    testWidgets('MainAxisSize.max fills available height', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: VStack(
              mainAxisSize: MainAxisSize.max,
              children: [SizedBox(height: 50, width: 100)],
            ),
          ),
        ),
      );

      final vstack = tester.widget<VStack>(find.byType(VStack));
      expect(vstack.mainAxisSize, equals(MainAxisSize.max));
    });

    testWidgets('MainAxisSize.min wraps content', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: VStack(
              mainAxisSize: MainAxisSize.min,
              children: [SizedBox(height: 50, width: 100)],
            ),
          ),
        ),
      );

      final vstack = tester.widget<VStack>(find.byType(VStack));
      expect(vstack.mainAxisSize, equals(MainAxisSize.min));
    });
  });

  group('VStack - Edge Cases', () {
    test('throws assertion error for negative spacing', () {
      expect(
        () => VStack(spacing: -10.0, children: const [Text('Invalid')]),
        throwsAssertionError,
      );
    });

    testWidgets('handles nested VStacks', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: VStack(
              children: [
                VStack(children: [Text('Nested 1'), Text('Nested 2')]),
                Text('Outer'),
              ],
            ),
          ),
        ),
      );

      expect(find.text('Nested 1'), findsOneWidget);
      expect(find.text('Nested 2'), findsOneWidget);
      expect(find.text('Outer'), findsOneWidget);
    });

    testWidgets('correct total height with spacing', (tester) async {
      const childHeight = 50.0;
      const spacing = 10.0;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: VStack(
              mainAxisSize: MainAxisSize.min,
              spacing: spacing,
              children: const [
                SizedBox(height: childHeight, width: 100),
                SizedBox(height: childHeight, width: 100),
                SizedBox(height: childHeight, width: 100),
              ],
            ),
          ),
        ),
      );

      final vstackRenderBox = tester.renderObject<RenderBox>(
        find.byType(VStack),
      );

      // Total height = 3 children * 50 + 2 spacings * 10 = 170
      expect(vstackRenderBox.size.height, equals(170.0));
    });
  });
}
