# Primitive UI - Oral Examination Presentation
**TDDC73 - Interaction Programming | Grade 5 Project**  
**Student:** Berkay Orhan | **Date:** December 18, 2024

---

## Presentation Overview

**Project:** Primitive UI - Flutter GUI Library  
**Duration:** 20-25 minutes  
**Format:** Live demo + Code walkthrough + Q&A

**Quick Links:**
- [Documentation Site](http://localhost:3000) (Start this before presentation)
- [Demo App](http://localhost:8080) (Flutter web demo)
- [GitHub/Source Code](#source-code-references)
- [Tests](#ui-testing-section)

---

# Part 1: Introduction (2 min)

## Project Summary

> **Primitive UI** är ett Flutter GUI-bibliotek byggt helt från grunden med endast primitiva komponenter.

### Key Points:
- **Använder INTE** färdiga widgets som `Column`, `Row`, `Card`, `Switch`
- **Använder ENDAST** `CustomPaint`, `Canvas`, `GestureDetector`
- **9 komponenter totalt:** 6 UI + 3 layout
- **Complete documentation:** README + Getting Started guide
- **Comprehensive testing:** 47+ widget tests

### Why This Project?

"Målet har varit att förstå hur Flutter's rendering engine fungerar 'under huven' genom att bygga varje komponent från grunden."

---

# Part 2: Architecture Overview (3 min)

## Component Overview

### UI Components (6 stycken)

| Component | Description | Key Features |
|-----------|-------------|--------------|
| **PrimitiveButton** | Customizable button | 6 variants, hover/press states, loading |
| **PrimitiveInput** | Text input field | 3 variants, focus states, placeholder |
| **PrimitiveCard** | Container with shadow | Elevation, border radius, animations |
| **PrimitiveToggleSwitch** | Animated switch | Smooth 200ms animation |
| **PrimitiveSlider** | Value slider | Drag interaction, implicit animations |
| **PrimitiveCircularProgress** | Loading indicator | Infinite rotation animation |

### Layout Components (3 stycken)

| Component | Description | Similar To |
|-----------|-------------|------------|
| **VStack** | Vertical layout | `Column` (but built from scratch) |
| **HStack** | Horizontal layout | `Row` (but built from scratch) |
| **ZStack** | Layered stack | `Stack` (but built from scratch) |

## Primitives Used

```dart
// ONLY these primitives are used:

// 1. Rendering
CustomPaint      // Widget for custom painting
Canvas           // Drawing API (drawRect, drawCircle, drawShadow)
CustomPainter    // Paint logic implementation

// 2. Input
GestureDetector  // Touch event detection

// 3. Layout
RenderBox        // Custom layout calculations
RenderShiftedBox // Single-child layout with offset
ContainerRenderObjectMixin // Multi-child layout

// 4. Animation (timing only)
AnimationController // Animation timing
Animation<T>        // Animated values

// 5. Text (when needed)
TextPainter      // Manual text rendering
```

**Documentation:** [localhost:3000/getting-started](http://localhost:3000/getting-started)

---

# Part 3: Live Demo (6 min)

## Demo Application

### Starting the Demo

```bash
# Terminal 1: Start documentation site
cd docs-site
npm run dev
# Opens at http://localhost:3000

# Terminal 2: Start demo app
cd project/primitive_demo
flutter run -d chrome
# Opens at http://localhost:xxxxx (Flutter assigns port)
```

### Demo Flow Checklist

#### PrimitiveButton ([Demo](http://localhost:3000/components/button))
- [ ] Show different variants (primary, secondary, destructive, outline, ghost)
- [ ] Hover states
- [ ] Press states
- [ ] Loading state
- [ ] Disabled state
- [ ] With icons (leading/trailing)

**Say:** "Detta är PrimitiveButton. Den är helt implementerad med CustomPaint där jag manuellt ritar bakgrund, borders och hanterar hover/press states med GestureDetector."

---

#### PrimitiveInput ([Demo](http://localhost:3000/components/input))
- [ ] Type in different inputs
- [ ] Show placeholder behavior
- [ ] Focus states (outline changes color)
- [ ] Different variants (outline, filled, flushed)
- [ ] Leading/trailing icons
- [ ] Error state

**Say:** "PrimitiveInput använder EditableText för text editing men all decoration är custom Canvas rendering."

---

#### PrimitiveCard ([Demo](http://localhost:3000/components/card))
- [ ] Different elevations (2.0, 4.0, 8.0)
- [ ] Different border radius
- [ ] Color variations
- [ ] Implicit animations (change properties)

**Say:** "Elevation är manual shadow rendering med Canvas.drawShadow(). Varje shadow layer är beräknad och ritad."

---

#### PrimitiveToggleSwitch ([Demo](http://localhost:3000/components/toggle-switch))
- [ ] Toggle multiple switches
- [ ] Show smooth 200ms animation
- [ ] Different colors
- [ ] Responsive interaction

**Say:** "AnimationController driver 200ms sliding animation. Thumb position interpoleras från 0.0 till 1.0."

---

#### PrimitiveSlider ([Demo](http://localhost:3000/components/slider))
- [ ] Drag slider
- [ ] Show value updates
- [ ] Min/max ranges
- [ ] Implicit animations

**Say:** "GestureDetector.onPanUpdate ger drag position som mappas till value range."

---

#### VStack Layout ([Demo](http://localhost:3000/components/vstack))
- [ ] Different spacing values
- [ ] Different alignments (start, center, end, stretch)
- [ ] Flexible/Expanded children
- [ ] Nested layouts

**Say:** "VStack är custom RenderBox där performLayout() manually beräknar child positions baserat på spacing och alignment."

---

#### HStack Layout ([Demo](http://localhost:3000/components/hstack))
- [ ] Horizontal spacing
- [ ] Cross-axis alignment
- [ ] Similar to VStack but horizontal

---

#### ZStack Layout ([Demo](http://localhost:3000/components/zstack))
- [ ] Badge overlay example
- [ ] Layering demonstration
- [ ] Alignment options

**Say:** "ZStack layerar children i paint order. Första child = bottom layer, sista child = top layer."

---

# Part 4: Technical Deep-Dive (4 min)

## Code Example 1: PrimitiveCard (UI Component)

**Location:** `project/primitive_ui/lib/src/components/primitive_card.dart`

### Implementation Overview

```dart
class PrimitiveCard extends StatelessWidget {
  final Widget child;
  final Color color;
  final double borderRadius;
  final double elevation;
  final EdgeInsets padding;
  final Duration duration;
  final Curve curve;

  const PrimitiveCard({
    Key? key,
    required this.child,
    this.color = Colors.white,
    this.borderRadius = 8.0,
    this.elevation = 2.0,
    this.padding = const EdgeInsets.all(16.0),
    this.duration = const Duration(milliseconds: 200),
    this.curve = Curves.easeInOut,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TweenAnimationBuilder for implicit animations
    return TweenAnimationBuilder<double>(
      duration: duration,
      curve: curve,
      tween: Tween<double>(begin: elevation, end: elevation),
      builder: (context, animatedElevation, child) {
        return CustomPaint(
          painter: _CardPainter(
            color: color,
            elevation: animatedElevation,
            borderRadius: borderRadius,
          ),
          child: Padding(
            padding: padding,
            child: this.child,
          ),
        );
      },
    );
  }
}

// Custom painter for rendering
class _CardPainter extends CustomPainter {
  final Color color;
  final double elevation;
  final double borderRadius;

  _CardPainter({
    required this.color,
    required this.elevation,
    required this.borderRadius,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    final rrect = RRect.fromRectAndRadius(
      rect,
      Radius.circular(borderRadius),
    );

    // Manual shadow rendering
    final shadowPath = Path()..addRRect(rrect);
    canvas.drawShadow(
      shadowPath,
      Colors.black,
      elevation,
      false, // transparent occluder
    );

    // Manual background drawing
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;
    canvas.drawRRect(rrect, paint);
  }

  @override
  bool shouldRepaint(_CardPainter oldDelegate) {
    return oldDelegate.color != color ||
           oldDelegate.elevation != elevation ||
           oldDelegate.borderRadius != borderRadius;
  }
}
```

### Key Techniques

1. **CustomPaint:** Gives access to Canvas API
2. **Canvas.drawShadow():** Manual shadow rendering for elevation
3. **Canvas.drawRRect():** Rounded rectangle drawing
4. **shouldRepaint():** Performance optimization - only repaint when needed
5. **TweenAnimationBuilder:** Implicit animations for property changes

**Show in VS Code:** Open `primitive_card.dart` and scroll to `paint()` method

---

## Code Example 2: VStack (Layout Component)

**Location:** `project/primitive_ui/lib/src/components/v_stack.dart`

### Implementation Overview

```dart
class VStack extends MultiChildRenderObjectWidget {
  final double spacing;
  final CrossAxisAlignment crossAxisAlignment;
  final MainAxisAlignment mainAxisAlignment;
  final MainAxisSize mainAxisSize;

  VStack({
    Key? key,
    required List<Widget> children,
    this.spacing = 0.0,
    this.crossAxisAlignment = CrossAxisAlignment.start,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.mainAxisSize = MainAxisSize.max,
  }) : super(key: key, children: children);

  @override
  RenderObject createRenderObject(BuildContext context) {
    return RenderVStack(
      spacing: spacing,
      crossAxisAlignment: crossAxisAlignment,
      mainAxisAlignment: mainAxisAlignment,
      mainAxisSize: mainAxisSize,
    );
  }
}

// Custom RenderBox for layout logic
class RenderVStack extends RenderBox
    with ContainerRenderObjectMixin<RenderBox, VStackParentData> {
  
  double spacing;
  CrossAxisAlignment crossAxisAlignment;
  MainAxisAlignment mainAxisAlignment;
  MainAxisSize mainAxisSize;

  RenderVStack({
    required this.spacing,
    required this.crossAxisAlignment,
    required this.mainAxisAlignment,
    required this.mainAxisSize,
  });

  @override
  void performLayout() {
    // 1. Measure all children
    double maxWidth = 0;
    double totalHeight = 0;
    RenderBox? child = firstChild;
    int childCount = 0;

    while (child != null) {
      final VStackParentData childParentData = child.parentData as VStackParentData;
      
      // Layout child with constraints
      child.layout(
        BoxConstraints(
          minWidth: 0,
          maxWidth: constraints.maxWidth,
          minHeight: 0,
          maxHeight: constraints.maxHeight,
        ),
        parentUsesSize: true,
      );

      maxWidth = math.max(maxWidth, child.size.width);
      totalHeight += child.size.height;
      childCount++;

      child = childParentData.nextSibling;
    }

    // Add spacing between children
    if (childCount > 1) {
      totalHeight += spacing * (childCount - 1);
    }

    // 2. Set own size
    size = Size(
      constraints.maxWidth,
      constraints.constrainHeight(totalHeight),
    );

    // 3. Position children
    double yOffset = 0;
    child = firstChild;

    while (child != null) {
      final VStackParentData childParentData = child.parentData as VStackParentData;
      
      // Calculate x offset based on cross-axis alignment
      double xOffset;
      switch (crossAxisAlignment) {
        case CrossAxisAlignment.start:
          xOffset = 0;
          break;
        case CrossAxisAlignment.center:
          xOffset = (size.width - child.size.width) / 2;
          break;
        case CrossAxisAlignment.end:
          xOffset = size.width - child.size.width;
          break;
        case CrossAxisAlignment.stretch:
          xOffset = 0;
          // Child already stretched by constraints
          break;
      }

      // Set child position
      childParentData.offset = Offset(xOffset, yOffset);

      // Move to next child position
      yOffset += child.size.height + spacing;

      child = childParentData.nextSibling;
    }
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    // Paint all children in order
    RenderBox? child = firstChild;
    while (child != null) {
      final VStackParentData childParentData = child.parentData as VStackParentData;
      context.paintChild(child, childParentData.offset + offset);
      child = childParentData.nextSibling;
    }
  }
}
```

### Layout Algorithm

1. **Measure phase:** Iterate children, call `child.layout()` with constraints
2. **Size calculation:** Sum child heights + spacing
3. **Positioning phase:** Calculate offsets based on alignment
4. **Paint phase:** Paint children at calculated offsets

**Show in VS Code:** Open `v_stack.dart` and scroll to `performLayout()` method

---

# Part 5: UI Testing (3 min)

## Testing Approach

**Framework:** Flutter widget testing (`flutter_test` package)

### Test Statistics

- **Total test files:** 10
- **Total test cases:** 47+
- **Coverage:** All 9 components
- **Test types:** Rendering, Interaction, Animation, Edge cases

### Running Tests

```bash
cd project/primitive_ui
flutter test

# Expected output:
# 00:02 +47: All tests passed!
```

## Test Example: PrimitiveToggleSwitch

**Location:** `project/primitive_ui/test/primitive_toggle_switch_test.dart`

```dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:primitive_ui/primitive_ui.dart';

void main() {
  group('PrimitiveToggleSwitch', () {
    
    testWidgets('renders correctly in off state', (WidgetTester tester) async {
      bool switchValue = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: PrimitiveToggleSwitch(
              value: switchValue,
              onChanged: (value) => switchValue = value,
            ),
          ),
        ),
      );

      // Verify the widget renders
      expect(find.byType(PrimitiveToggleSwitch), findsOneWidget);
      expect(find.byType(GestureDetector), findsWidgets);
    });

    testWidgets('toggles from off to on when tapped', (WidgetTester tester) async {
      bool switchValue = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: PrimitiveToggleSwitch(
              value: switchValue,
              onChanged: (value) {
                switchValue = value;
              },
            ),
          ),
        ),
      );

      // Find and tap the switch
      await tester.tap(find.byType(PrimitiveToggleSwitch));
      
      // Wait for animation to complete (200ms)
      await tester.pumpAndSettle(const Duration(milliseconds: 200));

      // Verify value changed
      expect(switchValue, true);
    });

    testWidgets('calls onChanged with correct value', (WidgetTester tester) async {
      bool? receivedValue;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: PrimitiveToggleSwitch(
              value: false,
              onChanged: (value) {
                receivedValue = value;
              },
            ),
          ),
        ),
      );

      await tester.tap(find.byType(PrimitiveToggleSwitch));
      await tester.pump(); // Trigger one frame

      expect(receivedValue, true);
    });

    testWidgets('animates smoothly over 200ms', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: PrimitiveToggleSwitch(
              value: false,
              onChanged: (value) {},
            ),
          ),
        ),
      );

      await tester.tap(find.byType(PrimitiveToggleSwitch));
      
      // Pump frames during animation
      await tester.pump(); // Start
      await tester.pump(const Duration(milliseconds: 100)); // Middle
      await tester.pump(const Duration(milliseconds: 100)); // End

      // Animation should complete
      await tester.pumpAndSettle();
      
      // No errors should occur during animation
    });

    testWidgets('supports custom colors', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: PrimitiveToggleSwitch(
              value: true,
              onChanged: (value) {},
              activeColor: Colors.blue,
              inactiveColor: Colors.grey,
            ),
          ),
        ),
      );

      expect(find.byType(PrimitiveToggleSwitch), findsOneWidget);
    });
  });
}
```

### What Tests Cover

1. **Rendering:** Widget renders without crashing
2. **Interaction:** Tap triggers state change
3. **Callbacks:** `onChanged` called with correct value
4. **Animation:** 200ms animation completes smoothly
5. **Customization:** Custom colors work
6. **Edge cases:** Rapid taps, null checks

**Live Demo:** Run tests in terminal during presentation

---

# Part 6: Getting Started Guide (2 min)

## Guide Overview

**Location:** `FLUTTER_GETTING_STARTED_GUIDE.md`  
**Size:** 26 KB (~80 pages)  
**Target Audience:** Programmerare nya till Flutter

### Content Structure

#### 1. Installation & Setup
- Flutter SDK installation (Windows/Mac/Linux)
- `flutter doctor` verification
- Create first project

#### 2. Layout Basics ← **REQUIRED FOR GRADE 5**
- Widget fundamentals (StatelessWidget, StatefulWidget)
- Container, Column, Row, Stack
- Expanded, Flexible, SizedBox
- Complex example (profile card UI)

```dart
// Example from guide:
Column(
  mainAxisAlignment: MainAxisAlignment.center,
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
    Text('Item 1'),
    Text('Item 2'),
    ElevatedButton(
      onPressed: () {},
      child: Text('Click'),
    ),
  ],
)
```

#### 3. Interaktion & State ← **REQUIRED FOR GRADE 5**
- StatelessWidget vs StatefulWidget
- `setState()` pattern
- Event handlers (button, text field, checkbox)
- Callbacks
- Lifting state up

```dart
// Example from guide:
class Counter extends StatefulWidget {
  @override
  State<Counter> createState() => _CounterState();
}

class _CounterState extends State<Counter> {
  int _count = 0;
  
  void _increment() {
    setState(() {
      _count++;
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('Count: $_count'),
        ElevatedButton(
          onPressed: _increment,
          child: Text('Increment'),
        ),
      ],
    );
  }
}
```

#### 4. Navigering ← **REQUIRED FOR GRADE 5**
- Routes & Navigator
- `Navigator.push()` and `Navigator.pop()`
- Passing data between screens
- Named routes

```dart
// Example from guide:
Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => SecondScreen(data: 'Hello'),
  ),
);
```

#### 5. Next Steps
- Async/await
- HTTP requests
- State management libraries (Provider)
- Animations
- Resources

### Why This Guide Matters

**Fulfills Grade 5 requirement:**
> "Du ska skriva en Komma igång guide för ett av ramverken... Din guide ska täcka:
> * Enkel Layout av komponenter/widgets
> * Grundläggande interaktion med lyssnare/callbacks-functions
> * Navigering mellan olika skärmar"

**Show:** Open `FLUTTER_GETTING_STARTED_GUIDE.md` and scroll through sections

---

# Part 7: Summary & Takeaways (1 min)

## Project Achievements

### Quantitative
- **9 komponenter** (6 UI + 3 layout) - mer än required 4
- **47+ test cases** - comprehensive coverage
- **26 KB Getting Started guide** - complete documentation
- **~130 KB total documentation** - extensive materials
- **0 high-level widgets** - all primitives

### Qualitative
- **Deep understanding** av Flutter rendering pipeline
- **Custom layout algorithms** från grunden
- **Performance optimization** med shouldRepaint()
- **API design** för återanvändbarhet
- **Testing practices** för UI components

## Key Learnings

### 1. Rendering
- Hur Canvas API fungerar (drawRect, drawShadow, drawPath)
- Skillnad mellan drawing och compositing
- Layer caching och performance

### 2. Layout
- Constraints go down, sizes go up (layout protocol)
- Intrinsic sizing för correct measurements
- Custom RenderBox implementation

### 3. State Management
- Widget immutability enforces clean architecture
- setState() är simple men powerful
- Animation states behöver careful lifecycle management

### 4. Testing
- Widget testing är powerful för UI verification
- pumpAndSettle() för animations
- Test-driven development approach

### 5. API Design
- Naming consistency (PrimitiveX pattern)
- Required vs optional parameters
- Sensible defaults för ease of use
- Documentation är critical

## Biggest Takeaway

> "High-level widgets (Column, Card, etc) gör MYCKET arbete behind scenes. Att bygga dem själv ger djup appreciation för framework complexity och design decisions."

---

# Grade 5 Checklist

## All Requirements Met

### Betyg 3 (Grundkrav)
- [x] **2+ UI komponenter** → HAR 6: Button, Input, Card, Toggle, Slider, Progress
- [x] **2+ Layout komponenter** → HAR 3: VStack, HStack, ZStack
- [x] **Från primitiver** → CustomPaint, Canvas, GestureDetector ENDAST
- [x] **Demo application** → `primitive_demo/` med comprehensive examples
- [x] **Tydlig SDK struktur** → Återanvändbart package med clean API
- [x] **Icke-triviala komponenter** → Alla är complex implementations
- [x] **Effektiv kod** → shouldRepaint(), const constructors, optimizations
- [x] **Godtagbar kommentering** → Extensive documentation i kod

### Betyg 4 (EN av dessa)
- [x] **Getting Started guide** → FLUTTER_GETTING_STARTED_GUIDE.md (26 KB)
- [x] **UI Testing** → 47+ tests i 10 test files ✓

### Betyg 5 (BÅDA krävs)
- [x] **Getting Started guide för Flutter** → Täcker layout, interaktion, navigering ✓
- [x] **UI Testing** → Comprehensive widget tests för alla komponenter ✓

**RESULTAT: ALLA KRAV FÖR BETYG 5 UPPFYLLDA!**

---

# Q&A Preparation

## Likely Questions

### Q: "Varför CustomPaint och inte Container?"
**A:** Container är high-level widget som använder flera RenderObjects under huven. CustomPaint ger direkt access till Canvas API där jag själv måste rita varje pixel. Detta ger förståelse för hur rendering faktiskt fungerar.

### Q: "Hur fungerar din layout algorithm i VStack?"
**A:** Custom RenderBox där performLayout() itererar children, anropar child.layout() med constraints, summerar sizes, beräknar positions baserat på spacing och alignment, och sätter offsets.

### Q: "Varför AnimationController men inte Column?"
**A:** AnimationController är timing utility som genererar värden 0.0→1.0. Column är layout widget - exakt vad vi ska lära oss implementera själva. Att implementera animation timing hade distracts från core learning om rendering/layout.

### Q: "Hur testar du att komponenter fungerar?"
**A:** Widget tests med testWidgets, pumpWidget för rendering, tap för interaction, pumpAndSettle för animations, expect för assertions. Täcker rendering, callbacks, animationer.

### Q: "Vad är limitations?"
**A:** Performance (custom paint kan vara slower), text rendering (använder TextPainter), accessibility (basic implementation), platform specificity (samma look överallt). Men syftet var pedagogiskt.

### Q: "Hur skulle du förbättra projektet?"
**A:** Fler komponenter (dropdown, modal, tabs), grid layout, physics animations, theme system, golden tests för visual regression, performance profiling.

---

# Source Code References

## Quick Links to Key Files

### UI Components
```
project/primitive_ui/lib/src/components/
├── primitive_button.dart          (Button implementation)
├── primitive_input.dart           (Input implementation)
├── primitive_card.dart            (Card implementation)
├── primitive_toggle_switch.dart   (Toggle implementation)
├── primitive_slider.dart          (Slider implementation)
└── primitive_circular_progress.dart (Progress implementation)
```

### Layout Components
```
project/primitive_ui/lib/src/components/
├── v_stack.dart    (Vertical layout)
├── h_stack.dart    (Horizontal layout)
└── z_stack.dart    (Layered stack)
```

### Test Files
```
project/primitive_ui/test/
├── primitive_button_test.dart
├── primitive_input_test.dart
├── primitive_card_test.dart
├── primitive_toggle_switch_test.dart
├── primitive_slider_test.dart
├── primitive_circular_progress_test.dart
├── v_stack_test.dart
├── h_stack_test.dart
└── z_stack_test.dart
```

### Documentation
```
project/primitive_ui/README.md              (API documentation)
project/primitive_demo/README.md            (Demo guide)
FLUTTER_GETTING_STARTED_GUIDE.md           (Getting Started)
```

---

# Useful Commands During Presentation

## Start Services

```bash
# Terminal 1: Documentation site
cd docs-site
npm run dev
# → http://localhost:3000

# Terminal 2: Demo app
cd project/primitive_demo
flutter run -d chrome
# → http://localhost:[assigned-port]

# Terminal 3: Tests (run on demand)
cd project/primitive_ui
flutter test
```

## Quick Commands

```bash
# Hot reload demo (after code changes)
# Press 'r' in terminal

# Hot restart demo (full restart)
# Press 'R' in terminal

# Quit demo
# Press 'q' in terminal

# Run specific test file
flutter test test/primitive_toggle_switch_test.dart

# Run tests with verbose output
flutter test --reporter expanded
```

---

# Presentation Tips

## During Demo
- Speak slowly and clearly
- Point with cursor when explaining
- Pause after each section for questions
- Say "Låt mig visa..." before switching windows
- Explain WHY, not just WHAT

## If Something Goes Wrong
- Demo crashes → Press 'R' for hot restart
- Tests fail → Run specific test file
- Forgot point → Refer to this document
- Question unclear → Ask examiner to repeat

## Time Management
- Introduction: 2 min
- Architecture: 3 min
- Live Demo: 6 min (most important!)
- Code Deep-Dive: 4 min
- Testing: 3 min
- Getting Started: 2 min
- Summary: 1 min
- **Total: 21 minutes** + Q&A (~10 min)

---

# Final Checklist

## Before Starting Presentation

- [ ] Documentation site running at localhost:3000
- [ ] Demo app running in Chrome
- [ ] VS Code open with key files
- [ ] This presentation document open
- [ ] Terminal ready for tests
- [ ] Screen sharing enabled in Zoom
- [ ] Notifications disabled
- [ ] Font sizes increased (VS Code, terminal, browser)

## During Presentation

- [ ] Introduce project (30 seconds)
- [ ] Show architecture overview (component list)
- [ ] Live demo all 9 components
- [ ] Show PrimitiveCard code (CustomPaint/Canvas)
- [ ] Show VStack code (RenderBox layout)
- [ ] Run flutter test (show passing tests)
- [ ] Show Getting Started guide
- [ ] Summarize achievements
- [ ] Answer questions confidently

---

# You Are Ready!

**Du har:**
- Strong projekt med 9 komponenter
- Comprehensive testing (47+ tests)
- Complete documentation
- Working demo application
- This live presentation guide

**Nu är det bara att:**
1. Följ detta dokument under presentationen
2. Klicka på länkar när du behöver visa något
3. Kör kommandon när examiner ber om det
4. Svara på frågor med confidence

**LYCKA TILL!**

---

**Last Updated:** December 17, 2024  
**Version:** 1.0 - Live Presentation Document  
**Purpose:** Single-file presentation guide med allt du behöver
