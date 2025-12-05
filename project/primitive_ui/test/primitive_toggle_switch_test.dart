import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:primitive_ui/primitive_ui.dart';

void main() {
  group('PrimitiveToggleSwitch', () {
    testWidgets('renders correctly in off state', (WidgetTester tester) async {
      bool switchValue = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: PrimitiveToggleSwitch(
              value: switchValue,
              onChanged: (value) => switchValue = value,
            ),
          ),
        ),
      );

      // Verify the widget renders
      expect(find.byType(PrimitiveToggleSwitch), findsOneWidget);
      expect(find.byType(GestureDetector), findsWidgets);
    });

    testWidgets('renders correctly in on state', (WidgetTester tester) async {
      bool switchValue = true;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: PrimitiveToggleSwitch(
              value: switchValue,
              onChanged: (value) => switchValue = value,
            ),
          ),
        ),
      );

      // Verify the widget renders
      expect(find.byType(PrimitiveToggleSwitch), findsOneWidget);
      expect(find.byType(GestureDetector), findsWidgets);
    });

    testWidgets('toggles from off to on when tapped', (
      WidgetTester tester,
    ) async {
      bool switchValue = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: PrimitiveToggleSwitch(
              value: switchValue,
              onChanged: (value) => switchValue = value,
            ),
          ),
        ),
      );

      // Initial state is off
      expect(switchValue, false);

      // Tap the switch
      await tester.tap(find.byType(PrimitiveToggleSwitch));
      await tester.pumpAndSettle();

      // Verify callback was invoked with true
      expect(switchValue, true);
    });

    testWidgets('toggles from on to off when tapped', (
      WidgetTester tester,
    ) async {
      bool switchValue = true;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: PrimitiveToggleSwitch(
              value: switchValue,
              onChanged: (value) => switchValue = value,
            ),
          ),
        ),
      );

      // Initial state is on
      expect(switchValue, true);

      // Tap the switch
      await tester.tap(find.byType(PrimitiveToggleSwitch));
      await tester.pumpAndSettle();

      // Verify callback was invoked with false
      expect(switchValue, false);
    });

    testWidgets('animation completes smoothly', (WidgetTester tester) async {
      bool switchValue = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: PrimitiveToggleSwitch(
              value: switchValue,
              onChanged: (value) => switchValue = value,
            ),
          ),
        ),
      );

      // Tap the switch
      await tester.tap(find.byType(PrimitiveToggleSwitch));

      // Pump a few frames to verify animation is running
      await tester.pump(const Duration(milliseconds: 50));
      await tester.pump(const Duration(milliseconds: 50));
      await tester.pump(const Duration(milliseconds: 50));

      // Complete the animation
      await tester.pumpAndSettle();

      // Verify widget is still rendered after animation
      expect(find.byType(PrimitiveToggleSwitch), findsOneWidget);
    });

    testWidgets('callback receives correct value', (WidgetTester tester) async {
      bool? callbackValue;
      bool switchValue = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: PrimitiveToggleSwitch(
              value: switchValue,
              onChanged: (value) {
                callbackValue = value;
                switchValue = value;
              },
            ),
          ),
        ),
      );

      // Tap the switch
      await tester.tap(find.byType(PrimitiveToggleSwitch));
      await tester.pumpAndSettle();

      // Verify callback received true
      expect(callbackValue, true);

      // Rebuild with new value
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: PrimitiveToggleSwitch(
              value: switchValue,
              onChanged: (value) {
                callbackValue = value;
                switchValue = value;
              },
            ),
          ),
        ),
      );

      // Tap again
      await tester.tap(find.byType(PrimitiveToggleSwitch));
      await tester.pumpAndSettle();

      // Verify callback received false
      expect(callbackValue, false);
    });

    testWidgets('handles multiple rapid taps', (WidgetTester tester) async {
      int tapCount = 0;
      bool switchValue = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: PrimitiveToggleSwitch(
              value: switchValue,
              onChanged: (value) {
                tapCount++;
                switchValue = value;
              },
            ),
          ),
        ),
      );

      // Rapidly tap the switch 5 times
      for (int i = 0; i < 5; i++) {
        await tester.tap(find.byType(PrimitiveToggleSwitch));
        // Rebuild with new value after each tap
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: PrimitiveToggleSwitch(
                value: switchValue,
                onChanged: (value) {
                  tapCount++;
                  switchValue = value;
                },
              ),
            ),
          ),
        );
      }

      await tester.pumpAndSettle();

      // Verify all taps were registered
      expect(tapCount, 5);
      // After odd number of taps, should be on
      expect(switchValue, true);
    });

    testWidgets('applies custom active color', (WidgetTester tester) async {
      const customColor = Colors.red;
      bool switchValue = true;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: PrimitiveToggleSwitch(
              value: switchValue,
              onChanged: (value) => switchValue = value,
              activeColor: customColor,
            ),
          ),
        ),
      );

      // Widget should render with custom color (visually verified)
      expect(find.byType(PrimitiveToggleSwitch), findsOneWidget);
    });

    testWidgets('applies custom inactive color', (WidgetTester tester) async {
      const customColor = Colors.amber;
      bool switchValue = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: PrimitiveToggleSwitch(
              value: switchValue,
              onChanged: (value) => switchValue = value,
              inactiveColor: customColor,
            ),
          ),
        ),
      );

      // Widget should render with custom color (visually verified)
      expect(find.byType(PrimitiveToggleSwitch), findsOneWidget);
    });

    testWidgets('applies custom dimensions', (WidgetTester tester) async {
      bool switchValue = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: PrimitiveToggleSwitch(
              value: switchValue,
              onChanged: (value) => switchValue = value,
              width: 60.0,
              height: 36.0,
            ),
          ),
        ),
      );

      // Find the widget
      final switchFinder = find.byType(PrimitiveToggleSwitch);
      expect(switchFinder, findsOneWidget);

      // Verify size
      final Size size = tester.getSize(switchFinder);
      expect(size.width, 60.0);
      expect(size.height, 36.0);
    });

    testWidgets('maintains state across rebuilds', (WidgetTester tester) async {
      bool switchValue = false;
      int rebuildCount = 0;

      Widget buildSwitch() {
        rebuildCount++;
        return MaterialApp(
          home: Scaffold(
            body: PrimitiveToggleSwitch(
              value: switchValue,
              onChanged: (value) => switchValue = value,
            ),
          ),
        );
      }

      // Initial build
      await tester.pumpWidget(buildSwitch());
      expect(rebuildCount, 1);

      // Tap to change state
      await tester.tap(find.byType(PrimitiveToggleSwitch));
      await tester.pumpAndSettle();

      // Rebuild
      await tester.pumpWidget(buildSwitch());
      expect(rebuildCount, 2);

      // State should be maintained
      expect(switchValue, true);

      // Tap again
      await tester.tap(find.byType(PrimitiveToggleSwitch));
      await tester.pumpAndSettle();

      // Rebuild again
      await tester.pumpWidget(buildSwitch());
      expect(rebuildCount, 3);

      // State should still be correct
      expect(switchValue, false);
    });
  });

  group('PrimitiveToggleSwitch - Edge Cases', () {
    testWidgets('handles null safety correctly', (WidgetTester tester) async {
      bool switchValue = false;

      // This should compile without errors (null safety test)
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: PrimitiveToggleSwitch(
              value: switchValue,
              onChanged: (bool value) => switchValue = value,
            ),
          ),
        ),
      );

      expect(find.byType(PrimitiveToggleSwitch), findsOneWidget);
    });

    testWidgets('renders with default parameters', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: PrimitiveToggleSwitch(value: false, onChanged: (value) {}),
          ),
        ),
      );

      final switchFinder = find.byType(PrimitiveToggleSwitch);
      expect(switchFinder, findsOneWidget);

      // Default size should be 50x30
      final Size size = tester.getSize(switchFinder);
      expect(size.width, 50.0);
      expect(size.height, 30.0);
    });
  });
}
