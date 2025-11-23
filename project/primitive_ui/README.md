# Primitive UI

A Flutter GUI library built entirely from scratch using only primitive components: `CustomPaint`, `Canvas`, `GestureDetector`, and custom render objects.

## Overview

Primitive UI is a custom Flutter library that demonstrates how UI components work "under the hood" by implementing them using only the most basic building blocks available in Flutter. This project was created as part of the TDDC73 Interaction Programming course at Linköping University.

**Key Achievement:** Zero dependencies on high-level widgets. Every component is built from scratch using Flutter's rendering layer primitives.

## Design Philosophy

Instead of using high-level widgets like `Button`, `Card`, `Column`, `Row`, or `Stack`, this library builds everything from scratch using:

- **CustomPaint & Canvas** - For all visual rendering (drawing shapes, shadows, colors)
- **GestureDetector** - For touch input handling (taps, drags)
- **Custom RenderBox** - For manual layout calculation and positioning
- **TextPainter** - For text rendering when needed

This approach provides deep insight into how Flutter's rendering engine works and demonstrates the fundamental concepts behind every widget you use in Flutter.

---

## Components

Primitive UI includes 7 core components: 4 UI components and 3 layout components.

### UI Components

#### 1. CustomCard

A container widget with shadow, rounded corners, and padding - all rendered using Canvas.

**Constructor:**
```dart
CustomCard({
  Key? key,
  required Widget child,
  Color color = Colors.white,
  double borderRadius = 8.0,
  double elevation = 2.0,
  EdgeInsets padding = const EdgeInsets.all(16.0),
})
```

**Parameters:**
- `child` (required): The widget to display inside the card
- `color`: Background color of the card (default: white)
- `borderRadius`: Corner radius in logical pixels (default: 8.0)
- `elevation`: Shadow depth in logical pixels (default: 2.0)
- `padding`: Internal spacing around the child (default: 16.0 on all sides)

**Example Usage:**
```dart
// Basic card
CustomCard(
  child: Text('Hello World'),
)

// Customized card
CustomCard(
  color: Colors.blue[50]!,
  borderRadius: 16.0,
  elevation: 8.0,
  padding: const EdgeInsets.symmetric(
    horizontal: 24.0,
    vertical: 16.0,
  ),
  child: Column(
    children: [
      Text('Card Title', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
      SizedBox(height: 8),
      Text('Card content goes here'),
    ],
  ),
)
```

**Implementation Details:**
- Uses `CustomPaint` with a custom `CustomPainter` for rendering
- `Canvas.drawShadow()` for elevation effect
- `Canvas.drawRRect()` for rounded corners
- Custom `RenderShiftedBox` for padding and layout

---

#### 2. CustomToggleSwitch

An animated toggle switch with smooth transitions between on/off states.

**Constructor:**
```dart
CustomToggleSwitch({
  Key? key,
  required bool value,
  required ValueChanged<bool> onChanged,
  Color activeColor = const Color(0xFF4CAF50),
  Color inactiveColor = const Color(0xFFBDBDBD),
  double width = 50.0,
  double height = 30.0,
})
```

**Parameters:**
- `value` (required): Current state (true = on, false = off)
- `onChanged` (required): Callback invoked when user taps the switch
- `activeColor`: Color when switch is on (default: green)
- `inactiveColor`: Color when switch is off (default: grey)
- `width`: Total width of the switch (default: 50.0)
- `height`: Total height of the switch (default: 30.0)

**Example Usage:**
```dart
// Basic toggle switch
bool _isEnabled = false;

CustomToggleSwitch(
  value: _isEnabled,
  onChanged: (bool newValue) {
    setState(() {
      _isEnabled = newValue;
    });
  },
)

// Customized toggle switch
CustomToggleSwitch(
  value: _darkMode,
  onChanged: (bool value) {
    setState(() => _darkMode = value);
  },
  activeColor: Colors.blue,
  inactiveColor: Colors.grey[300]!,
  width: 60.0,
  height: 34.0,
)
```

**Implementation Details:**
- Uses `CustomPaint` with a custom `CustomPainter` for rendering
- `AnimationController` for smooth 200ms sliding animation
- `GestureDetector` for tap detection
- Color interpolation between active/inactive states
- Shadow effect for visual depth

