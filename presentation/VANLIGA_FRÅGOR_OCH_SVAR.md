# Vanliga Frågor & Svar - Muntlig Examination
**Q&A prep för Primitive UI projektet**

---

##  Tekniska Frågor

### Q1: Vad är skillnaden mellan CustomPaint och vanliga widgets som Container?

**Svar:**
```
Container är en high-level widget som under huven använder flera RenderObjects
för att hantera decoration, padding, constraints, etc. Det är convenience wrapper.

CustomPaint ger direkt access till Canvas API där vi själva måste rita varje pixel.
Vi får full kontroll men måste implementera allt själva:
- Shadows med drawShadow()
- Shapes med drawRect(), drawCircle(), drawRRect()
- Colors med Paint objects

Container använder dessa under huven, men abstraherar bort complexity.
Mitt projekt använder CustomPaint för att lära mig hur rendering faktiskt fungerar.
```

**Follow-up:** "Visa i kod"
- Öppna `primitive_card.dart`
- Peka på `CustomPaint(painter: _CardPainter(...))`
- Visa `paint()` metoden med Canvas calls

---

### Q2: Hur fungerar din layout algorithm i VStack?

**Svar:**
```
VStack använder custom RenderBox med ContainerRenderObjectMixin för multi-child layout.

performLayout() algorithmen:
1. Iterate över alla children
2. För varje child: anropa child.layout() med tight eller loose constraints
3. Beräkna total höjd = sum(child.height) + spacing * (childCount - 1)
4. Positionera barn vertikalt:
   - Start: offset = 0
   - För varje child: setParentData med offset
   - Increment offset med child.height + spacing
5. Applicera crossAxisAlignment (horizontal):
   - start: x = 0
   - center: x = (maxWidth - childWidth) / 2
   - end: x = maxWidth - childWidth
   - stretch: ge child full width

Detta är samma algoritm som Flutters Column, men jag har implementerat den själv.
```

**Follow-up:** "Visa i kod"
- Öppna `v_stack.dart`
- Visa `performLayout()` metoden
- Förklara constraints propagation

---

### Q3: Varför används GestureDetector och inte raw touch events?

**Svar:**
```
GestureDetector är Flutters lägsta abstraction för touch input som är practical.

Alternativen:
- Raw PointerEvents: Mycket low-level, ger oss x/y coordinates men inget gesture
  recognition (tap vs long press vs drag)
- Listener widget: Liknande men fortfarande väldigt low-level

GestureDetector ger oss:
- onTap, onTapDown, onTapUp, onTapCancel - För button interactions
- onPanUpdate, onPanEnd - För slider drag
- onLongPress - För context menus

Att implementera gesture recognition från raw pointer events (distinguera tap från
drag, handle multi-touch, etc) hade varit en major distraction från core learning
om rendering och layout.

Projektkraven säger explicit "GestureDetector" är tillåten primitive.
```

---

### Q4: Hur hanterar du state changes och rebuilds?

**Svar:**
```
Jag använder StatefulWidget pattern:

1. Widget layer: PrimitiveToggleSwitch extends StatefulWidget
2. State layer: _PrimitiveToggleSwitchState extends State<...>
3. State håller mutable data: _animationController, _animation
4. När user interagerar: GestureDetector onTap calls setState(() { ... })
5. setState() markerar widget tree som dirty
6. Flutter's scheduler kör build() igen
7. build() returnerar updated widget tree
8. Rendering layer diffs trees och paint bara vad som ändrats

För animationer:
- AnimationController drives animation från 0.0 till 1.0
- addListener(() => setState(() {})) triggar rebuild varje frame
- I paint(), interpolera värden baserat på animation.value
- 60 FPS smooth animation

Detta är standard Flutter state management - inget fancy behövs för detta projekt.
```

**Follow-up:** "Visa animation kod"
- Öppna `primitive_toggle_switch.dart`
- Visa `_animationController` setup
- Visa `addListener()` som triggrar setState
- Visa paint() där animation.value används

---

### Q5: Hur testar du att komponenter renderas korrekt?

