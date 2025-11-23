import 'package:flutter/material.dart';
import 'widgets/credit_card_form.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Credit Card Form',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: const Color(0xFFDDEEFC),
        fontFamily: 'Roboto',
      ),
      home: const CreditCardFormPage(),
    );
  }
}

class CreditCardFormPage extends StatelessWidget {
  const CreditCardFormPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 570),
                child: const CreditCardForm(),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
