import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/repository_provider.dart';
import 'screens/repository_list_screen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => RepositoryProvider(),
      child: MaterialApp(
        title: 'GitHub Trending',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const RepositoryListScreen(),
      ),
    );
  }
}