**Svar:**
```
Jag använder Flutter's widget testing framework (flutter_test package).

Test anatomy:
1. testWidgets() wrapper med WidgetTester parameter
2. tester.pumpWidget() för att rendera widget
3. find.byType() eller find.text() för att lokalisera widgets
4. expect() för assertions
5. tester.tap() för interaktion
6. tester.pump() för att advance frames
7. tester.pumpAndSettle() för att vänta på animationer

Example från toggle switch test:
```dart
testWidgets('toggles from off to on', (tester) async {
  bool value = false;
  
  await tester.pumpWidget(MaterialApp(
    home: PrimitiveToggleSwitch(
      value: value,
      onChanged: (v) => value = v,
    ),
  ));
  
  await tester.tap(find.byType(PrimitiveToggleSwitch));
  await tester.pumpAndSettle(Duration(milliseconds: 200));
  
  expect(value, true);
});
```

Detta testar:
- Rendering (pumpWidget succeeded)
- Interaction (tap detected)
- Animation (pumpAndSettle waited 200ms)
- Callback (value changed)
```

**Follow-up:** "Kör tests live"
```bash
cd project/primitive_ui
flutter test test/primitive_toggle_switch_test.dart
```

---

### Q6: Varför AnimationController men inte Column/Row?

**Svar:**
```
Projektet fokuserar på att lära RENDERING och LAYOUT från grunden.

AnimationController är en timing utility:
- Genererar värden från 0.0 till 1.0 över tid
- Hanterar frame scheduling med TickerProvider
- Ger easing curves (linear, easeInOut, etc)
- Men ritar INGENTING själv

Att implementera egen animation engine (frame timing, vsync, curves) är computer
graphics problem, inte UI problem. Det distracts från learning objectives.

Column/Row är LAYOUT widgets:
- Beräknar constraints
- Positionerar children
- Hanterar spacing och alignment
- Detta är EXAKT vad vi ska lära oss

Skillnad:
- AnimationController: Helper för timing (som Math.random() eller DateTime)
- Column/Row: Core functionality vi implementerar (som List eller Map)

Grade-5 requirements säger "CustomPaint, Canvas, GestureDetector" - AnimationController
faller under "utilities" som är OK.
```

---

### Q7: Hur optimerar du rendering performance?

**Svar:**
```
Flera optimization strategies:

1. shouldRepaint() i CustomPainter:
```dart
@override
bool shouldRepaint(_CardPainter oldDelegate) {
  return oldDelegate.color != color ||
         oldDelegate.elevation != elevation ||
         oldDelegate.borderRadius != borderRadius;
}
```
Returnerar false om inget ändrats → skip repaint.

2. Const constructors där möjligt:
- Const widgets återanvänds, bygger inte om
- Mindre garbage collection

3. RepaintBoundary för isolation:
- Förhindrar att parent repaints triggrar child repaints
- Inte explicit använt men är vanlig teknik

4. Efficient layout:
- Cache intrinsic sizes när möjligt
- Avoid nested layout calls
- Use tight constraints when possible

5. Mät med Flutter DevTools:
- Performance overlay (tryck 'p' i running app)
- Timeline view för frame drops
- Widget rebuild stats

I praktiken, mina komponenter är så enkla att performance är non-issue.
Men dessa principles är viktiga för production apps.
```

---

### Q8: Vad händer om child widget ändrar size i VStack?

**Svar:**
```
Flutter's layout protocol hanterar detta automatically:

1. Child widget ändrar state → child's build() körs
2. Child returnerar ny widget tree med annorlunda size
3. Child's RenderBox performLayout() körs
4. Child returnerar ny size till parent
5. VStack's performLayout() körs igen (eftersom child size ändrats)
6. VStack beräknar om positions för alla children
7. Parent av VStack layout om igen (cascade upwards)
8. När layout är klar, paint phase börjar
9. Alla widgets som ändrats repaints

Detta är Flutter's reactive layout system. Vi behöver inte manuellt trigga
relayout - framework detekterar size changes och propagerar upwards automatically.

I min VStack implementation:
- performLayout() anropas av framework när needed
- Jag bara beräknar baserat på child.size
- Framework hanterar när/varför layout ska köras
```

