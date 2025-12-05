import 'package:flutter/foundation.dart';

enum CardType { visa, mastercard, amex, discover, troy, unknown }

class CardData extends ChangeNotifier {
  String _cardNumber = '';
  String _cardName = '';
  String _cardMonth = '';
  String _cardYear = '';
  String _cardCvv = '';

  String get cardNumber => _cardNumber;
  String get cardName => _cardName;
  String get cardMonth => _cardMonth;
  String get cardYear => _cardYear;
  String get cardCvv => _cardCvv;

  CardType get cardType {
    if (_cardNumber.isEmpty) return CardType.visa;

    if (RegExp(r'^4').hasMatch(_cardNumber)) {
      return CardType.visa;
    }
    if (RegExp(r'^(34|37)').hasMatch(_cardNumber)) {
      return CardType.amex;
    }
    if (RegExp(r'^5[1-5]').hasMatch(_cardNumber)) {
      return CardType.mastercard;
    }
    if (RegExp(r'^6011').hasMatch(_cardNumber)) {
      return CardType.discover;
    }
    if (RegExp(r'^9792').hasMatch(_cardNumber)) {
      return CardType.troy;
    }

    return CardType.visa;
  }

  bool get isAmex => cardType == CardType.amex;

  int get maxCardNumberLength => isAmex ? 15 : 16;

  int get maxCvvLength => isAmex ? 4 : 3;

  set cardNumber(String value) {
    _cardNumber = value;
    notifyListeners();
  }

  set cardName(String value) {
    _cardName = value;
    notifyListeners();
  }

  set cardMonth(String value) {
    _cardMonth = value;
    notifyListeners();
  }

  set cardYear(String value) {
    _cardYear = value;
    notifyListeners();
  }

  set cardCvv(String value) {
    _cardCvv = value;
    notifyListeners();
  }
}
