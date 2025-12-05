import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../models/card_data.dart';

class CardInputFields extends StatefulWidget {
  final CardData cardData;
  final Function(bool) onCardFlip;
  final Function(FocusNode?) onFocusChange;
  final double topPadding;

  const CardInputFields({
    super.key,
    required this.cardData,
    required this.onCardFlip,
    required this.onFocusChange,
    this.topPadding = 35,
  });

  @override
  State<CardInputFields> createState() => _CardInputFieldsState();
}

class _CardInputFieldsState extends State<CardInputFields> {
  final _formKey = GlobalKey<FormState>();
  final _cardNumberController = TextEditingController();
  final _cardNameController = TextEditingController();
  final _cvvController = TextEditingController();

  final _cardNumberFocus = FocusNode();
  final _cardNameFocus = FocusNode();
  final _cvvFocus = FocusNode();
  final _monthFocus = FocusNode();
  final _yearFocus = FocusNode();

  String _selectedMonth = '';
  String _selectedYear = '';
  final int _minYear = DateTime.now().year;

  @override
  void initState() {
    super.initState();
    _setupFocusListeners();
  }

  void _setupFocusListeners() {
    _cardNumberFocus.addListener(() {
      widget.onFocusChange(_cardNumberFocus.hasFocus ? _cardNumberFocus : null);
    });
    _cardNameFocus.addListener(() {
      widget.onFocusChange(_cardNameFocus.hasFocus ? _cardNameFocus : null);
    });
    _cvvFocus.addListener(() {
      widget.onCardFlip(_cvvFocus.hasFocus);
      widget.onFocusChange(_cvvFocus.hasFocus ? _cvvFocus : null);
    });
    _monthFocus.addListener(() {
      widget.onFocusChange(_monthFocus.hasFocus ? _monthFocus : null);
    });
    _yearFocus.addListener(() {
      widget.onFocusChange(_yearFocus.hasFocus ? _yearFocus : null);
    });
  }

  @override
  void dispose() {
    _cardNumberController.dispose();
    _cardNameController.dispose();
    _cvvController.dispose();
    _cardNumberFocus.dispose();
    _cardNameFocus.dispose();
    _cvvFocus.dispose();
    _monthFocus.dispose();
    _yearFocus.dispose();
    super.dispose();
  }

