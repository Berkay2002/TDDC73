import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:primitive_ui/primitive_ui.dart';

void main() {
  testWidgets('CustomCircularProgress renders correctly', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      const Directionality(
        textDirection: TextDirection.ltr,
        child: Center(child: CustomCircularProgress()),
      ),
    );

    expect(find.byType(CustomCircularProgress), findsOneWidget);
    expect(find.byType(CustomPaint), findsOneWidget);
  });

  testWidgets('CustomCircularProgress animates', (WidgetTester tester) async {
    await tester.pumpWidget(
      const Directionality(
        textDirection: TextDirection.ltr,
        child: Center(child: CustomCircularProgress()),
      ),
    );

    // Initial state
    expect(find.byType(CustomCircularProgress), findsOneWidget);

    // Advance time
    await tester.pump(const Duration(milliseconds: 500));

    // It should still be there, and we assume the internal animation controller is running.
    // Verifying exact painting is hard without golden tests, but we can verify it doesn't crash
    // and rebuilds.
    expect(find.byType(CustomCircularProgress), findsOneWidget);
  });
}