---

### Q9: Hur skulle du lägga till en ny komponent?

**Svar:**
```
Processen för att bygga ny component (ex: PrimitiveCheckbox):

1. Skapa widget file: lib/src/components/primitive_checkbox.dart

2. Definiera API:
```dart
class PrimitiveCheckbox extends StatefulWidget {
  final bool value;
  final ValueChanged<bool> onChanged;
  final Color activeColor;
  // ... other props
  
  const PrimitiveCheckbox({
    required this.value,
    required this.onChanged,
    this.activeColor = Colors.blue,
  });
}
```

3. Implementera State med animation:
```dart
class _PrimitiveCheckboxState extends State<PrimitiveCheckbox>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: 150),
      vsync: this,
    );
  }
  
  // ...
}
```

4. CustomPaint för rendering:
```dart
CustomPaint(
  size: Size(24, 24),
  painter: _CheckboxPainter(
    isChecked: widget.value,
    progress: _controller.value,
    color: widget.activeColor,
  ),
)
```

5. Implementera painter:
```dart
class _CheckboxPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Rita box outline
    canvas.drawRRect(/*...*/);
    
    // Rita checkmark om checked
    if (isChecked) {
      Path checkPath = Path()
        ..moveTo(size.width * 0.2, size.height * 0.5)
        ..lineTo(size.width * 0.4, size.height * 0.7)
        ..lineTo(size.width * 0.8, size.height * 0.3);
      canvas.drawPath(checkPath, Paint()..color = color);
    }
  }
}
```

6. Export från barrel: lib/primitive_ui.dart
```dart
export 'src/components/primitive_checkbox.dart';
```

7. Skriv tests: test/primitive_checkbox_test.dart

8. Uppdatera README med API docs

Detta process följer samma pattern som alla mina existing components.
```

---

##  Conceptual Frågor

### Q10: Vad är Flutter's rendering pipeline?

**Svar:**
```
Three-tree architecture:

1. WIDGET TREE (Configuration)
   - Immutable declarations av UI
   - build() methods returnerar widgets
   - Widgets är lightweight (just configuration)

2. ELEMENT TREE (Lifecycle)
   - Mutable objects med lifecycle
   - Mount/unmount widgets
   - Håller references till widgets och renderObjects
   - Diffar widget trees vid rebuild

3. RENDER TREE (Layout & Paint)
   - RenderObjects som gör actual work
   - performLayout(): Beräknar sizes och positions
   - paint(): Ritar till Canvas
   - Skickar layers till compositor

Flow:
setState() → build() → new Widget tree → Element tree diffs →
Update RenderObjects → Layout pass → Paint pass → Compositor → Screen

Mitt projekt:
- CustomPaint är widget (config)
- Skapar RenderCustomPaint (render object)
- Calls min CustomPainter.paint() med Canvas
```

**Diagram (rita om ombedd):**
```
Widget Tree          Element Tree         Render Tree
   |                     |                      |
MyApp  ------------> _MyAppElement -------> RenderView
   |                     |                      |
Column ------------> _ColumnElement -----> RenderFlex
   |                     |                      |
Text   ------------> _TextElement -------> RenderParagraph
```

---

### Q11: Varför Flutter och inte React Native eller Native?

**Svar:**
```
Flutter för detta projekt:

PROS:
+ Canvas API är well-documented och powerful
+ CustomPaint ger clean abstraction för custom rendering
+ Dart är statically typed (less bugs)
+ Hot reload är amazing för iterativ development
+ Samma kod för mobile, web, desktop
+ Skia rendering engine är fast och consistent

CONS:
- Större app size (~4MB overhead)
- Mindre ecosystem än React Native
- Dart är mindre populärt språk

React Native alternativet:
- Använder native components under huven
- Svårare att bygga FULLY custom rendering
- Men större community och libraries

Native (Swift/Kotlin) alternativet:
- Bästa performance
- Men måste bygga twice (iOS + Android)
- Längre development cycle

För LEARNING om rendering: Flutter är bäst eftersom den LÅTER oss komma åt
low-level rendering medan React Native döljer mycket.
```