  String _formatCardNumber(String value) {
    final cleanValue = value.replaceAll(' ', '');
    widget.cardData.cardNumber = cleanValue;

    final isAmex = widget.cardData.isAmex;
    final buffer = StringBuffer();

    for (int i = 0; i < cleanValue.length; i++) {
      buffer.write(cleanValue[i]);
      if (isAmex) {
        if (i == 3 || i == 9) buffer.write(' ');
      } else {
        if ((i + 1) % 4 == 0 && i != cleanValue.length - 1) {
          buffer.write(' ');
        }
      }
    }

    return buffer.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF5A7494).withValues(alpha: 0.4),
            blurRadius: 60,
            offset: const Offset(0, 30),
          ),
        ],
      ),
      padding: EdgeInsets.fromLTRB(35, widget.topPadding, 35, 35),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildCardNumberField(),
            const SizedBox(height: 20),
            _buildCardNameField(),
            const SizedBox(height: 20),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: _buildExpirationFields()),
                const SizedBox(width: 35),
                SizedBox(width: 150, child: _buildCvvField()),
              ],
            ),
            const SizedBox(height: 20),
            _buildSubmitButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildCardNumberField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Card Number',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Color(0xFF1A3B5D),
          ),
        ),
        const SizedBox(height: 5),
        TextFormField(
          controller: _cardNumberController,
          focusNode: _cardNumberFocus,
          keyboardType: TextInputType.number,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
            LengthLimitingTextInputFormatter(16),
            _CardNumberInputFormatter(),
          ],
          onChanged: (value) {
            setState(() {
              _formatCardNumber(value);
            });
          },
          decoration: InputDecoration(
            hintText: '#### #### #### ####',
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 15,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: const BorderSide(color: Color(0xFFCED6E0)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: const BorderSide(color: Color(0xFFCED6E0)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: const BorderSide(color: Color(0xFF3D9CFF)),
            ),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter card number';
            }
            final cleanValue = value.replaceAll(' ', '');
            if (cleanValue.length < 13) {
              return 'Card number is too short';
            }
            return null;
          },
        ),
      ],
    );
  }

  Widget _buildCardNameField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Card Holder',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Color(0xFF1A3B5D),
          ),
        ),
        const SizedBox(height: 5),
        TextFormField(
          controller: _cardNameController,
          focusNode: _cardNameFocus,
          textCapitalization: TextCapitalization.characters,
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z\s]')),
          ],
          onChanged: (value) {
            setState(() {
              widget.cardData.cardName = value;
            });
          },
          decoration: InputDecoration(
            hintText: 'Full Name',
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 15,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: const BorderSide(color: Color(0xFFCED6E0)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: const BorderSide(color: Color(0xFFCED6E0)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: const BorderSide(color: Color(0xFF3D9CFF)),
            ),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter card holder name';
            }
            return null;
          },
        ),
      ],
    );
  }

  Widget _buildExpirationFields() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Expiration Date',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Color(0xFF1A3B5D),
          ),
        ),
        const SizedBox(height: 5),
        Row(
          children: [
            Expanded(
              child: DropdownButtonFormField<String>(
                focusNode: _monthFocus,
                initialValue: _selectedMonth.isEmpty ? null : _selectedMonth,
                decoration: InputDecoration(
                  hintText: 'Month',
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 15,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: const BorderSide(color: Color(0xFFCED6E0)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: const BorderSide(color: Color(0xFFCED6E0)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: const BorderSide(color: Color(0xFF3D9CFF)),
                  ),
                ),
                items: List.generate(12, (index) {
                  final month = (index + 1).toString().padLeft(2, '0');
                  final minMonth = _selectedYear == _minYear.toString()
                      ? DateTime.now().month
                      : 1;
                  return DropdownMenuItem(
                    value: month,
                    enabled: (index + 1) >= minMonth,
                    child: Text(month),
                  );
                }),
                onChanged: (value) {
                  setState(() {
                    _selectedMonth = value ?? '';
                    widget.cardData.cardMonth = _selectedMonth;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Required';
                  }
                  return null;
                },
              ),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: DropdownButtonFormField<String>(
                focusNode: _yearFocus,
                initialValue: _selectedYear.isEmpty ? null : _selectedYear,
                decoration: InputDecoration(
                  hintText: 'Year',
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 15,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: const BorderSide(color: Color(0xFFCED6E0)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: const BorderSide(color: Color(0xFFCED6E0)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: const BorderSide(color: Color(0xFF3D9CFF)),
                  ),
                ),
                items: List.generate(12, (index) {
                  final year = (_minYear + index).toString();
                  return DropdownMenuItem(value: year, child: Text(year));
                }),
                onChanged: (value) {
                  setState(() {
                    _selectedYear = value ?? '';
                    widget.cardData.cardYear = _selectedYear;
                    if (_selectedMonth.isNotEmpty) {
                      final minMonth = _selectedYear == _minYear.toString()
                          ? DateTime.now().month
                          : 1;
                      if (int.parse(_selectedMonth) < minMonth) {
                        _selectedMonth = '';
                        widget.cardData.cardMonth = '';
                      }
                    }
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Required';
                  }
                  return null;
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildCvvField() {
    final maxCvvLength = widget.cardData.maxCvvLength;
    
    // Trim CVV if it exceeds the max length for current card type
    if (_cvvController.text.length > maxCvvLength) {
      _cvvController.text = _cvvController.text.substring(0, maxCvvLength);
      widget.cardData.cardCvv = _cvvController.text;
    }
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'CVV',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Color(0xFF1A3B5D),
          ),
        ),
        const SizedBox(height: 5),
        TextFormField(
          controller: _cvvController,
          focusNode: _cvvFocus,
          keyboardType: TextInputType.number,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
            LengthLimitingTextInputFormatter(maxCvvLength),
          ],
          onChanged: (value) {
            setState(() {
              widget.cardData.cardCvv = value;
            });
          },
          decoration: InputDecoration(
            hintText: '###',
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 15,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: const BorderSide(color: Color(0xFFCED6E0)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: const BorderSide(color: Color(0xFFCED6E0)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: const BorderSide(color: Color(0xFF3D9CFF)),
            ),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Required';
            }
            if (value.length < maxCvvLength) {
              return 'Invalid CVV';
            }
            return null;
          },
        ),
      ],
    );
  }

  Widget _buildSubmitButton() {
    return ElevatedButton(
      onPressed: () {
        if (_formKey.currentState!.validate()) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Card information submitted successfully!'),
              backgroundColor: Colors.green,
            ),
          );
        }
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF2364D2),
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 18),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        elevation: 5,
        shadowColor: const Color(0xFF2364D2).withValues(alpha: 0.3),
      ),
      child: const Text(
        'Submit',
        style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
      ),
    );
  }
}

class _CardNumberInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final text = newValue.text;
    if (text.isEmpty) return newValue;

    final buffer = StringBuffer();
    for (int i = 0; i < text.length; i++) {
      buffer.write(text[i]);
      final nonZeroIndex = i + 1;
      if (nonZeroIndex % 4 == 0 && nonZeroIndex != text.length) {
        buffer.write(' ');
      }
    }

    final string = buffer.toString();
    return newValue.copyWith(
      text: string,
      selection: TextSelection.collapsed(offset: string.length),
    );
  }
}
