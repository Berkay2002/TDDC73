# Primitive UI Demo

A comprehensive demonstration app showcasing all components from the **Primitive UI** library.

## Overview

This demo application showcases a custom Flutter GUI library built entirely from scratch using only primitive components: `CustomPaint`, `Canvas`, `GestureDetector`, and custom render objects.

**Purpose:** Demonstrate all 4 components from Primitive UI in practical, interactive examples.

**Educational Value:** Shows how primitive-based components can be combined to create functional, beautiful UIs.

---

## What This Demo Includes

The demo is organized into **6 major sections**, each highlighting different aspects of the Primitive UI library:

### 1. Header Section
- Dark mode toggle using `CustomToggleSwitch`
- Demonstrates card background color changes
- Shows state propagation across the entire app

### 2. CustomCard Variations
**Demonstrates:**
- Different elevation levels (2.0, 4.0, 8.0)
- Various border radius values (8.0, 16.0, 24.0)
- Custom background colors
- Nested content with `VStack`

**What to notice:**
- How shadows change with elevation
- Smooth corner radius transitions
- Visual depth created by Canvas rendering

### 3. CustomToggleSwitch Examples
**Demonstrates:**
- Multiple independent toggle switches
- Different color schemes
- Interactive show/hide functionality
- State management with callbacks

**What to notice:**
- Smooth 200ms animation
- Color interpolation during transition
- Responsive tap interaction
- State synchronization

### 4. VStack Layout Examples
**Demonstrates:**
- All 4 alignment modes:
  - `VStackAlignment.start` - Left-aligned
  - `VStackAlignment.center` - Centered
  - `VStackAlignment.end` - Right-aligned
  - `VStackAlignment.stretch` - Full-width
- Custom spacing between children
- Different content types in vertical layouts

**What to notice:**
- How alignment affects child positioning
- Spacing uniformity between all children
- Layout constraint propagation

### 5. ZStack Layout Examples
**Demonstrates:**
- Simple layering (colored containers)
- Practical badge example (notification counter)
- Z-ordering (paint order)
- Different alignment options

**What to notice:**
- How children stack from bottom to top
- Alignment-based positioning
- Overlapping visual effects

### 6. Combined Components Section
**Demonstrates:**
- Real-world settings panel
- All components working together:
  - `CustomCard` for container
  - `VStack` for vertical layout
  - `CustomToggleSwitch` for controls
  - `ZStack` for badge overlay
- Practical UI patterns

**What to notice:**
- Composition of primitive components
- Clean, organized layout
- Professional appearance despite primitive implementation

---

## Running the Demo

### Prerequisites

- Flutter SDK installed and configured
- `primitive_ui` package available at `../primitive_ui`
- Device/emulator or web browser for testing

### Steps

1. **Navigate to the demo directory:**
   ```bash
   cd primitive_demo
   ```

2. **Get dependencies:**
   ```bash
   flutter pub get
   ```

3. **Run the app:**
   ```bash
   # Run on connected device
   flutter run

   # Run on specific device
   flutter devices  # List available devices
   flutter run -d <device-id>

   # Run on Chrome (web)
   flutter run -d chrome

   # Run on Windows
   flutter run -d windows
   ```

### Expected Output

The app should launch with a scrollable interface showing all component examples. The dark mode toggle at the top controls the overall theme.

---

## Project Structure

```
primitive_demo/
├── lib/
│   └── main.dart           # Main demo app (568 lines)
├── pubspec.yaml             # Dependencies (includes primitive_ui)
├── README.md                # This file
└── analysis_options.yaml   # Linter configuration
```

### Code Organization (main.dart)

```dart
// Main application setup
void main() => runApp(const PrimitiveUIDemo());

class PrimitiveUIDemo extends StatelessWidget { ... }

// Demo screen with all examples
class DemoScreen extends StatefulWidget { ... }

class _DemoScreenState extends State<DemoScreen> {
  // State management
  bool _darkMode = false;
  bool _toggle1 = true;
  bool _toggle2 = false;
  // ... more state variables

  @override
  Widget build(BuildContext context) {
    // Responsive UI using VStack and CustomCard
    // 6 major sections demonstrating all components
  }
}
```

---

## Interactive Features

### Try These Interactions

1. **Toggle Dark Mode** (Header)
   - Tap the toggle switch at the top
   - Watch all cards change color
   - Notice the smooth state propagation

2. **Play with Toggles** (CustomToggleSwitch section)
   - Toggle all 4 switches
   - Notice the smooth animations
   - See the "Show/Hide Demo" functionality

3. **Scroll Through Examples**
   - Scroll to see all sections
   - Compare different card elevations
   - Observe VStack alignment variations

4. **Inspect Visual Details**
   - Look at shadow depths on cards
   - Notice rounded corner variations
   - See the badge overlay in ZStack section

---

## Component Examples Included

### CustomCard Examples

```dart
// Low elevation card
CustomCard(
  elevation: 2.0,
  borderRadius: 8.0,
  color: cardColor,
  child: Text('Elevation: 2.0'),
)

// High elevation card
CustomCard(
  elevation: 8.0,
  borderRadius: 24.0,
  color: cardColor,
  child: Text('Elevation: 8.0'),
)
```