---

### Q12: Vad har du lärt dig från projektet?

**Svar:**
```
Konkreta learnings:

1. RENDERING:
   - Hur Canvas API fungerar (drawRect, drawShadow, drawPath)
   - Skill mellan drawing och compositing
   - Varför Flutter är snabbt (layer caching)

2. LAYOUT:
   - Constraints go down, sizes go up (layout protocol)
   - Intrinsic sizing för correct measurements
   - Varför nested layout calls är expensive

3. STATE MANAGEMENT:
   - Widget immutability enforces clean architecture
   - setState() är simple men fungerar för majority of cases
   - Animation states behöver special care (dispose!)

4. TESTING:
   - Widget testing är powerful när det fungerar
   - pumpAndSettle() för animations
   - Mocking är svårt i Flutter (därför simple dependency injection)

5. API DESIGN:
   - Naming consistency (PrimitiveX pattern)
   - Required vs optional parameters
   - Sensible defaults för ease of use
   - Documentation är CRITICAL för adoption

6. DEVELOPMENT WORKFLOW:
   - Hot reload är game-changer
   - Aggressive const usage pays off
   - DevTools performance overlay är insightful

BIGGEST TAKEAWAY:
High-level widgets (Column, Card, etc) gör MYCKET arbete behind scenes.
Att bygga dem själv ger appreciation för framework authors.
```

---

### Q13: Vilka limitations har din implementation?

**Svar:**
```
Honest limitations:

1. PERFORMANCE:
   - Custom painting kan vara långsammare än widget composition
   - No layer caching optimization (Flutter gör detta automatiskt för vanliga widgets)
   - Många Canvas calls kan bottleneck på complex UIs

2. ACCESSIBILITY:
   - Grundläggande Semantics finns men kunde vara mer comprehensive
   - Screen reader support är OK men inte extensive tested
   - Keyboard navigation är default Flutter behavior (bra nog men not customized)

3. TEXT:
   - Använder Flutter's TextPainter - inte fully custom
   - Text rendering är EXTREMELY complex (Unicode, ligatures, RTL, etc)
   - Rimlig tradeoff för educational projekt

4. PLATFORM SPECIFICITY:
   - Mina komponenter ser samma ut överallt
   - Följer inte iOS vs Android design guidelines
   - Native feel är absent (men consistency är också värdefullt)

5. EDGE CASES:
   - Vissa constraint scenarios är inte fully tested
   - Very small sizes kan ge weird rendering
   - Extremely rapid interactions kunde bugga animations

6. FEATURES:
   - No ripple effects (Material design staple)
   - No theme system integration
   - No built-in form validation

Men poängen var PEDAGOGISK - lära fundamentals, inte bygga production library.
För production skulle jag använda Material/Cupertino widgets.
```

---

### Q14: Om du hade mer tid, vad skulle du förbättra?

**Svar:**
```
Prioriterad lista:

1. MORE COMPONENTS:
   - Dropdown menu (complex layout + overlay positioning)
   - Modal dialog (portal rendering)
   - Tabs (state management across multiple views)
   - Tooltip (hover + positioning logic)

2. ADVANCED LAYOUT:
   - Grid layout (two-dimensional layout algorithm)
   - Wrap layout (like CSS flexbox wrap)
   - ScrollView (viewport clipping, scroll physics)

3. ANIMATIONS:
   - Staggered animations
   - Shared element transitions
   - Physics-based animations (spring, friction)
   - Gesture-driven animations (dismiss with drag)

4. ACCESSIBILITY:
   - Full screen reader testing
   - Keyboard navigation customization
   - High contrast mode support
   - Reduce motion support

5. PERFORMANCE:
   - RepaintBoundary optimization
   - Layer caching
   - Benchmark suite
   - Profile med Flutter DevTools

6. DEVELOPER EXPERIENCE:
   - Theme system (colors, typography, spacing)
   - Better error messages
   - Storybook-style component gallery
   - More code examples in docs

7. TESTING:
   - Integration tests
   - Golden tests (screenshot comparison)
   - Performance tests
   - Accessibility tests

Men givet tidsbegränsning och scope, current implementation demonstrerar
core concepts väl.
```

