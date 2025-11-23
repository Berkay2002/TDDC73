import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:primitive_ui/primitive_ui.dart';

void main() {
  testWidgets('CustomSlider renders correctly', (WidgetTester tester) async {
    await tester.pumpWidget(
      Directionality(
        textDirection: TextDirection.ltr,
        child: Center(child: CustomSlider(value: 0.5, onChanged: (value) {})),
      ),
    );

    expect(find.byType(CustomSlider), findsOneWidget);
    expect(find.byType(CustomPaint), findsOneWidget);
  });

  testWidgets('CustomSlider updates value on drag', (
    WidgetTester tester,
  ) async {
    double currentValue = 0.0;

    await tester.pumpWidget(
      Directionality(
        textDirection: TextDirection.ltr,
        child: Center(
          child: SizedBox(
            width: 200,
            child: StatefulBuilder(
              builder: (context, setState) {
                return CustomSlider(
                  value: currentValue,
                  onChanged: (value) {
                    setState(() {
                      currentValue = value;
                    });
                  },
                );
              },
            ),
          ),
        ),
      ),
    );

    // Find the slider
    final Finder sliderFinder = find.byType(CustomSlider);

    // Drag from left to right
    await tester.drag(sliderFinder, const Offset(100.0, 0.0));
    await tester.pump();

    // Value should have increased
    expect(currentValue, greaterThan(0.0));
  });

  testWidgets('CustomSlider respects min and max', (WidgetTester tester) async {
    double currentValue = 10.0;

    await tester.pumpWidget(
      Directionality(
        textDirection: TextDirection.ltr,
        child: Center(
          child: SizedBox(
            width: 200,
            child: CustomSlider(
              value: currentValue,
              min: 10.0,
              max: 20.0,
              onChanged: (value) {
                currentValue = value;
              },
            ),
          ),
        ),
      ),
    );

    final Finder sliderFinder = find.byType(CustomSlider);

    // Drag to the end
    await tester.drag(sliderFinder, const Offset(200.0, 0.0));
    await tester.pump();

    // Should be close to max
    expect(currentValue, closeTo(20.0, 0.1));
  });
}
