# TDDC73 - Interaction Programming

This repository contains all coursework for **TDDC73 Interaction Programming** at Linköping University.

---

## Repository Structure

### 📱 Lab 1: Multi-Framework UI Comparison

**Location:** `lab_1/`

Implementing the same UI across multiple mobile frameworks to compare development approaches.

**Frameworks:**
- Flutter (`lab_1/flutter/`)
- Kotlin Compose (`lab_1/kotlin_compose/`)
- Kotlin XML (`lab_1/kotlin_xml/`)
- React Native (`lab_1/react_native/`)

**Documentation:** [lab_1/lab_1.md](lab_1/lab_1.md)

---

### 💳 Lab 2: Credit Card Form with Validation

**Location:** `lab_2/`

Interactive credit card form with real-time validation and visual feedback.

**Implementations:**
- Flutter app (`lab_2/lab2_flutter/`)
- Web version (`lab_2/executable-version/`)

**Features:**
- Real-time input validation
- Card type detection
- Visual feedback
- Dynamic card preview

**Documentation:** [lab_2/lab_2.md](lab_2/lab_2.md)

---

### 🌟 Lab 3: GitHub Trending App

**Location:** `lab_3/`

Application displaying trending GitHub repositories with filtering and search capabilities.

**Implementation:**
- Flutter app (`lab_3/lab3_flutter/`)

**Features:**
- GitHub API integration
- Repository listing
- Search and filtering
- Material Design UI

**Documentation:** [lab_3/lab_3.md](lab_3/lab_3.md)

---

### 🎨 Project: Primitive UI Library (Grade 5)

**Location:** `project/`

A custom Flutter GUI library built entirely from scratch using only primitive components.

**Project Structure:**
```
project/
├── primitive_ui/              # Flutter package (the library)
│   ├── lib/
│   │   ├── primitive_ui.dart
│   │   └── src/components/
│   │       ├── primitive_card.dart
│   │       ├── primitive_toggle_switch.dart
│   │       ├── v_stack.dart
│   │       └── z_stack.dart
│   └── test/                  # Widget tests
├── primitive_demo/            # Demo application
│   └── lib/main.dart
├── GETTING_STARTED_FLUTTER.md # Flutter tutorial for beginners
└── IMPLEMENTATION_PLAN.md     # Detailed project plan
```

**Components Implemented:**

1. **PrimitiveCard** - Container with shadow, rounded corners, padding
2. **PrimitiveToggleSwitch** - Animated on/off switch
3. **VStack** - Vertical stack layout
4. **ZStack** - Layered stack layout (z-ordering)

**Key Achievement:** All components built using ONLY:
- `CustomPaint` and `Canvas` for rendering
- `GestureDetector` for input
- Custom `RenderBox` for layout
- NO high-level widgets (Column, Row, Stack, Card, etc.)

**Quick Start:**
```bash
# Run the demo app
cd project/primitive_demo
flutter pub get
flutter run
```

**Documentation:**
- **API Documentation:** [project/primitive_ui/README.md](project/primitive_ui/README.md)
- **Demo Guide:** [project/primitive_demo/README.md](project/primitive_demo/README.md)
- **Flutter Tutorial:** [project/GETTING_STARTED_FLUTTER.md](project/GETTING_STARTED_FLUTTER.md)
- **Implementation Plan:** [project/IMPLEMENTATION_PLAN.md](project/IMPLEMENTATION_PLAN.md)

**Requirements:** [grade-5.md](grade-5.md)

---

## Course Information

**Course Code:** TDDC73  
**Course Name:** Interaction Programming  
**Institution:** Linköping University  
**Year:** 2025

### Course Objectives

- Understanding multi-platform UI development
- Learning different framework paradigms
- Mastering state management and event handling
- Building custom UI components
- API integration and data handling
- UI/UX design principles

---

## Technologies Used

### Frameworks
- **Flutter** (Dart) - Cross-platform UI toolkit
- **Kotlin Compose** - Modern Android UI
- **React Native** (TypeScript) - JavaScript-based cross-platform
- **Web Technologies** (HTML/CSS/JavaScript)

### Languages
- Dart
- Kotlin
- TypeScript/JavaScript
- HTML/CSS

### Tools
- Visual Studio Code
- Android Studio
- Flutter DevTools
- Git

---

## Project Highlights

### Lab 1: Framework Comparison
- Implemented identical UI in 4 different frameworks
- Compared declarative vs imperative approaches
- Evaluated development experience and tooling

### Lab 2: Form Validation
- Real-time input validation
- Complex state management
- Visual feedback and user experience
- Cross-platform implementation

### Lab 3: API Integration
- RESTful API consumption
- Asynchronous programming
- Data modeling and parsing
- List rendering and filtering

### Project: Primitive UI
- **Deep dive into rendering fundamentals**
- Custom paint and canvas operations
- Manual layout calculation
- Gesture handling from primitives
- Comprehensive testing and documentation

---

## Running the Projects

### Flutter Projects

```bash
# Navigate to any Flutter project
cd lab_1/flutter
# or
cd lab_2/lab2_flutter
# or
cd lab_3/lab3_flutter
# or
cd project/primitive_demo

# Get dependencies
flutter pub get

# Run on connected device
flutter run

# Run tests (where applicable)
flutter test
```

### Web Projects

```bash
# Lab 2 web version
cd lab_2/executable-version
# Open html.html in a web browser
```

### Kotlin Projects

```bash
# Kotlin Compose or XML
cd lab_1/kotlin_compose  # or kotlin_xml

# Build and run with Gradle
./gradlew build
./gradlew run
```

---

## Documentation Files

- **grade-5.md** - Grade 5 project requirements
- **project.md** - Alternative project specifications
- **ui-test.md** - UI testing guidelines
- **comment_instructions.md** - Code commenting guidelines

---

## Repository Statistics

- **Labs:** 3
- **Project:** 1 (Grade 5)
- **Flutter Projects:** 5
- **Total Components Created:** 15+
- **Lines of Code:** ~5000+
- **Test Coverage:** Widget tests for all major components

---

## Key Learnings

### Multi-Framework Development
- Each framework has unique strengths and trade-offs
- Declarative UI (Flutter, Compose) vs Imperative UI (XML)
- Hot reload significantly improves development speed
- Type safety (TypeScript, Dart) prevents runtime errors

### State Management
- Local state with setState() for simple cases
- Lifting state up for shared state
- Callback patterns for child-to-parent communication
- Reactive programming principles

### Custom Component Development
- Understanding rendering pipelines
- Manual layout calculations
- Custom paint operations
- Performance optimization techniques

### Testing and Quality
- Widget testing for UI verification
- Test-driven development practices
- Automated testing importance
- Code documentation standards

---

## Academic Integrity

All code in this repository is original work created for the TDDC73 course. External resources and references are properly cited in individual project documentation.

---

## Contact

**Institution:** Linköping University  
**Course:** TDDC73 - Interaction Programming  
**Year:** 2025

---

## License

All projects in this repository are created for educational purposes as part of TDDC73 coursework.

---

## Quick Navigation

| Lab/Project | Description | Location | Documentation |
|-------------|-------------|----------|---------------|
| **Lab 1** | Multi-framework UI | `lab_1/` | [lab_1.md](lab_1/lab_1.md) |
| **Lab 2** | Credit card form | `lab_2/` | [lab_2.md](lab_2/lab_2.md) |
| **Lab 3** | GitHub trending | `lab_3/` | [lab_3.md](lab_3/lab_3.md) |
| **Project** | Primitive UI library | `project/` | [README](project/primitive_ui/README.md) |

---

**Last Updated:** November 23, 2025
