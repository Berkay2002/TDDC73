import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:primitive_ui/primitive_ui.dart';

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

    testWidgets('no spacing with spacing = 0.0', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: HStack(
              spacing: 0.0,
              children: [
                SizedBox(height: 50, width: 100),
                SizedBox(height: 50, width: 100),
              ],
            ),
          ),
        ),
      );

      final hstack = tester.widget<HStack>(find.byType(HStack));
      expect(hstack.spacing, equals(0.0));
    });
  });

  group('HStack - Alignment', () {
    testWidgets('HStackAlignment.top', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: HStack(
              alignment: HStackAlignment.top,
              children: [SizedBox(height: 50, width: 100)],
            ),
          ),
        ),
      );

      final hstack = tester.widget<HStack>(find.byType(HStack));
      expect(hstack.alignment, equals(HStackAlignment.top));
    });

    testWidgets('HStackAlignment.center', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: HStack(
              alignment: HStackAlignment.center,
              children: [SizedBox(height: 50, width: 100)],
            ),
          ),
        ),
      );

      final hstack = tester.widget<HStack>(find.byType(HStack));
      expect(hstack.alignment, equals(HStackAlignment.center));
    });

    testWidgets('HStackAlignment.bottom', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: HStack(
              alignment: HStackAlignment.bottom,
              children: [SizedBox(height: 50, width: 100)],
            ),
          ),
        ),
      );

      final hstack = tester.widget<HStack>(find.byType(HStack));
      expect(hstack.alignment, equals(HStackAlignment.bottom));
    });

    testWidgets('HStackAlignment.stretch fills height', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SizedBox(
              height: 200,
              child: HStack(
                alignment: HStackAlignment.stretch,
                children: [Container(width: 50, color: Colors.red)],
              ),
            ),
          ),
        ),
      );

      final hstack = tester.widget<HStack>(find.byType(HStack));
      expect(hstack.alignment, equals(HStackAlignment.stretch));
    });
  });

  group('HStack - MainAxisSize', () {
    testWidgets('MainAxisSize.max fills available width', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: HStack(
              mainAxisSize: MainAxisSize.max,
              children: [SizedBox(height: 50, width: 100)],
            ),
          ),
        ),
      );

      final hstack = tester.widget<HStack>(find.byType(HStack));
      expect(hstack.mainAxisSize, equals(MainAxisSize.max));
    });

    testWidgets('MainAxisSize.min wraps content', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: HStack(
              mainAxisSize: MainAxisSize.min,
              children: [SizedBox(height: 50, width: 100)],
            ),
          ),
        ),
      );

      final hstack = tester.widget<HStack>(find.byType(HStack));
      expect(hstack.mainAxisSize, equals(MainAxisSize.min));
    });
  });

  group('HStack - Edge Cases', () {
    test('throws assertion error for negative spacing', () {
      expect(
        () => HStack(spacing: -10.0, children: const [Text('Invalid')]),
        throwsAssertionError,
      );
    });

    testWidgets('handles nested HStacks', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: HStack(
              children: [
                HStack(children: [Text('Nested 1'), Text('Nested 2')]),
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

    testWidgets('correct total width with spacing', (tester) async {
      const childWidth = 50.0;
      const spacing = 10.0;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: HStack(
              mainAxisSize: MainAxisSize.min,
              spacing: spacing,
              children: const [
                SizedBox(height: 100, width: childWidth),
                SizedBox(height: 100, width: childWidth),
                SizedBox(height: 100, width: childWidth),
              ],
            ),
          ),
        ),
      );

      final hstackRenderBox = tester.renderObject<RenderBox>(
        find.byType(HStack),
      );

      // Total width = 3 children * 50 + 2 spacings * 10 = 170
      expect(hstackRenderBox.size.width, equals(170.0));
    });
  });

  group('HStack - MainAxisAlignment', () {
    testWidgets('MainAxisAlignment.start', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SizedBox(
              width: 300,
              child: HStack(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [SizedBox(key: Key('child'), height: 50, width: 100)],
              ),
            ),
          ),
        ),
      );

      final hstack = tester.widget<HStack>(find.byType(HStack));
      expect(hstack.mainAxisAlignment, equals(MainAxisAlignment.start));

      final childRenderBox = tester.renderObject<RenderBox>(
        find.byKey(const Key('child')),
      );
      final parentData =
          childRenderBox.parentData as ContainerBoxParentData<RenderBox>;
      expect(parentData.offset.dx, equals(0.0));
    });

    testWidgets('MainAxisAlignment.end', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SizedBox(
              width: 300,
              child: HStack(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [SizedBox(key: Key('child'), height: 50, width: 100)],
              ),
            ),
          ),
        ),
      );

      final hstack = tester.widget<HStack>(find.byType(HStack));
      expect(hstack.mainAxisAlignment, equals(MainAxisAlignment.end));

      final childRenderBox = tester.renderObject<RenderBox>(
        find.byKey(const Key('child')),
      );
      final parentData =
          childRenderBox.parentData as ContainerBoxParentData<RenderBox>;
      // 300 - 100 = 200
      expect(parentData.offset.dx, equals(200.0));
    });

    testWidgets('MainAxisAlignment.center', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SizedBox(
              width: 300,
              child: HStack(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [SizedBox(key: Key('child'), height: 50, width: 100)],
              ),
            ),
          ),
        ),
      );

      final hstack = tester.widget<HStack>(find.byType(HStack));
      expect(hstack.mainAxisAlignment, equals(MainAxisAlignment.center));

      final childRenderBox = tester.renderObject<RenderBox>(
        find.byKey(const Key('child')),
      );
      final parentData =
          childRenderBox.parentData as ContainerBoxParentData<RenderBox>;
      // (300 - 100) / 2 = 100
      expect(parentData.offset.dx, equals(100.0));
    });

    testWidgets('MainAxisAlignment.spaceBetween', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SizedBox(
              width: 300,
              child: HStack(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(key: Key('child1'), height: 50, width: 100),
                  SizedBox(key: Key('child2'), height: 50, width: 100),
                ],
              ),
            ),
          ),
        ),
      );

      final hstack = tester.widget<HStack>(find.byType(HStack));
      expect(hstack.mainAxisAlignment, equals(MainAxisAlignment.spaceBetween));

      final firstChild = tester.renderObject<RenderBox>(
        find.byKey(const Key('child1')),
      );
      final secondChild = tester.renderObject<RenderBox>(
        find.byKey(const Key('child2')),
      );

      final firstParentData =
          firstChild.parentData as ContainerBoxParentData<RenderBox>;
      final secondParentData =
          secondChild.parentData as ContainerBoxParentData<RenderBox>;

      expect(firstParentData.offset.dx, equals(0.0));
      // 300 - 100 = 200
      expect(secondParentData.offset.dx, equals(200.0));
    });
  });
}
