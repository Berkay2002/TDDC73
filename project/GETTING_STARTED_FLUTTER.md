# Getting Started with Flutter

**Target Audience:** Programmers new to Flutter  
**Purpose:** A comprehensive introduction to Flutter development for programmers with experience in other languages/frameworks.

---

## Table of Contents

1. [Introduction to Flutter](#introduction-to-flutter)
2. [Setting Up Flutter](#setting-up-flutter)
3. [Your First Flutter App](#your-first-flutter-app)
4. [Basic Layouts and Widgets](#basic-layouts-and-widgets)
5. [Event Handling and State Management](#event-handling-and-state-management)
6. [Navigation Between Screens](#navigation-between-screens)
7. [Running and Debugging](#running-and-debugging)
8. [Next Steps](#next-steps)

---

## Introduction to Flutter

**Flutter** is Google's UI toolkit for building natively compiled applications for mobile, web, and desktop from a single codebase. It uses the **Dart** programming language and provides a rich set of pre-designed widgets.

### Key Concepts

- **Everything is a Widget:** In Flutter, UI components are called widgets. Buttons, text, layouts, and even the app itself are widgets.
- **Declarative UI:** You describe what the UI should look like for a given state, and Flutter handles the rendering.
- **Hot Reload:** Make changes to your code and see them instantly without losing app state.
- **Native Performance:** Flutter compiles to native ARM code for optimal performance.

### Widget Types

- **Stateless Widgets:** Immutable widgets that don't change over time (e.g., static text, icons).
- **Stateful Widgets:** Widgets that maintain state and can rebuild when state changes (e.g., checkboxes, forms).

---

## Setting Up Flutter

### Prerequisites

- **Operating System:** Windows, macOS, or Linux
- **Disk Space:** At least 2.8 GB (excluding IDE/tools)
- **Git:** For version control and Flutter installation

### Installation Steps

#### 1. Download Flutter SDK

Visit [flutter.dev](https://flutter.dev/docs/get-started/install) and download the Flutter SDK for your operating system.

**For Windows:**
```powershell
# Extract the zip file to a location (e.g., C:\src\flutter)
# Avoid installing in C:\Program Files\ (requires elevated privileges)
```

#### 2. Add Flutter to PATH

**Windows:**
- Search for "Environment Variables" in Start Menu
- Edit the `Path` variable under User Variables
- Add the full path to `flutter\bin` (e.g., `C:\src\flutter\bin`)

**macOS/Linux:**
```bash
# Add to ~/.bashrc or ~/.zshrc
export PATH="$PATH:`pwd`/flutter/bin"
```

#### 3. Run Flutter Doctor

Open a terminal and run:

```bash
flutter doctor
```

This command checks your environment and displays a report. Follow the instructions to install any missing dependencies:

- **Android Studio** (for Android development)
- **Xcode** (for iOS development on macOS)
- **Visual Studio** (for Windows desktop development)

#### 4. Install an IDE

**Recommended Options:**
- **Visual Studio Code** with Flutter extension (lightweight, fast)
- **Android Studio** with Flutter plugin (full-featured)

**VS Code Setup:**
1. Install [Visual Studio Code](https://code.visualstudio.com/)
2. Install the Flutter extension from the Extensions marketplace
3. Run `Flutter: New Project` from the command palette

---

## Your First Flutter App

### Creating a New Project

```bash
# Create a new Flutter project
flutter create my_first_app

# Navigate to the project directory
cd my_first_app

# Run the app
flutter run
```

### Project Structure

```
my_first_app/
├── android/          # Android-specific code
├── ios/              # iOS-specific code
├── lib/              # Your Dart code
│   └── main.dart     # Entry point
├── test/             # Unit and widget tests
├── pubspec.yaml      # Project configuration and dependencies
└── README.md
```

### Understanding main.dart

Every Flutter app starts with a `main()` function:

```dart
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My First App',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Hello Flutter'),
        ),
        body: const Center(
          child: Text('Hello, World!'),
        ),
      ),
    );
  }
}
```

**Breakdown:**
- `main()`: Entry point that calls `runApp()`
- `MyApp`: Root widget extending `StatelessWidget`
- `MaterialApp`: Wraps the app with Material Design
- `Scaffold`: Provides basic visual structure (app bar, body)
- `Center`: Centers its child widget
- `Text`: Displays a string

---

## Basic Layouts and Widgets

Flutter provides a rich set of widgets for building layouts. Here are the most common ones:

### Container

A versatile widget that can contain decoration, padding, and constraints.

```dart
Container(
  width: 200,
  height: 100,
  padding: const EdgeInsets.all(16.0),
  margin: const EdgeInsets.symmetric(vertical: 8.0),
  decoration: BoxDecoration(
    color: Colors.blue,
    borderRadius: BorderRadius.circular(8.0),
  ),
  child: const Text(
    'Hello',
    style: TextStyle(color: Colors.white),
  ),
)
```

**Properties:**
- `width`, `height`: Dimensions
- `padding`: Internal spacing
- `margin`: External spacing
- `decoration`: Background color, borders, shadows
- `child`: Single child widget

### Column and Row

Layout widgets that arrange children vertically or horizontally.

```dart
// Vertical layout
Column(
  mainAxisAlignment: MainAxisAlignment.center,
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
    Text('First Item'),
    Text('Second Item'),
    Text('Third Item'),
  ],
)

// Horizontal layout
Row(
  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  children: [
    Icon(Icons.star),
    Icon(Icons.favorite),
    Icon(Icons.share),
  ],
)
```

**Alignment Options:**
- `MainAxisAlignment`: How children are positioned along the main axis
  - `start`, `center`, `end`, `spaceBetween`, `spaceEvenly`, `spaceAround`
- `CrossAxisAlignment`: How children are positioned along the cross axis
  - `start`, `center`, `end`, `stretch`

### SizedBox

Creates fixed-size spacing or constrains child size.

```dart
// Spacing between widgets
Column(
  children: [
    Text('First'),
    const SizedBox(height: 16.0), // 16px vertical spacing
    Text('Second'),
  ],
)

// Constraining size
SizedBox(
  width: 100,
  height: 100,
  child: Image.network('https://example.com/image.png'),
)
```

### Expanded and Flexible

Make children fill available space in Row/Column.

```dart
Row(
  children: [
    Expanded(
      flex: 2,
      child: Container(color: Colors.red, height: 50),
    ),
    Expanded(
      flex: 1,
      child: Container(color: Colors.blue, height: 50),
    ),
  ],
)
```

### Stack

Overlays widgets on top of each other.

```dart
Stack(
  alignment: Alignment.center,
  children: [
    Container(
      width: 200,
      height: 200,
      color: Colors.blue,
    ),
    const Text(
      'Overlay Text',
      style: TextStyle(color: Colors.white, fontSize: 24),
    ),
  ],
)
```

### Padding

Adds padding around a widget.

```dart
Padding(
  padding: const EdgeInsets.all(16.0),
  child: Text('Padded text'),
)

// Different padding on each side
Padding(
  padding: const EdgeInsets.only(
    left: 16.0,
    top: 8.0,
    right: 16.0,
    bottom: 8.0,
  ),
  child: Text('Custom padding'),
)
```

### Complete Layout Example

```dart
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Layout Example'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Profile',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16.0),
              Row(
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: const Icon(Icons.person, color: Colors.white),
                  ),
                  const SizedBox(width: 16.0),
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('John Doe', style: TextStyle(fontSize: 18)),
                      Text('Software Developer', style: TextStyle(color: Colors.grey)),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 24.0),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: const Text('This is a card-like container with padding and background color.'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
```

---

## Event Handling and State Management

Flutter uses callbacks for event handling and `setState()` for managing state in stateful widgets.

### Buttons and Callbacks

```dart
// ElevatedButton with callback
ElevatedButton(
  onPressed: () {
    print('Button pressed!');
  },
  child: const Text('Click Me'),
)

// TextButton
TextButton(
  onPressed: () {
    print('Text button pressed!');
  },
  child: const Text('Text Button'),
)

// IconButton
IconButton(
  icon: const Icon(Icons.favorite),
  onPressed: () {
    print('Icon button pressed!');
  },
)
```

### Stateful Widgets and setState()

Stateful widgets maintain state that can change over time. Use `setState()` to update the UI when state changes.

```dart
import 'package:flutter/material.dart';

class CounterApp extends StatefulWidget {
  const CounterApp({super.key});

  @override
  State<CounterApp> createState() => _CounterAppState();
}

class _CounterAppState extends State<CounterApp> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++; // Modify state inside setState()
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Counter App'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        child: const Icon(Icons.add),
      ),
    );
  }
}

void main() {
  runApp(const MaterialApp(home: CounterApp()));
}
```

**Key Points:**
- Stateful widgets have two classes: `CounterApp` (widget) and `_CounterAppState` (state)
- State variables are declared in the state class (`_counter`)
- `setState()` triggers a rebuild of the widget with updated state
- Never modify state without calling `setState()`

### Form Input Example

```dart
class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  String _email = '';
  String _password = '';

  void _submit() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      print('Email: $_email, Password: $_password');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'Email'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  return null;
                },
                onSaved: (value) => _email = value!,
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Password'),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.length < 6) {
                    return 'Password must be at least 6 characters';
                  }
                  return null;
                },
                onSaved: (value) => _password = value!,
              ),
              const SizedBox(height: 24.0),
              ElevatedButton(
                onPressed: _submit,
                child: const Text('Login'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
```

---

## Navigation Between Screens

Flutter uses the `Navigator` class to manage a stack of routes (screens).

### Basic Navigation

```dart
// First Screen
class FirstScreen extends StatelessWidget {
  const FirstScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('First Screen')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Navigate to second screen
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const SecondScreen()),
            );
          },
          child: const Text('Go to Second Screen'),
        ),
      ),
    );
  }
}

// Second Screen
class SecondScreen extends StatelessWidget {
  const SecondScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Second Screen')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Go back to first screen
            Navigator.pop(context);
          },
          child: const Text('Go Back'),
        ),
      ),
    );
  }
}
```

**Navigation Methods:**
- `Navigator.push()`: Navigate to a new screen
- `Navigator.pop()`: Return to the previous screen
- `MaterialPageRoute`: Defines the transition animation

### Passing Data Between Screens

```dart
// Passing data TO a screen
class FirstScreen extends StatelessWidget {
  const FirstScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('First Screen')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const SecondScreen(message: 'Hello from First Screen!'),
              ),
            );
          },
          child: const Text('Send Data'),
        ),
      ),
    );
  }
}

// Receiving data IN a screen
class SecondScreen extends StatelessWidget {
  final String message;

  const SecondScreen({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Second Screen')),
      body: Center(
        child: Text(message),
      ),
    );
  }
}
```

### Returning Data from a Screen

```dart
// Screen that returns data
class SelectionScreen extends StatelessWidget {
  const SelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Select an Option')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context, 'Option A');
              },
              child: const Text('Option A'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context, 'Option B');
              },
              child: const Text('Option B'),
            ),
          ],
        ),
      ),
    );
  }
}

// Screen that receives returned data
class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  String _selectedOption = 'None';

  Future<void> _navigateAndGetResult() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const SelectionScreen()),
    );

    if (result != null) {
      setState(() {
        _selectedOption = result;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Main Screen')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Selected: $_selectedOption'),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _navigateAndGetResult,
              child: const Text('Select Option'),
            ),
          ],
        ),
      ),
    );
  }
}
```

### Named Routes (Alternative Approach)

For larger apps, you can define named routes:

```dart
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => const FirstScreen(),
        '/second': (context) => const SecondScreen(),
        '/third': (context) => const ThirdScreen(),
      },
    );
  }
}

// Navigate using named routes
Navigator.pushNamed(context, '/second');
```

---

## Running and Debugging

### Running Your App

```bash
# Run on connected device or emulator
flutter run

# Run in release mode (optimized)
flutter run --release

# Run on specific device
flutter devices  # List available devices
flutter run -d <device-id>
```

### Hot Reload and Hot Restart

- **Hot Reload (r):** Injects updated code without losing app state
- **Hot Restart (R):** Restarts the app and loses state
- Press `r` or `R` in the terminal while the app is running

### Debugging in VS Code

1. Set breakpoints by clicking in the gutter next to line numbers
2. Press `F5` to start debugging
3. Use the debug toolbar to step through code
4. Inspect variables in the Debug sidebar

### Common Debug Tools

```dart
// Print to console
print('Debug message: $_counter');

// Debug print (won't be stripped in release mode)
debugPrint('Important debug info');

// Assert (only runs in debug mode)
assert(_counter >= 0, 'Counter should not be negative');
```

### Flutter DevTools

Flutter DevTools is a suite of performance and debugging tools:

```bash
# Run your app in debug mode
flutter run

# Open DevTools in browser
# (URL will be shown in terminal)
```

**DevTools Features:**
- Widget Inspector: Visualize widget tree
- Performance View: Analyze frame rendering
- Memory View: Detect memory leaks
- Network View: Monitor network requests

---

## Next Steps

### Learn More About Flutter

- **Official Documentation:** [flutter.dev/docs](https://flutter.dev/docs)
- **Widget Catalog:** [flutter.dev/widgets](https://flutter.dev/widgets)
- **Cookbook:** [flutter.dev/cookbook](https://flutter.dev/cookbook)
- **Dart Language Tour:** [dart.dev/guides/language/language-tour](https://dart.dev/guides/language/language-tour)

### Explore Advanced Topics

1. **State Management:** Provider, Riverpod, Bloc, GetX
2. **Networking:** HTTP requests, REST APIs, JSON parsing
3. **Local Storage:** SharedPreferences, SQLite, Hive
4. **Animations:** Implicit and explicit animations
5. **Custom Widgets:** Building reusable components
6. **Platform Integration:** Native code, plugins, platform channels

### Build Projects

The best way to learn is by building! Try these project ideas:

- **Todo List App:** CRUD operations, local storage
- **Weather App:** API integration, JSON parsing
- **Calculator:** UI design, state management
- **Chat App:** Real-time communication, Firebase
- **E-commerce App:** Complex navigation, state management

### Join the Community

- **Flutter Discord:** Active community for questions
- **Stack Overflow:** Tag questions with `flutter`
- **Reddit:** r/FlutterDev
- **GitHub:** Explore open-source Flutter projects

---

## Summary

You've learned the fundamentals of Flutter development:

1. ✅ Setting up Flutter development environment
2. ✅ Creating and running Flutter apps
3. ✅ Building layouts with Container, Column, Row, Stack
4. ✅ Handling events and managing state with setState()
5. ✅ Navigating between screens with Navigator
6. ✅ Debugging and using development tools

Flutter's declarative approach makes it easy to build beautiful, fast UIs. With hot reload, rich widgets, and a single codebase for multiple platforms, you're well-equipped to start building Flutter applications.

**Happy coding! 🚀**