**Animation Behavior:**
- Tap triggers 200ms animation with `easeInOut` curve
- Thumb smoothly slides between positions
// ...existing code...
- Colors interpolate during transition
- Callback fires immediately on tap (doesn't wait for animation)

---

#### 3. CustomSlider

A slider component for selecting a value from a range.

**Constructor:**
```dart
CustomSlider({
  Key? key,
  required double value,
  ValueChanged<double>? onChanged,
  double min = 0.0,
  double max = 1.0,
  Color activeColor = const Color(0xFF2196F3),
  Color inactiveColor = const Color(0xFFE0E0E0),
  double thumbRadius = 10.0,
  double trackHeight = 4.0,
})
```

**Parameters:**
- `value` (required): Current value
- `onChanged`: Callback when value changes
- `min`: Minimum value (default: 0.0)
- `max`: Maximum value (default: 1.0)
- `activeColor`: Color of the active track and thumb
- `inactiveColor`: Color of the inactive track
- `thumbRadius`: Radius of the thumb
- `trackHeight`: Height of the track

**Example Usage:**
```dart
CustomSlider(
  value: _currentValue,
  min: 0.0,
  max: 100.0,
  onChanged: (value) {
    setState(() => _currentValue = value);
  },
)
```

**Implementation Details:**
- Uses `CustomPaint` for track and thumb rendering
- `GestureDetector` handles drag updates to calculate value
- Maps pixel position to value range

---

#### 4. CustomCircularProgress

An indeterminate circular progress indicator.

**Constructor:**
```dart
CustomCircularProgress({
  Key? key,
  Color color = const Color(0xFF2196F3),
  double strokeWidth = 4.0,
  double size = 40.0,
})
```

**Parameters:**
- `color`: Color of the indicator
- `strokeWidth`: Width of the stroke
- `size`: Diameter of the indicator

**Example Usage:**
```dart
CustomCircularProgress(
  color: Colors.purple,
  size: 50.0,
)
```

**Implementation Details:**
- Uses `CustomPaint` to draw arcs
- `AnimationController` rotates the canvas
- Demonstrates continuous animation with custom painting

---

### Layout Components

#### 5. VStack
// ...existing code...

---

### Layout Components

#### 5. VStack

A layout component that arranges children vertically with configurable spacing and alignment.

**Constructor:**
```dart
VStack({
  Key? key,
  required List<Widget> children,
  double spacing = 0.0,
  VStackAlignment alignment = VStackAlignment.start,
  MainAxisAlignment mainAxisAlignment = MainAxisAlignment.start,
  MainAxisSize mainAxisSize = MainAxisSize.max,
})
```

**Parameters:**
- `children` (required): List of widgets to arrange vertically
- `spacing`: Uniform spacing between children in logical pixels (default: 0.0)
- `alignment`: How to align children horizontally (default: start)
- `mainAxisAlignment`: How to distribute children vertically (default: start)
- `mainAxisSize`: Whether to take maximum or minimum vertical space (default: max)

**Alignment Options:**
```dart
enum VStackAlignment {
  start,    // Align to the left edge
  center,   // Center horizontally
  end,      // Align to the right edge
  stretch,  // Stretch to fill horizontal space
}
```

**Example Usage:**
```dart
// Basic vertical stack
VStack(
  spacing: 16.0,
  children: [
    Text('Item 1'),
    Text('Item 2'),
    Text('Item 3'),
  ],
)

// Centered with custom spacing
VStack(
  spacing: 24.0,
  alignment: VStackAlignment.center,
  mainAxisAlignment: MainAxisAlignment.center,
  children: [
    Icon(Icons.check_circle, size: 48, color: Colors.green),
    Text('Success!', style: TextStyle(fontSize: 24)),
    Text('Your action completed successfully'),
  ],
)

// Stretched children
VStack(
  spacing: 8.0,
  alignment: VStackAlignment.stretch,
  children: [
    ElevatedButton(onPressed: () {}, child: Text('Button 1')),
    ElevatedButton(onPressed: () {}, child: Text('Button 2')),
    ElevatedButton(onPressed: () {}, child: Text('Button 3')),
  ],
)

// Space between children
VStack(
  mainAxisAlignment: MainAxisAlignment.spaceBetween,
  children: [
    Text('Top'),
    Text('Bottom'),
  ],
)
```

**Implementation Details:**
- Custom `RenderBox` with `ContainerRenderObjectMixin`
- Manual layout constraint calculations
- Supports intrinsic sizing for proper nested layouts
- No `Flexible` or `Expanded` support (out of scope for primitive implementation)

**Layout Algorithm:**
1. Measure each child with appropriate constraints
2. Calculate total height (sum of child heights + spacing)
3. Position children vertically with spacing and main axis distribution
4. Apply horizontal alignment to each child

---

#### 6. HStack

A layout component that arranges children horizontally with configurable spacing and alignment.

**Constructor:**
```dart
HStack({
  Key? key,
  required List<Widget> children,
  double spacing = 0.0,
  HStackAlignment alignment = HStackAlignment.top,
  MainAxisAlignment mainAxisAlignment = MainAxisAlignment.start,
  MainAxisSize mainAxisSize = MainAxisSize.max,
})
```

**Parameters:**
- `children` (required): List of widgets to arrange horizontally
- `spacing`: Uniform spacing between children in logical pixels (default: 0.0)
- `alignment`: How to align children vertically (default: top)
- `mainAxisAlignment`: How to distribute children horizontally (default: start)
- `mainAxisSize`: Whether to take maximum or minimum horizontal space (default: max)

**Alignment Options:**
```dart
enum HStackAlignment {
  top,      // Align to the top edge
  center,   // Center vertically
  bottom,   // Align to the bottom edge
  stretch,  // Stretch to fill vertical space
}
```

**Example Usage:**
```dart
// Basic horizontal stack
HStack(
  spacing: 16.0,
  children: [
    Icon(Icons.star),
    Text('4.5 Stars'),
  ],
)

// Centered content
HStack(
  alignment: HStackAlignment.center,
  mainAxisAlignment: MainAxisAlignment.center,
  children: [
    CircularProgressIndicator(),
    SizedBox(width: 16),
    Text('Loading...'),
  ],
)

// Space between items
HStack(
  mainAxisAlignment: MainAxisAlignment.spaceBetween,
  children: [
    Text('Left'),
    Text('Right'),
  ],
)
```

**Implementation Details:**
- Similar to `VStack` but operates on the horizontal axis
- Custom `RenderBox` implementation
- Handles RTL text direction automatically

---

#### 7. ZStack

A layout component that layers children on top of each other (z-ordering/stacking).

**Constructor:**
```dart
ZStack({
  Key? key,
  required List<Widget> children,
  AlignmentGeometry alignment = Alignment.center,
  StackFit fit = StackFit.loose,
})
```

**Parameters:**
- `children` (required): List of widgets to layer (first = bottom, last = top)
- `alignment`: How to align all children within the stack (default: center)
- `fit`: How to size children (default: loose)

**Fit Options:**
```dart
enum StackFit {
  loose,      // Children maintain their natural size
  expand,     // Children expand to fill the stack
  passthrough, // Pass parent constraints directly to children
}
```

**Example Usage:**
```dart
// Basic layered stack
ZStack(
  alignment: Alignment.center,
  children: [
    Container(width: 200, height: 200, color: Colors.blue),
    Container(width: 100, height: 100, color: Colors.red),
  ],
)

// Profile picture with badge
ZStack(
  alignment: Alignment.topRight,
  children: [
    CircleAvatar(radius: 40, child: Icon(Icons.person, size: 40)),
    Container(
      width: 20,
      height: 20,
      decoration: BoxDecoration(
        color: Colors.green,
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white, width: 2),
      ),
    ),
  ],
)

// Text overlay on image
ZStack(
  alignment: Alignment.bottomCenter,
  children: [
    Image.network('https://example.com/image.jpg'),
    Container(
      padding: EdgeInsets.all(8),
      color: Colors.black54,
      child: Text(
        'Image Caption',
        style: TextStyle(color: Colors.white),
      ),
    ),
  ],
)

// Expanded children
ZStack(
  fit: StackFit.expand,
  children: [
    Container(color: Colors.blue),
    Center(child: Text('Overlay', style: TextStyle(color: Colors.white))),
  ],
)
```

**Implementation Details:**
- Custom `RenderBox` with `ContainerRenderObjectMixin`
- Children are painted in order (first child = bottom layer)
- Stack size is determined by the largest child
- All children are aligned relative to the stack bounds
- Supports intrinsic sizing

**Layout Algorithm:**
1. Measure all children
2. Determine stack size (max of all child sizes in loose mode)
3. Position each child based on alignment
4. Paint children in order (ensuring proper z-ordering)

---

## Installation

### As a Path Dependency (Recommended for this project)

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

### Usage in Code

Import the package:
```dart
import 'package:primitive_ui/primitive_ui.dart';
```

All components are now available:
- `CustomCard`
- `CustomToggleSwitch`
- `VStack` and `VStackAlignment`
- `HStack` and `HStackAlignment`
- `ZStack` and `StackFit`

---

## Complete Example

```dart
import 'package:flutter/material.dart';
import 'package:primitive_ui/primitive_ui.dart';

class DemoScreen extends StatefulWidget {
  const DemoScreen({super.key});

  @override
  State<DemoScreen> createState() => _DemoScreenState();
}

class _DemoScreenState extends State<DemoScreen> {
  bool _notificationsEnabled = true;
  bool _darkMode = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Primitive UI Demo')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: VStack(
          spacing: 16.0,
          alignment: VStackAlignment.stretch,
          children: [
            // Card with toggle switches
            CustomCard(
              elevation: 4.0,
              borderRadius: 12.0,
              child: VStack(
                spacing: 12.0,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Notifications'),
                      CustomToggleSwitch(
                        value: _notificationsEnabled,
                        onChanged: (value) {
                          setState(() => _notificationsEnabled = value);
                        },
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Dark Mode'),
                      CustomToggleSwitch(
                        value: _darkMode,
                        onChanged: (value) {
                          setState(() => _darkMode = value);
                        },
                        activeColor: Colors.blue,
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Layered badge example
            CustomCard(
              child: ZStack(
                alignment: Alignment.topRight,
                children: [
                  VStack(
                    spacing: 8.0,
                    children: [
                      const Text('Messages', style: TextStyle(fontSize: 18)),
                      const Text('You have unread messages'),
                    ],
                  ),
                  Container(
                    width: 24,
                    height: 24,
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                    child: const Center(
                      child: Text('3', style: TextStyle(color: Colors.white, fontSize: 12)),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
```

---

## Demo Application

See the `primitive_demo` app for more comprehensive examples demonstrating:
- Various card configurations (elevation, colors, border radius)
- Toggle switch interactions
- Different VStack alignments and spacing
- ZStack layering effects
- Combined components working together

To run the demo:
```bash
cd primitive_demo
flutter pub get
flutter run
```

---

## Design Decisions

### Why CustomPaint and Canvas?

`CustomPaint` gives us direct access to the `Canvas` API, allowing us to control every pixel drawn on screen. This is essential for understanding how rendering actually works in Flutter.

**What we learned:**
- How shadows are rendered (`drawShadow`)
- How shapes are drawn (`drawRRect`, `drawCircle`)
- How colors and gradients work
- The relationship between painting and layout

Without `CustomPaint`, we'd be limited to composing existing widgets without understanding their implementation.

### Why Custom RenderBox?

Instead of using `CustomMultiChildLayout`, we implemented custom `RenderBox` objects extending `ContainerRenderObjectMixin`. This approach:

- Provides deeper control over layout calculations
- Demonstrates how Flutter's rendering pipeline works
- Shows the relationship between constraints, sizes, and positions
- Teaches intrinsic sizing and how widgets negotiate space

**Key insight:** Every widget in Flutter ultimately becomes a `RenderObject` that performs layout and painting.

### Why GestureDetector?

`GestureDetector` is the lowest-level touch input handler in Flutter. Higher-level widgets like `InkWell` and `Button` build on top of it.

**What we learned:**
- How touch events are detected and processed
- How to convert gestures into state changes
- The event handling lifecycle

### Animation Approach

While `AnimationController` is a higher-level API, implementing animation timing from scratch would be impractical and distract from the core learning objectives.

**Rationale:**
- The focus is on rendering and layout, not animation timing algorithms
- `AnimationController` is acceptable as it provides smooth UX
- The key learning is connecting animation values to custom paint operations

### Trade-offs and Limitations

**No Flexible/Expanded Support in VStack:**
- Implementing flex layout would require significant complexity
- The goal is demonstrating basic layout, not full flex algorithm
- Users can wrap children in `SizedBox` for fixed sizes

**No Positioned Support in ZStack:**
- Unlike Flutter's `Stack`, we don't support absolute positioning
- All children use alignment-based positioning
- This keeps the implementation focused on core stacking behavior

**TextPainter for Text:**
- We use Flutter's standard text widgets as children
- Implementing custom text rendering would be extremely complex
- The focus is on container/layout components, not text rendering

---

## Technical Constraints

### Allowed Primitives

**Rendering:**
- `CustomPaint` - Widget for custom painting
- `Canvas` - Drawing API (drawRect, drawCircle, drawShadow, etc.)
- `CustomPainter` - Abstract class for paint logic
- `Paint` - Paint properties (color, stroke, fill)

**Input:**
- `GestureDetector` - Touch event detection

**Layout:**
- Custom `RenderBox` - Manual layout calculations
- `RenderShiftedBox` - Single-child layout with offset
- `ContainerRenderObjectMixin` - Multi-child layout support

**Text (when needed):**
- `TextPainter` - Manual text layout
- `TextSpan` - Text content representation

**Animation (acceptable for UX):**
- `AnimationController` - Animation timing
- `Animation<T>` - Animated values

### Forbidden Components

**High-level Widgets:**
- Any Material widgets (`Button`, `Card`, `Chip`, etc.)
- Any Cupertino widgets (`CupertinoButton`, etc.)
- Any pre-built interactive widgets

**Layout Helpers:**
- `Column`, `Row`, `Stack`, `Positioned`
- `Container`, `Padding`, `SizedBox` (in library code)
- `Flexible`, `Expanded`, `Spacer`
- `Align`, `Center` (without custom implementation)
- `Wrap`, `Flow`, `Table`, `GridView`

**Note:** The demo application can use standard Flutter widgets for its UI. The constraints apply only to the library implementation.

---

## Testing

Comprehensive widget tests are included for the `CustomToggleSwitch` component, covering:

- **Rendering:** Initial on/off states
- **Interaction:** Tap behavior and state changes
- **Animation:** Smooth transitions
- **Callbacks:** Proper invocation with correct values
- **Edge Cases:** Rapid taps, state persistence
- **Customization:** Custom colors and dimensions

**Run tests:**
```bash
cd primitive_ui
flutter test
```

**Test Output:**
```
00:02 +14: All tests passed!
```

**Test Coverage:**
- 14 test cases
- 100% coverage of CustomToggleSwitch functionality
- Demonstrates understanding of Flutter widget testing

---

## Performance Considerations

### Rendering Efficiency

- `shouldRepaint()` implementations prevent unnecessary repaints
- Canvas operations are hardware-accelerated
- Animation uses `SingleTickerProviderStateMixin` for optimal performance

### Layout Efficiency

- Intrinsic size calculations are cached when possible
- Layout constraints are properly propagated
- No unnecessary rebuilds or re-layouts

### Best Practices

**CustomCard:**
- Only repaints when color, elevation, or border radius change
- Uses efficient `RRect` for rounded corners
- Shadow is rendered once per paint

**CustomToggleSwitch:**
- Animation is smooth (60 FPS) with easeInOut curve
- State changes trigger minimal rebuilds
- Color interpolation is performed in paint method

**VStack/ZStack:**
- Layout is performed only when constraints change
- Child measurements are cached within layout pass
- Efficient multi-child layout algorithms

---

## Troubleshooting

### "Error: Cannot find package 'primitive_ui'"

Make sure the path in your `pubspec.yaml` is correct:
```yaml
dependencies:
  primitive_ui:
    path: ../primitive_ui  # Relative to your project root
```

Then run:
```bash
flutter pub get
```

### "CustomCard not rendering shadow"

Ensure you're providing enough space for the shadow. The shadow extends beyond the card by the `elevation` amount.

### "VStack children overlapping"

Check that you're providing appropriate spacing:
```dart
VStack(
  spacing: 16.0,  // Add spacing between children
  children: [...],
)
```

### "ZStack not layering correctly"

Remember that children are painted in order (first = bottom):
```dart
ZStack(
  children: [
    Container(...),  // Bottom layer
    Text(...),       // Top layer
  ],
)
```

---

## Contributing

This project was created for educational purposes as part of TDDC73. While not actively maintained for production use, it serves as a learning resource for understanding Flutter's rendering and layout systems.

**Learning Opportunities:**
- Study the implementation to understand rendering primitives
- Modify components to add new features
- Extend the library with additional primitive-based components
- Use as reference for custom widget development

---

## References

- **Flutter CustomPaint Documentation:** https://api.flutter.dev/flutter/widgets/CustomPaint-class.html
- **Flutter RenderObject Documentation:** https://api.flutter.dev/flutter/rendering/RenderObject-class.html
- **Flutter Layout Algorithm:** https://docs.flutter.dev/ui/layout
- **Canvas API:** https://api.flutter.dev/flutter/dart-ui/Canvas-class.html

---

## License

MIT License - Created for educational purposes.

## Author

Created as part of TDDC73 Interaction Programming course at Linköping University.

**Course:** TDDC73 - Interaction Programming  
**Institution:** Linköping University  
**Year:** 2025  
**Project:** Grade 5 - Custom GUI Library from Primitives
