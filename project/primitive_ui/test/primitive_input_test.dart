import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:primitive_ui/primitive_ui.dart';

void main() {
  group('PrimitiveInput', () {
    testWidgets('renders initial value', (WidgetTester tester) async {
      final controller = TextEditingController(text: 'Initial Text');
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: PrimitiveInput(
              controller: controller,
            ),
          ),
        ),
      );

      expect(find.text('Initial Text'), findsOneWidget);
    });

    testWidgets('renders placeholder when empty', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: PrimitiveInput(
              placeholder: 'Enter text here',
            ),
          ),
        ),
      );

      expect(find.text('Enter text here'), findsOneWidget);
    });

    testWidgets('updates text on input', (WidgetTester tester) async {
      String? changedValue;
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: PrimitiveInput(
              onChanged: (val) => changedValue = val,
            ),
          ),
        ),
      );

      await tester.enterText(find.byType(EditableText), 'New Value');
      expect(changedValue, 'New Value');
      expect(find.text('New Value'), findsOneWidget);
    });

    testWidgets('obscures text when obscureText is true', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: PrimitiveInput(
              obscureText: true,
              controller: null, // Let it use internal controller
            ),
          ),
        ),
      );

      final editableText = tester.widget<EditableText>(find.byType(EditableText));
      expect(editableText.obscureText, isTrue);
    });
  });
}
