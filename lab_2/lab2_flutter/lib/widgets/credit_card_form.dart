import 'package:flutter/material.dart';
import 'credit_card_widget.dart';
import 'card_input_fields.dart';
import '../models/card_data.dart';

class CreditCardForm extends StatefulWidget {
  const CreditCardForm({super.key});

  @override
  State<CreditCardForm> createState() => _CreditCardFormState();
}

class _CreditCardFormState extends State<CreditCardForm> {
  final CardData _cardData = CardData();
  bool _isCardFlipped = false;
  FocusNode? _currentFocus;

  void _onCardFlip(bool shouldFlip) {
    setState(() {
      _isCardFlipped = shouldFlip;
    });
  }

  void _onFocusChange(FocusNode? focusNode) {
    setState(() {
      _currentFocus = focusNode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CreditCardWidget(
          cardData: _cardData,
          isFlipped: _isCardFlipped,
          currentFocus: _currentFocus,
        ),
        const SizedBox(height: 40),
        CardInputFields(
          cardData: _cardData,
          onCardFlip: _onCardFlip,
          onFocusChange: _onFocusChange,
        ),
      ],
    );
  }
}