---

##  Getting Started Guide Frågor

### Q15: Varför valde du att täcka just layout, interaktion och navigering?

**Svar:**
```
Dessa tre är fundamental building blocks för ANY Flutter app:

LAYOUT:
- Första steget efter "hello world"
- Måste förstå Column/Row/Container för att bygga NÅGOT
- Widget composition är Flutter's core paradigm

INTERAKTION:
- Statiska UI:er är boring
- setState() är gateway drug till state management
- Callbacks är hur widgets kommunicerar

NAVIGERING:
- Multi-screen apps är standarden
- Navigator är core Flutter API
- Routing concepts är samma i alla frameworks (React Router, Vue Router, etc)

Projektkraven säger:
"Din guide ska täcka:
* Enkel Layout av komponenter/widgets
* Grundläggande interaktion med lyssnare/callbacks-functions
* Navigering mellan olika skärmar"

Jag följer specen exakt.

Andra topics (async, HTTP, state management libraries) är viktiga men
"next steps" - inte för absoluta beginners.
```

---

### Q16: Hur skiljer sig din guide från officiell Flutter docs?

**Svar:**
```
Officiella Flutter docs:
- Comprehensive (covering EVERYTHING)
- Reference-style (good for lookup)
- Assumes no programming background (goes VERY slow)

Min guide:
- Focused (only layout, interaction, navigation)
- Tutorial-style (progressive examples)
- Assumes programming background (går snabbare)
- Targets developers from other frameworks
- Swenglish för svenska studenter

Konkret skillnad:
Flutter docs: "En widget är..."
Min guide: "I Flutter är allt en widget. Både UI elements (Text, Button) och 
layout (Column, Row). Detta är likt React's component model men mer granular."

Jag contextualiserar för den som redan kan programmera och kanske sett React.

Target audience:
- Programmerare från webbutveckling
- Android devs som kör Java/Kotlin
- iOS devs som kör Swift
- Studenter i TDDC73 som ska lära Flutter

Inte target audience:
- Complete beginners (learn programming first)
- Kids (Scratch är bättre)
```

---

##  Testing Frågor

### Q17: Varför widget tests och inte unit tests eller integration tests?

**Svar:**
```
Three types of tests i Flutter:

UNIT TESTS:
- Testa pure functions och business logic
- Snabba (milliseconds)
- Ex: "Does my validation function return true for valid email?"

WIDGET TESTS:
- Testa UI components i isolation
- Medium speed (seconds)
- Ex: "Does toggle switch call callback when tapped?"
- DETTA är vad jag har gjort

INTEGRATION TESTS:
- Testa hela app flows
- Slow (minutes)
- Ex: "Can user login, navigate to profile, update name?"

För mitt projekt:
- Inga business logic funktioner → unit tests not applicable
- Pure UI components → widget tests är PERFECT fit
- No multi-screen flows → integration tests overkill

Widget tests let me verify:
- Components render without crashing
- User interactions trigger correct callbacks
- Animations complete successfully
- State changes cause correct rebuilds

UI Testing requirements (betyg 5) säger:
"Du ska använda dig av rekommenderade testnings verktyg för ditt ramverk (UI-Testing)"

Widget tests är officiellt rekommenderad approach för component testing i Flutter.
```

---

### Q18: Vad är svårast att testa i dina komponenter?

