# Primitive UI - Grade 5 Project

A Flutter GUI library built entirely from scratch using only primitive components: `CustomPaint`, `Canvas`, `GestureDetector`, and custom render objects.

**Project Goal:** Demonstrate deep understanding of Flutter's rendering engine by building a complete UI library without relying on high-level widgets.

**Live Demo:** [https://tddc73.vercel.app/examples](https://tddc73.vercel.app/examples)

**Full Documentation:** [https://tddc73.vercel.app](https://tddc73.vercel.app)

---

## Project Structure

This project consists of two main components:

```
project/
├── primitive_ui/      # Flutter package (the library)
│   ├── lib/           # Library source code
│   │   ├── src/
│   │   │   ├── components/  # 9 custom components
│   │   │   └── types/       # Type definitions
│   │   └── primitive_ui.dart
│   ├── test/          # Comprehensive widget tests
│   └── README.md      # Detailed API documentation
│
└── primitive_demo/    # Demo application
    ├── lib/
    │   └── main.dart  # Interactive examples
    └── README.md      # Demo guide
```

---

## Quick Start

### 1. Run the Demo Application

```bash
cd primitive_demo
flutter pub get
flutter run
```

The demo app showcases all 9 components with interactive examples.

### 2. Use the Library in Your Project

Add to your `pubspec.yaml`:

```yaml
dependencies:
  primitive_ui:
    path: ../primitive_ui
```

Then import and use:

```dart
import 'package:primitive_ui/primitive_ui.dart';

// Example: Create a card
PrimitiveCard(
  elevation: 4.0,
  borderRadius: 12.0,
  child: VStack(
    spacing: 16.0,
    children: [
      Text('Hello from Primitive UI'),
      PrimitiveButton(
        onPressed: () => print('Tapped!'),
        child: Text('Tap Me'),
      ),
    ],
  ),
)
```

---

## Components Overview

### 6 UI Components

| Component | Description | Key Features |
|-----------|-------------|--------------|
| **PrimitiveCard** | Container with shadow & rounded corners | Elevation, implicit animations, custom padding |
| **PrimitiveButton** | Customizable button | 6 variants (primary, secondary, destructive, outline, ghost, link), 4 sizes |
| **PrimitiveToggleSwitch** | Animated on/off switch | Smooth 200ms animations, custom colors |
| **PrimitiveSlider** | Range value selector | Implicit animations, drag support |
| **PrimitiveInput** | Text input field | 3 variants (outline, filled, flushed), leading/trailing icons |
| **PrimitiveCircularProgress** | Loading indicator | Continuous rotation animation |

### 3 Layout Components

| Component | Description | SwiftUI Equivalent |
|-----------|-------------|-------------------|
| **VStack** | Vertical stack layout | `VStack` |
| **HStack** | Horizontal stack layout | `HStack` |
| **ZStack** | Layered stack (z-ordering) | `ZStack` |

All layout components support spacing, alignment, and flexible children.

---

## Key Achievement

**Zero dependencies on high-level widgets.** Every component is built using only:

- `CustomPaint` & `Canvas` - Direct pixel manipulation
- `GestureDetector` - Raw touch input
- Custom `RenderBox` - Manual layout calculations
- `AnimationController` - Smooth transitions
- **NOT USED**: `Column`, `Row`, `Stack`, `Card`, `Button`, `Switch`, etc.

This demonstrates a deep understanding of:
- Flutter's rendering pipeline
- Layout constraint system
- Custom painting operations
- Gesture handling
- Animation integration

---

## Features

- **Custom Rendering**: Every pixel drawn with `Canvas` API
- **Manual Layout**: Custom `RenderBox` implementations for precise control
- **Smooth Animations**: Implicit and explicit animations throughout
- **Accessible**: WAI-ARIA compliant with semantic labels
- **Well Tested**: Comprehensive widget test coverage
- **Fully Documented**: API docs + interactive examples + online guide
- **Live Demo**: Deployed web version with DartPad integration

---

## Documentation

### For Users

- **[primitive_ui/README.md](primitive_ui/README.md)** - Complete API reference with examples
- **[Online Docs](https://tddc73.vercel.app)** - Interactive documentation site
- **[Live Examples](https://tddc73.vercel.app/examples)** - Try components in browser

### For Developers

- **[primitive_demo/README.md](primitive_demo/README.md)** - Demo app guide
- **[Architecture Docs](https://tddc73.vercel.app/architecture)** - Design decisions explained
- **Source Code**: `primitive_ui/lib/src/components/` - Extensively commented

---

## Testing

Run the comprehensive test suite:

```bash
cd primitive_ui
flutter test
```

Tests cover:
- Widget rendering
- Layout calculations
- Gesture interactions
- Animation behaviors
- Edge cases

---

## Development

### Building the Library

```bash
cd primitive_ui
flutter pub get
flutter analyze
flutter test
```

### Running the Demo

```bash
cd primitive_demo
flutter pub get
flutter run -d chrome  # Web
flutter run -d macos   # Desktop
```

### Deploying Documentation

The documentation site is deployed to Vercel:

```bash
cd ../docs-site
npm install
npm run build
```

---

## Educational Value

This project serves as a comprehensive educational resource demonstrating:

1. **Rendering Fundamentals**
   - How Flutter draws UI on screen
   - Canvas API operations
   - Shadow and shape rendering

2. **Layout System**
   - Constraint propagation
   - Parent-child size negotiation
   - Intrinsic sizing

3. **Interaction Handling**
   - Touch event processing
   - Gesture recognition
   - State management patterns

4. **Animation Integration**
   - Implicit vs explicit animations
   - Tween interpolation
   - Performance optimization

5. **Component Architecture**
   - Composition patterns
   - API design principles
   - Documentation practices

---

## Tech Stack

- **Language:** Dart 3.0+
- **Framework:** Flutter 3.0+
- **Testing:** flutter_test
- **Documentation:** Markdown + Nextra
- **Deployment:** Vercel (docs) + GitHub Pages (demo)

---

## Course Context

**Course:** TDDC73 - Interaction Programming  
**Institution:** Linköping University  
**Year:** 2025  
**Grade Target:** 5 (highest)

**Project Requirements Met:**
- Custom GUI library from primitives
- Multiple interacting components
- Comprehensive documentation
- Working demo application
- Unit/widget tests
- Live deployment

---

## License

MIT License - Created for educational purposes at Linköping University.

---

## Quick Navigation

| Resource | Link |
|----------|------|
| **Library API** | [primitive_ui/README.md](primitive_ui/README.md) |
| **Demo Guide** | [primitive_demo/README.md](primitive_demo/README.md) |
| **Online Docs** | [tddc73.vercel.app](https://tddc73.vercel.app) |
| **Live Demo** | [tddc73.vercel.app/examples](https://tddc73.vercel.app/examples) |
| **Source Code** | [primitive_ui/lib/src/](primitive_ui/lib/src/) |
| **Tests** | [primitive_ui/test/](primitive_ui/test/) |

---

**Last Updated:** December 18, 2025
