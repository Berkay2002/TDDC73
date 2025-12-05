import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
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
    testWidgets('CrossAxisAlignment.start in LTR', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: VStack(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [SizedBox(height: 50, width: 100)],
            ),
          ),
        ),
      );

      final vstack = tester.widget<VStack>(find.byType(VStack));
      expect(vstack.crossAxisAlignment, equals(CrossAxisAlignment.start));
    });

    testWidgets('CrossAxisAlignment.center', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: VStack(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [SizedBox(height: 50, width: 100)],
            ),
          ),
        ),
      );

      final vstack = tester.widget<VStack>(find.byType(VStack));
      expect(vstack.crossAxisAlignment, equals(CrossAxisAlignment.center));
    });

    testWidgets('CrossAxisAlignment.end in LTR', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: VStack(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [SizedBox(height: 50, width: 100)],
            ),
          ),
        ),
      );

      final vstack = tester.widget<VStack>(find.byType(VStack));
      expect(vstack.crossAxisAlignment, equals(CrossAxisAlignment.end));
    });

    testWidgets('CrossAxisAlignment.stretch fills width', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SizedBox(
              width: 200,
              child: VStack(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [Container(height: 50, color: Colors.red)],
              ),
            ),
          ),
        ),
      );

      final vstack = tester.widget<VStack>(find.byType(VStack));
      expect(vstack.crossAxisAlignment, equals(CrossAxisAlignment.stretch));
    });

    testWidgets('RTL reverses start alignment', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Directionality(
            textDirection: TextDirection.rtl,
            child: Scaffold(
              body: VStack(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [SizedBox(height: 50, width: 100)],
              ),
            ),
          ),
        ),
      );

      final vstack = tester.widget<VStack>(find.byType(VStack));
      expect(vstack.crossAxisAlignment, equals(CrossAxisAlignment.start));
    });

    testWidgets('RTL reverses end alignment', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Directionality(
            textDirection: TextDirection.rtl,
            child: Scaffold(
              body: VStack(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [SizedBox(height: 50, width: 100)],
              ),
            ),
          ),
        ),
      );

      final vstack = tester.widget<VStack>(find.byType(VStack));
      expect(vstack.crossAxisAlignment, equals(CrossAxisAlignment.end));
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

  group('VStack - MainAxisAlignment', () {
    testWidgets('MainAxisAlignment.start', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SizedBox(
              height: 300,
              child: VStack(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [SizedBox(key: Key('child'), height: 50, width: 100)],
              ),
            ),
          ),
        ),
      );

      final vstack = tester.widget<VStack>(find.byType(VStack));
      expect(vstack.mainAxisAlignment, equals(MainAxisAlignment.start));

      // Verify position by finding the child render object
      final childRenderBox = tester.renderObject<RenderBox>(
        find.byKey(const Key('child')),
      );
      final parentData =
          childRenderBox.parentData as ContainerBoxParentData<RenderBox>;
      expect(parentData.offset.dy, equals(0.0));
    });

    testWidgets('MainAxisAlignment.end', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SizedBox(
              height: 300,
              child: VStack(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [SizedBox(key: Key('child'), height: 50, width: 100)],
              ),
            ),
          ),
        ),
      );

      final vstack = tester.widget<VStack>(find.byType(VStack));
      expect(vstack.mainAxisAlignment, equals(MainAxisAlignment.end));

      final childRenderBox = tester.renderObject<RenderBox>(
        find.byKey(const Key('child')),
      );
      final parentData =
          childRenderBox.parentData as ContainerBoxParentData<RenderBox>;
      // 300 - 50 = 250
      expect(parentData.offset.dy, equals(250.0));
    });

    testWidgets('MainAxisAlignment.center', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SizedBox(
              height: 300,
              child: VStack(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [SizedBox(key: Key('child'), height: 50, width: 100)],
              ),
            ),
          ),
        ),
      );

      final vstack = tester.widget<VStack>(find.byType(VStack));
      expect(vstack.mainAxisAlignment, equals(MainAxisAlignment.center));

      final childRenderBox = tester.renderObject<RenderBox>(
        find.byKey(const Key('child')),
      );
      final parentData =
          childRenderBox.parentData as ContainerBoxParentData<RenderBox>;
      // (300 - 50) / 2 = 125
      expect(parentData.offset.dy, equals(125.0));
    });

    testWidgets('MainAxisAlignment.spaceBetween', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SizedBox(
              height: 300,
              child: VStack(
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

      final vstack = tester.widget<VStack>(find.byType(VStack));
      expect(vstack.mainAxisAlignment, equals(MainAxisAlignment.spaceBetween));

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

      expect(firstParentData.offset.dy, equals(0.0));
      // 300 - 50 = 250
      expect(secondParentData.offset.dy, equals(250.0));
    });
  });

  group('VStack - CustomFlexible', () {
    testWidgets('CustomExpanded expands child to fill space', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SizedBox(
              height: 300,
              child: VStack(
                children: [
                  SizedBox(height: 100, width: 100),
                  CustomExpanded(child: Container(color: Colors.red)),
                ],
              ),
            ),
          ),
        ),
      );
      
      final vstackRenderBox = tester.renderObject<RenderBox>(find.byType(VStack));
      expect(vstackRenderBox.size.height, equals(300.0));
      
      final redContainer = tester.renderObject<RenderBox>(find.byType(Container));
      // First child is 100. Spacing is 0. Height is 300.
      // Remaining is 200. Expanded should take 200.
      expect(redContainer.size.height, equals(200.0));
    });

    testWidgets('CustomFlexible with flex factors', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SizedBox(
              height: 300,
              child: VStack(
                children: [
                  CustomFlexible(flex: 1, child: Container(key: Key('flex1'))),
                  CustomFlexible(flex: 2, child: Container(key: Key('flex2'))),
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
      expect(flex1.size.height, equals(100.0));
      expect(flex2.size.height, equals(200.0));
    });

    testWidgets('CustomFlexible mixed with fixed children', (tester) async {
       await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SizedBox(
              height: 400,
              child: VStack(
                spacing: 10,
                children: [
                   SizedBox(height: 90, width: 100), // Fixed: 90
                   CustomExpanded(child: Container(key: Key('expanded'))), // Expanded
                ],
              ),
            ),
          ),
        ),
      );
      
      // Height 400. Fixed 90. Spacing 10.
      // Remaining = 400 - 90 - 10 = 300.
      final expanded = tester.renderObject<RenderBox>(find.byKey(Key('expanded')));
      expect(expanded.size.height, equals(300.0));
    });
  });
}