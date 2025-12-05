import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:primitive_ui/primitive_ui.dart';

void main() {
  group('PrimitiveButton', () {
    testWidgets('renders child content', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: PrimitiveButton(
              onPressed: () {},
              child: const Text('Test Button'),
            ),
          ),
        ),
      );

      expect(find.text('Test Button'), findsOneWidget);
    });

    testWidgets('calls onPressed when tapped', (WidgetTester tester) async {
      bool pressed = false;
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: PrimitiveButton(
              onPressed: () => pressed = true,
              child: const Text('Tap Me'),
            ),
          ),
        ),
      );

      await tester.tap(find.byType(PrimitiveButton));
      expect(pressed, isTrue);
    });

    testWidgets('shows loading indicator when isLoading is true', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: PrimitiveButton(
              onPressed: () {},
              isLoading: true,
              child: const Text('Loading Button'),
            ),
          ),
        ),
      );

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('does not call onPressed when disabled', (WidgetTester tester) async {
      bool pressed = false;
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: PrimitiveButton(
              onPressed: () => pressed = true,
              isDisabled: true,
              child: const Text('Disabled'),
            ),
          ),
        ),
      );

      await tester.tap(find.byType(PrimitiveButton));
      expect(pressed, isFalse);
    });
  });
}
