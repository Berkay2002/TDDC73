import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:primitive_ui/primitive_ui.dart';

void main() {
  testWidgets('PrimitiveSlider renders correctly', (WidgetTester tester) async {
    await tester.pumpWidget(
      Directionality(
        textDirection: TextDirection.ltr,
        child: Center(child: PrimitiveSlider(value: 0.5, onChanged: (value) {})),
      ),
    );

    expect(find.byType(PrimitiveSlider), findsOneWidget);
    expect(find.byType(CustomPaint), findsOneWidget);
  });

  testWidgets('PrimitiveSlider updates value on drag', (
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
                return PrimitiveSlider(
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
    final Finder sliderFinder = find.byType(PrimitiveSlider);

    // Drag from left to right
    await tester.drag(sliderFinder, const Offset(100.0, 0.0));
    await tester.pump();

    // Value should have increased
    expect(currentValue, greaterThan(0.0));
  });

  testWidgets('PrimitiveSlider respects min and max', (WidgetTester tester) async {
    double currentValue = 10.0;

    await tester.pumpWidget(
      Directionality(
        textDirection: TextDirection.ltr,
        child: Center(
          child: SizedBox(
            width: 200,
            child: PrimitiveSlider(
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

    final Finder sliderFinder = find.byType(PrimitiveSlider);

    // Drag to the end
    await tester.drag(sliderFinder, const Offset(200.0, 0.0));
    await tester.pump();

    // Should be close to max
    expect(currentValue, closeTo(20.0, 0.1));
  });

  testWidgets('PrimitiveSlider accepts animation properties', (
    WidgetTester tester,
  ) async {
    const duration = Duration(seconds: 1);
    const curve = Curves.elasticIn;

    await tester.pumpWidget(
      Directionality(
        textDirection: TextDirection.ltr,
        child: PrimitiveSlider(
          value: 0.5,
          duration: duration,
          curve: curve,
          onChanged: (v) {},
        ),
      ),
    );

    final slider = tester.widget<PrimitiveSlider>(find.byType(PrimitiveSlider));
    expect(slider.duration, equals(duration));
    expect(slider.curve, equals(curve));
  });
}
