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
    // Height of the card to calculate overlap
    const double cardHeight = 270;
    const double cardOverlap = cardHeight / 2 + 50; // How much the card overlaps the form

    return Stack(
      clipBehavior: Clip.none,
      children: [
        // Form container with top padding to make room for the overlapping card
        Padding(
          padding: const EdgeInsets.only(top: cardOverlap),
          child: CardInputFields(
            cardData: _cardData,
            onCardFlip: _onCardFlip,
            onFocusChange: _onFocusChange,
            topPadding: cardHeight - cardOverlap + 35, // Extra padding inside form for card
          ),
        ),
        // Credit card positioned on top, overlapping the form
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: CreditCardWidget(
                cardData: _cardData,
                isFlipped: _isCardFlipped,
                currentFocus: _currentFocus,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
