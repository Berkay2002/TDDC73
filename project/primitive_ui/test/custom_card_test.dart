import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:primitive_ui/primitive_ui.dart';

void main() {
  group('CustomCard', () {
    testWidgets('renders with child widget', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: CustomCard(child: Text('Hello'))),
        ),
      );

      expect(find.text('Hello'), findsOneWidget);
    });

    testWidgets('applies custom background color', (tester) async {
      const testColor = Color(0xFF123456);

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: CustomCard(color: testColor, child: Text('Test')),
          ),
        ),
      );

      // Card should render without errors
      expect(find.byType(CustomCard), findsOneWidget);
      expect(find.text('Test'), findsOneWidget);
    });

    testWidgets('renders with default white color', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: CustomCard(child: Text('Default'))),
        ),
      );

      expect(find.byType(CustomCard), findsOneWidget);
      expect(find.text('Default'), findsOneWidget);
    });

    testWidgets('applies custom border radius', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: CustomCard(borderRadius: 16.0, child: Text('Rounded')),
          ),
        ),
      );

      expect(find.byType(CustomCard), findsOneWidget);
      expect(find.text('Rounded'), findsOneWidget);
    });

    testWidgets('renders with default border radius', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: CustomCard(child: Text('Default Radius'))),
        ),
      );

      expect(find.byType(CustomCard), findsOneWidget);
    });

    testWidgets('renders with elevation', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: CustomCard(elevation: 4.0, child: Text('Elevated')),
          ),
        ),
      );

      expect(find.byType(CustomCard), findsOneWidget);
      expect(find.text('Elevated'), findsOneWidget);
    });

    testWidgets('renders with zero elevation', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: CustomCard(elevation: 0.0, child: Text('Flat'))),
        ),
      );

      expect(find.byType(CustomCard), findsOneWidget);
      expect(find.text('Flat'), findsOneWidget);
    });

    testWidgets('applies custom padding', (tester) async {
      const testPadding = EdgeInsets.all(32.0);

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: CustomCard(
              padding: testPadding,
              child: SizedBox(width: 100, height: 100),
            ),
          ),
        ),
      );

      final card = tester.widget<CustomCard>(find.byType(CustomCard));
      expect(card.padding, equals(testPadding));
    });

    testWidgets('applies asymmetric padding', (tester) async {
      const testPadding = EdgeInsets.fromLTRB(10, 20, 30, 40);

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: CustomCard(
              padding: testPadding,
              child: SizedBox(width: 50, height: 50),
            ),
          ),
        ),
      );

      final card = tester.widget<CustomCard>(find.byType(CustomCard));
      expect(card.padding, equals(testPadding));
    });

    testWidgets('card size includes padding', (tester) async {
      const childSize = Size(100, 100);
      const padding = EdgeInsets.all(16.0);

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomCard(
              padding: padding,
              child: SizedBox(width: childSize.width, height: childSize.height),
            ),
          ),
        ),
      );

      final cardRenderBox = tester.renderObject<RenderBox>(
        find.byType(CustomCard),
      );

      // Card size should be child size + padding
      expect(
        cardRenderBox.size.width,
        equals(childSize.width + padding.horizontal),
      );
      expect(
        cardRenderBox.size.height,
        equals(childSize.height + padding.vertical),
      );
    });
  });

  group('CustomCard - Edge Cases', () {
    testWidgets('handles very large elevation', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: CustomCard(
              elevation: 100.0, // Very large elevation
              child: Text('High'),
            ),
          ),
        ),
      );

      expect(find.byType(CustomCard), findsOneWidget);
      expect(find.text('High'), findsOneWidget);
    });

    testWidgets('handles minimal constraints', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: CustomCard(child: SizedBox(width: 10, height: 10)),
          ),
        ),
      );

      expect(find.byType(CustomCard), findsOneWidget);
    });

    test('throws assertion error for negative elevation', () {
      expect(
        () => CustomCard(elevation: -1.0, child: const Text('Invalid')),
        throwsAssertionError,
      );
    });

    test('throws assertion error for negative border radius', () {
      expect(
        () => CustomCard(borderRadius: -5.0, child: const Text('Invalid')),
        throwsAssertionError,
      );
    });
  });
}
