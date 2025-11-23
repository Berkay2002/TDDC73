import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:primitive_ui/primitive_ui.dart';

void main() {
  group('ZStack', () {
    testWidgets('renders empty children list', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: ZStack(children: [])),
        ),
      );

      // Should render a SizedBox.shrink
      expect(find.byType(ZStack), findsOneWidget);
    });

    testWidgets('renders single child', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: ZStack(children: [Text('Single')])),
        ),
      );

      expect(find.text('Single'), findsOneWidget);
    });

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

  group('ZStack - Fit Modes', () {
    testWidgets('ZStackFit.loose allows natural sizing', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: ZStack(
                fit: ZStackFit.loose,
                children: [
                  Container(width: 100, height: 100, color: Colors.red),
                ],
              ),
            ),
          ),
        ),
      );

      final zstack = tester.widget<ZStack>(find.byType(ZStack));
      expect(zstack.fit, equals(ZStackFit.loose));
    });

    testWidgets('ZStackFit.expand fills constraints', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SizedBox(
              width: 200,
              height: 200,
              child: ZStack(
                fit: ZStackFit.expand,
                children: [Container(color: Colors.red)],
              ),
            ),
          ),
        ),
      );

      final zstack = tester.widget<ZStack>(find.byType(ZStack));
      expect(zstack.fit, equals(ZStackFit.expand));
    });

    testWidgets('ZStackFit.passthrough uses exact constraints', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SizedBox(
              width: 150,
              height: 150,
              child: ZStack(
                fit: ZStackFit.passthrough,
                children: [Container(color: Colors.blue)],
              ),
            ),
          ),
        ),
      );

      final zstack = tester.widget<ZStack>(find.byType(ZStack));
      expect(zstack.fit, equals(ZStackFit.passthrough));
    });
  });

  group('ZStack - Alignment', () {
    testWidgets('Alignment.center positions correctly', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ZStack(
              alignment: Alignment.center,
              children: [Container(width: 50, height: 50, color: Colors.red)],
            ),
          ),
        ),
      );

      final zstack = tester.widget<ZStack>(find.byType(ZStack));
      expect(zstack.alignment, equals(Alignment.center));
    });

    testWidgets('Alignment.topLeft positions correctly', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ZStack(
              alignment: Alignment.topLeft,
              children: [Container(width: 50, height: 50, color: Colors.red)],
            ),
          ),
        ),
      );

      final zstack = tester.widget<ZStack>(find.byType(ZStack));
      expect(zstack.alignment, equals(Alignment.topLeft));
    });

    testWidgets('Alignment.bottomRight positions correctly', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ZStack(
              alignment: Alignment.bottomRight,
              children: [Container(width: 50, height: 50, color: Colors.red)],
            ),
          ),
        ),
      );

      final zstack = tester.widget<ZStack>(find.byType(ZStack));
      expect(zstack.alignment, equals(Alignment.bottomRight));
    });

    testWidgets('Alignment.topRight positions correctly', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ZStack(
              alignment: Alignment.topRight,
              children: [Container(width: 50, height: 50, color: Colors.red)],
            ),
          ),
        ),
      );

      final zstack = tester.widget<ZStack>(find.byType(ZStack));
      expect(zstack.alignment, equals(Alignment.topRight));
    });

    testWidgets('Alignment.bottomLeft positions correctly', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ZStack(
              alignment: Alignment.bottomLeft,
              children: [Container(width: 50, height: 50, color: Colors.red)],
            ),
          ),
        ),
      );

      final zstack = tester.widget<ZStack>(find.byType(ZStack));
      expect(zstack.alignment, equals(Alignment.bottomLeft));
    });

    testWidgets('RTL affects AlignmentDirectional', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Directionality(
            textDirection: TextDirection.rtl,
            child: Scaffold(
              body: ZStack(
                alignment: AlignmentDirectional.centerStart,
                children: [Container(width: 50, height: 50, color: Colors.red)],
              ),
            ),
          ),
        ),
      );

      final zstack = tester.widget<ZStack>(find.byType(ZStack));
      expect(zstack.alignment, equals(AlignmentDirectional.centerStart));
    });
  });

  group('ZStack - Edge Cases', () {
    testWidgets('handles nested ZStacks', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ZStack(
              children: [
                Container(width: 100, height: 100, color: Colors.red),
                ZStack(
                  children: [
                    Container(width: 50, height: 50, color: Colors.blue),
                    Container(width: 25, height: 25, color: Colors.green),
                  ],
                ),
              ],
            ),
          ),
        ),
      );

      expect(find.byType(ZStack), findsNWidgets(2));
      expect(find.byType(Container), findsNWidgets(3));
    });

    testWidgets('handles mixed-size children', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ZStack(
              children: [
                Container(width: 100, height: 100, color: Colors.red),
                Container(width: 50, height: 150, color: Colors.blue),
                Container(width: 200, height: 75, color: Colors.green),
              ],
            ),
          ),
        ),
      );

      expect(find.byType(Container), findsNWidgets(3));
    });

    testWidgets('stack sizes to largest child in loose mode', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: ZStack(
                fit: ZStackFit.loose,
                children: [
                  Container(width: 100, height: 100, color: Colors.red),
                  Container(width: 50, height: 50, color: Colors.blue),
                ],
              ),
            ),
          ),
        ),
      );

      final zstackRenderBox = tester.renderObject<RenderBox>(
        find.byType(ZStack),
      );

      // Should size to the largest child (100x100)
      expect(zstackRenderBox.size.width, equals(100.0));
      expect(zstackRenderBox.size.height, equals(100.0));
    });

    testWidgets('handles tight constraints', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SizedBox(
              width: 200,
              height: 200,
              child: ZStack(
                fit: ZStackFit.expand,
                children: [Container(color: Colors.red)],
              ),
            ),
          ),
        ),
      );

      final zstackRenderBox = tester.renderObject<RenderBox>(
        find.byType(ZStack),
      );

      expect(zstackRenderBox.size.width, equals(200.0));
      expect(zstackRenderBox.size.height, equals(200.0));
    });
  });
}
