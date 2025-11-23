# Primitive UI

A Flutter GUI library built from scratch using only primitive components: `CustomPaint`, `Canvas`, and `GestureDetector`.

## Overview

Primitive UI is a custom Flutter library that demonstrates how UI components work "under the hood" by implementing them using only the most basic building blocks available in Flutter. This project was created as part of the TDDC73 Interaction Programming course.

## Design Philosophy

Instead of using high-level widgets like `Button`, `Card`, `Column`, or `Row`, this library builds everything from scratch using:

- **CustomPaint & Canvas** - For all visual rendering
- **GestureDetector** - For touch input handling  
- **CustomMultiChildLayout** - For layout calculation

## Components

### UI Components

#### CustomCard
A container with shadow, rounded corners, and padding - all rendered using Canvas.

```dart
CustomCard(
  color: Colors.white,
  borderRadius: 12.0,
  elevation: 4.0,
  padding: EdgeInsets.all(16.0),
  child: Text('Hello World'),
)
```

#### CustomToggleSwitch
An animated toggle switch with smooth transitions.

```dart
CustomToggleSwitch(
  value: isOn,
  onChanged: (bool newValue) {
    setState(() => isOn = newValue);
  },
  activeColor: Colors.blue,
  inactiveColor: Colors.grey,
)
```

### Layout Components

#### VStack
Arranges children vertically with configurable spacing and alignment.

```dart
VStack(
  spacing: 16.0,
  alignment: VStackAlignment.start,
  children: [
    Text('Item 1'),
    Text('Item 2'),
    Text('Item 3'),
  ],
)
```

#### ZStack
Layers children on top of each other (z-ordering).

```dart
ZStack(
  alignment: Alignment.center,
  children: [
    Container(width: 200, height: 200, color: Colors.blue),
    Container(width: 100, height: 100, color: Colors.red),
  ],
)
```

## Installation

Add this to your `pubspec.yaml`:

```yaml
dependencies:
  primitive_ui:
    path: ../primitive_ui
```

Then run:
```bash
flutter pub get
```

## Usage

Import the package:
```dart
import 'package:primitive_ui/primitive_ui.dart';
```

See the `primitive_demo` app for complete examples.

## Design Decisions

### Why CustomPaint?
CustomPaint gives us direct access to the Canvas, allowing us to control every pixel drawn on screen. This is essential for understanding how rendering actually works.

### Why GestureDetector?
GestureDetector is the lowest-level touch input handler in Flutter. Higher-level widgets like InkWell build on top of it.

### Why CustomMultiChildLayout?
This forces us to manually calculate sizes and positions of children, demonstrating the layout calculation process that Flutter normally handles automatically.

### Animation Approach
While AnimationController is a higher-level API, implementing animation timing from scratch would be impractical. The focus is on rendering and layout, not animation timing algorithms.

## Technical Constraints

**Allowed Primitives:**
- CustomPaint, Canvas, CustomPainter
- GestureDetector
- CustomMultiChildLayout, CustomSingleChildLayout
- TextPainter, TextSpan
- AnimationController (for smooth UX)

**Forbidden Components:**
- Any Material/Cupertino widgets
- Layout widgets (Column, Row, Stack, etc.)
- Container, Padding, SizedBox
- Pre-built interactive widgets

## Testing

Widget tests are included for the CustomToggleSwitch component. Run tests with:

```bash
flutter test
```

## License

MIT License - Created for educational purposes.

## Author

Created as part of TDDC73 Interaction Programming course at Linköping University.
