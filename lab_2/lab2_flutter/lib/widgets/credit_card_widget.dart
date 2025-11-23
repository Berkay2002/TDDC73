import 'package:flutter/material.dart';
import 'dart:math' as math;
import '../models/card_data.dart';

class CreditCardWidget extends StatefulWidget {
  final CardData cardData;
  final bool isFlipped;
  final FocusNode? currentFocus;

  const CreditCardWidget({
    super.key,
    required this.cardData,
    required this.isFlipped,
    this.currentFocus,
  });

  @override
  State<CreditCardWidget> createState() => _CreditCardWidgetState();
}

class _CreditCardWidgetState extends State<CreditCardWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _flipController;
  late Animation<double> _flipAnimation;

  @override
  void initState() {
    super.initState();
    _flipController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    _flipAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _flipController, curve: Curves.easeInOut),
    );

    widget.cardData.addListener(_onCardDataChanged);
  }

  void _onCardDataChanged() {
    setState(() {});
  }

  @override
  void didUpdateWidget(CreditCardWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isFlipped != oldWidget.isFlipped) {
      if (widget.isFlipped) {
        _flipController.forward();
      } else {
        _flipController.reverse();
      }
    }
  }

  @override
  void dispose() {
    widget.cardData.removeListener(_onCardDataChanged);
    _flipController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _flipAnimation,
      builder: (context, child) {
        final angle = _flipAnimation.value * math.pi;
        final isBack = angle > math.pi / 2;

        return Transform(
          alignment: Alignment.center,
          transform: Matrix4.identity()
            ..setEntry(3, 2, 0.001)
            ..rotateY(angle),
          child: isBack
              ? Transform(
                  alignment: Alignment.center,
                  transform: Matrix4.identity()..rotateY(math.pi),
                  child: _buildBackCard(),
                )
              : _buildFrontCard(),
        );
      },
    );
  }

  Widget _buildFrontCard() {
    return Container(
      width: double.infinity,
      constraints: const BoxConstraints(maxWidth: 430, maxHeight: 270),
      child: AspectRatio(
        aspectRatio: 1.586,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFF4158D0), Color(0xFF8555C7), Color(0xFF2364D2)],
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.3),
                blurRadius: 30,
                offset: const Offset(0, 20),
              ),
            ],
          ),
          child: Stack(
            children: [
              if (widget.currentFocus != null) _buildFocusHighlight(),
              Padding(
                padding: const EdgeInsets.all(25),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildCardTop(),
                    const Spacer(),
                    _buildCardNumber(),
                    const SizedBox(height: 20),
                    _buildCardBottom(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFocusHighlight() {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 350),
      curve: Curves.easeInOut,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.65),
          width: 2,
        ),
      ),
    );
  }

  Widget _buildCardTop() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Image.network(
          'https://raw.githubusercontent.com/muhammederdem/credit-card-form/master/src/assets/images/chip.png',
          width: 60,
          errorBuilder: (context, error, stackTrace) {
            return Container(
              width: 60,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.amber.shade200,
                borderRadius: BorderRadius.circular(5),
              ),
            );
          },
        ),
        _buildCardTypeLogo(),
      ],
    );
  }

  Widget _buildCardTypeLogo() {
    final cardTypeStr = widget.cardData.cardType.name;
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      transitionBuilder: (Widget child, Animation<double> animation) {
        return FadeTransition(
          opacity: animation,
          child: SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0, -0.3),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          ),
        );
      },
      child: SizedBox(
        key: ValueKey<String>(cardTypeStr),
        height: 45,
        child: Image.network(
          'https://raw.githubusercontent.com/muhammederdem/credit-card-form/master/src/assets/images/$cardTypeStr.png',
          fit: BoxFit.contain,
          errorBuilder: (context, error, stackTrace) {
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }

  Widget _buildCardNumber() {
    final cardNumber = widget.cardData.cardNumber;
    final isAmex = widget.cardData.isAmex;
    final mask = isAmex ? '#### ###### #####' : '#### #### #### ####';
    final maskChars = mask.split('');

    return Text(
      _formatCardNumber(cardNumber, maskChars),
      style: const TextStyle(
        color: Colors.white,
        fontSize: 24,
        fontFamily: 'Courier',
        letterSpacing: 2,
        shadows: [
          Shadow(color: Colors.black45, offset: Offset(2, 2), blurRadius: 4),
        ],
      ),
    );
  }

  String _formatCardNumber(String number, List<String> maskChars) {
    final result = StringBuffer();
    int numberIndex = 0;

    for (int i = 0; i < maskChars.length; i++) {
      if (maskChars[i] == ' ') {
        result.write(' ');
      } else if (numberIndex < number.length) {
        if (numberIndex > 4 &&
            numberIndex < (widget.cardData.isAmex ? 11 : 12)) {
          result.write('*');
        } else {
          result.write(number[numberIndex]);
        }
        numberIndex++;
      } else {
        result.write('#');
      }
    }
    return result.toString();
  }

  Widget _buildCardBottom() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(child: _buildCardHolder()),
        _buildExpiryDate(),
      ],
    );
  }

  Widget _buildCardHolder() {
    final name = widget.cardData.cardName.toUpperCase();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'CARD HOLDER',
          style: TextStyle(
            color: Colors.white.withValues(alpha: 0.7),
            fontSize: 10,
          ),
        ),
        const SizedBox(height: 4),
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          child: Text(
            name.isEmpty ? 'FULL NAME' : name,
            key: ValueKey<String>(name),
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              letterSpacing: 1,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  Widget _buildExpiryDate() {
    final month = widget.cardData.cardMonth;
    final year = widget.cardData.cardYear;
    final yearShort = year.length >= 2 ? year.substring(year.length - 2) : year;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'EXPIRES',
          style: TextStyle(
            color: Colors.white.withValues(alpha: 0.7),
            fontSize: 10,
          ),
        ),
        const SizedBox(height: 4),
        Row(
          children: [
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: Text(
                month.isEmpty ? 'MM' : month,
                key: ValueKey<String>(month),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  letterSpacing: 1,
                ),
              ),
            ),
            const Text(
              ' / ',
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: Text(
                yearShort.isEmpty ? 'YY' : yearShort,
                key: ValueKey<String>(yearShort),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  letterSpacing: 1,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildBackCard() {
    return Container(
      width: double.infinity,
      constraints: const BoxConstraints(maxWidth: 430, maxHeight: 270),
      child: AspectRatio(
        aspectRatio: 1.586,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFF4158D0), Color(0xFF8555C7), Color(0xFF2364D2)],
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.3),
                blurRadius: 30,
                offset: const Offset(0, 20),
              ),
            ],
          ),
          child: Column(
            children: [
              const SizedBox(height: 30),
              Container(
                width: double.infinity,
                height: 50,
                color: Colors.black.withValues(alpha: 0.8),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const Text(
                      'CVV',
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    ),
                    const SizedBox(height: 5),
                    Container(
                      width: double.infinity,
                      height: 45,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      alignment: Alignment.centerRight,
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        '*' * widget.cardData.cardCvv.length,
                        style: const TextStyle(
                          color: Color(0xFF1A3B5D),
                          fontSize: 18,
                          letterSpacing: 2,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    _buildCardTypeLogo(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
