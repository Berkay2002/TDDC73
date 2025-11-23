// Note 1: Import statements bring in external libraries and modules
// Flutter provides the UI framework through 'material.dart'
import 'package:flutter/material.dart';

// Note 2: Provider is a state management solution for Flutter
// It allows widgets to access shared data without passing it through constructors
import 'package:provider/provider.dart';

// Note 3: Import our custom classes from the project structure
// These organize the app into logical layers (providers, screens)
import 'providers/repository_provider.dart';
import 'screens/repository_list_screen.dart';

// Note 4: The main() function is the entry point of every Dart application
// In Flutter, it typically calls runApp() to start the widget tree
void main() {
  runApp(const MainApp());
}

// Note 5: StatelessWidget is immutable - its properties cannot change after creation
// Using 'const' constructor improves performance by reusing widget instances
class MainApp extends StatelessWidget {
  const MainApp({super.key});

  // Note 6: The build method describes how to display the widget
  // It's called whenever the framework needs to render this widget
  @override
  Widget build(BuildContext context) {
    // Note 7: ChangeNotifierProvider makes RepositoryProvider available to descendant widgets
    // It creates an instance and automatically disposes of it when no longer needed
    return ChangeNotifierProvider(
      // Note 8: The create callback instantiates the provider
      // The underscore (_) indicates the context parameter is intentionally unused
      create: (_) => RepositoryProvider(),
      child: MaterialApp(
        title: 'GitHub Trending',

        // Note 9: Removes the debug banner shown in the top-right corner during development
        debugShowCheckedModeBanner: false,

        // Note 10: Material Design 3 theming system for light mode
        theme: ThemeData(
          // Note 11: ColorScheme.fromSeed generates a harmonious color palette
          // Using GitHub's green (#2DA44E) as the seed color for brand consistency
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color(0xFF2DA44E),
            brightness: Brightness.light,
          ),

          // Note 12: Material 3 introduces updated component designs and interactions
          useMaterial3: true,

          // Note 13: CardTheme customizes the appearance of all Card widgets
          cardTheme: CardThemeData(
            // Note 14: Elevation of 0 creates flat cards for a modern, clean look
            elevation: 0,

            // Note 15: Rounded corners with a subtle border instead of shadow
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              side: BorderSide(color: Colors.grey.shade200),
            ),
          ),

          // Note 16: Customize chip widgets (used for language and filter tags)
          chipTheme: ChipThemeData(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),

          // Note 17: AppBarTheme controls the styling of all AppBar widgets
          // centerTitle: false aligns title to the left (Material Design standard)
          appBarTheme: const AppBarTheme(centerTitle: false, elevation: 0),
        ),

        // Note 18: Dark theme configuration for automatic theme switching
        darkTheme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color(0xFF2DA44E),
            // Note 19: brightness: Brightness.dark generates dark-mode-appropriate colors
            brightness: Brightness.dark,
          ),
          useMaterial3: true,
          cardTheme: CardThemeData(
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              // Note 20: Dark mode uses darker borders for better contrast
              side: BorderSide(color: Colors.grey.shade800),
            ),
          ),
          appBarTheme: const AppBarTheme(centerTitle: false, elevation: 0),
        ),

        // Note 21: ThemeMode.system automatically switches between light and dark themes
        // based on the user's system preferences
        themeMode: ThemeMode.system,

        // Note 22: The home property defines the default route (initial screen)
        home: const RepositoryListScreen(),
      ),
    );
  }
}