**Svar:**
```
Utmaningar:

1. ANIMATIONS:
Problem: Animations är time-based, tests måste vänta
Solution: pumpAndSettle() + Duration parameter
```dart
await tester.tap(find.byType(PrimitiveToggleSwitch));
await tester.pumpAndSettle(Duration(milliseconds: 200));
// Nu är animation klar
```

2. CUSTOM PAINT:
Problem: Canvas calls är svåra att assert på
Solution: Testa indirectly genom outcomes
```dart
// Kan inte assert på "drawShadow was called"
// Men kan testa att widget finns och responds to input
expect(find.byType(PrimitiveCard), findsOneWidget);
```

3. GESTURES:
Problem: Drag gestures behöver coordinates
Solution: tester.drag() med offsets
```dart
await tester.drag(
  find.byType(PrimitiveSlider), 
  Offset(100, 0),  // 100 pixels right
);
```

4. VISUAL APPEARANCE:
Problem: Kan inte testa färger eller shadows directly i widget tests
Solution: Golden tests (screenshot comparison) - inte implementerat men could do
```dart
await expectLater(
  find.byType(PrimitiveCard),
  matchesGoldenFile('card_default.png'),
);
```

5. ASYNC STATE:
Problem: Components som fetchear data behöver mocking
Solution: Inte applicable för mitt projekt (no async operations)

Generellt: Widget testing är powerful men har limits.
För visual regression testing, golden tests är bättre.
För complex flows, integration tests är bättre.
```

---

##  Project Management Frågor

### Q19: Hur planerade du projektet?

**Svar:**
```
Approach:

1. RESEARCH PHASE (vecka 1):
   - Läs grade-5 requirements flera gånger
   - Studera Flutter rendering docs
   - Kolla exempel på CustomPaint usage
   - Decide på vilka components att bygga

2. PROTOTYPE PHASE (vecka 2):
   - Börja med simplest component (PrimitiveCard)
   - Lära Canvas API basics
   - Få hot reload workflow att fungera
   - Validate att approach fungerar

3. IMPLEMENTATION PHASE (vecka 3-4):
   - Bygga resterande UI components
   - Bygga layout components (VStack, HStack, ZStack)
   - Iterera på API design
   - Demo app samtidigt (för testing)

4. TESTING PHASE (vecka 5):
   - Skriv widget tests för alla components
   - Debug edge cases
   - Refactor duplicated code

5. DOCUMENTATION PHASE (vecka 6):
   - README med API docs
   - Getting Started guide
   - Demo app README
   - Code comments

6. POLISH PHASE (sista veckan):
   - Fix linter warnings
   - Improve examples
   - Prepare presentation materials

Challenges:
- CustomPaint learning curve var steep initially
- Layout algorithm i VStack var tricky (intrinsic sizing)
- Animation state management required several iterations

Tools:
- Git för version control (commit ofta!)
- VS Code med Flutter extensions
- Flutter DevTools för performance checking
- Markdown för documentation
```

---

### Q20: Hur mycket tid tog projektet?

**Svar:**
```
Estimated breakdown:

Research & Planning:        ~10 hours
Primitive Components:       ~25 hours
  - PrimitiveCard:          3 hours
  - PrimitiveButton:        5 hours
  - PrimitiveInput:         5 hours
  - PrimitiveToggleSwitch:  4 hours
  - PrimitiveSlider:        4 hours
  - PrimitiveProgress:      2 hours
Layout Components:          ~15 hours
  - VStack:                 6 hours
  - HStack:                 4 hours
  - ZStack:                 5 hours
Demo Application:           ~8 hours
Testing (all components):   ~12 hours
Documentation:              ~10 hours
  - README.md:              4 hours
  - Getting Started:        5 hours
  - Presentation prep:      1 hour
Debugging & Iteration:      ~10 hours
TOTAL:                      ~90 hours

Ungefär 2-3 veckor full-time work, eller 6-8 veckor part-time.

Biggest time sinks:
- Learning Canvas API initially (lots of trial and error)
- VStack intrinsic sizing bugs (took forever to debug)
- Writing comprehensive documentation (longer än expected)

If I did det igen:
- Would start med testing earlier (TDD approach)
- Would plan API design better upfront (less refactoring)
- Would document as I go (not all at end)
```

---

**Tips:** Förbered dessa svar men don't memorize word-for-word. Förstå concepts så du kan förklara flexibly. 