### CustomToggleSwitch Examples

```dart
// Standard toggle
CustomToggleSwitch(
  value: _toggle1,
  onChanged: (value) => setState(() => _toggle1 = value),
)

// Custom colored toggle
CustomToggleSwitch(
  value: _darkMode,
  onChanged: (value) => setState(() => _darkMode = value),
  activeColor: Colors.blue,
  inactiveColor: Colors.grey[300]!,
)
```

### VStack Examples

```dart
// Left-aligned with spacing
VStack(
  spacing: 8.0,
  alignment: VStackAlignment.start,
  children: [
    Text('Left aligned'),
    Text('With spacing'),
  ],
)

// Centered layout
VStack(
  spacing: 12.0,
  alignment: VStackAlignment.center,
  children: [...],
)
```

### ZStack Examples

```dart
// Simple layering
ZStack(
  alignment: Alignment.center,
  children: [
    Container(width: 100, height: 100, color: Colors.blue),
    Container(width: 60, height: 60, color: Colors.red),
  ],
)

// Badge overlay
ZStack(
  alignment: Alignment.topRight,
  children: [
    Text('Messages'),
    // Badge circle with notification count
    Container(...),
  ],
)
```

---

## Comparison with Standard Flutter

This demo intentionally uses:
- ✅ Standard Material app wrapper (allowed for demo)
- ✅ Standard `Scaffold`, `AppBar` (allowed for demo)
- ✅ Standard `SingleChildScrollView` (allowed for demo)
- ✅ `Row` for horizontal layouts (allowed for demo)

**But for the library components themselves:**
- ❌ NO `Column` (we use `VStack`)
- ❌ NO `Stack` (we use `ZStack`)
- ❌ NO `Card` widget (we use `CustomCard`)
- ❌ NO `Switch` widget (we use `CustomToggleSwitch`)

This shows how primitive components can replace standard widgets while maintaining functionality and aesthetics.

---

## Customization Ideas

Try modifying the demo to:

1. **Add more color schemes**
   - Change `activeColor` and `inactiveColor` on toggles
   - Modify card colors based on state

2. **Experiment with spacing**
   - Change `VStack` spacing values
   - Add more children to see layout behavior

3. **Create new combinations**
   - Nest `VStack` inside `CustomCard`
   - Layer multiple badges with `ZStack`
   - Build a settings panel with toggles and cards

4. **Test edge cases**
   - Add many children to `VStack`
   - Stack many layers in `ZStack`
   - Use extreme elevation values

---

## Learning Objectives

By exploring this demo, you'll understand:

1. **Component Composition**
   - How primitive components combine to create complex UIs
   - The relationship between layout and UI components

2. **State Management**
   - How callbacks propagate state changes
   - Using `setState()` to trigger rebuilds

3. **Visual Design**
   - How elevation creates visual hierarchy
   - The impact of spacing on layout clarity
   - Color's role in theme consistency

4. **Primitive Implementation**
   - That complex UIs can be built from simple primitives
   - How CustomPaint, Canvas, and GestureDetector enable custom components
   - The value of manual layout control

---

## Troubleshooting

### "Package primitive_ui not found"

**Solution:** Ensure the path dependency is correct in `pubspec.yaml`:
```yaml
dependencies:
  primitive_ui:
    path: ../primitive_ui  # Check this path is correct
```

Then run: `flutter pub get`

### "Hot reload not working"

**Solution:** Try hot restart instead:
- Press `R` in the terminal (full restart)
- Or use `flutter run` again

### "UI looks different on different platforms"

This is normal! Flutter renders consistently, but system fonts and default colors may vary. The primitive components will look the same across platforms.

---

## Next Steps

After exploring the demo:

1. **Read the API Documentation**
   - See [Primitive UI README](../primitive_ui/README.md) for detailed API docs
   - Understand each component's parameters and behavior

2. **Study the Implementation**
   - Examine source code in `primitive_ui/lib/src/components/`
   - Understand how CustomPaint and Canvas work
   - See how custom RenderBox handles layout

3. **Build Your Own UI**
   - Use Primitive UI components in your own project
   - Combine components in new ways
   - Create real-world UIs with primitive-based components

4. **Learn Flutter Rendering**
   - Read the [Getting Started Guide](../GETTING_STARTED_FLUTTER.md)
   - Explore Flutter's rendering pipeline
   - Understand the widget-element-render tree

---

## Learn More

- **Primitive UI API Docs:** [../primitive_ui/README.md](../primitive_ui/README.md)
- **Flutter Getting Started:** [../GETTING_STARTED_FLUTTER.md](../GETTING_STARTED_FLUTTER.md)
- **Flutter Documentation:** https://flutter.dev/docs
- **Source Code:** `lib/main.dart` (extensively commented)

---

## Credits

**Project:** Primitive UI Library and Demo  
**Course:** TDDC73 - Interaction Programming  
**Institution:** Linköping University  
**Year:** 2025  
**Purpose:** Grade 5 project demonstrating custom GUI library from primitives
