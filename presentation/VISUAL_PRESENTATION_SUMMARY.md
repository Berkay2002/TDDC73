# Visual Presentation Summary
**One-page cheat sheet för quick reference under presentationen**

---

##  MITT PROJEKT I 30 SEKUNDER

**Primitive UI** = Flutter GUI-bibliotek byggt från GRUNDEN  
**Endast primitives:** CustomPaint + Canvas + GestureDetector  
**9 komponenter:** 6 UI + 3 layout  
**Testing:** 47+ widget tests  
**Docs:** README + Getting Started guide  
**Resultat:** Betyg 5 kvalitet 

---

##  KOMPONENTER OVERVIEW

### UI Components (6 stycken)
```
1. PrimitiveButton      → Knapp med variants (primary, destructive, etc)
2. PrimitiveInput       → Text input (outline/filled/flushed)
3. PrimitiveCard        → Container med shadow & border radius
4. PrimitiveToggleSwitch → Animerad on/off switch
5. PrimitiveSlider      → Drag slider för value selection
6. PrimitiveCircularProgress → Loading indicator
```

### Layout Components (3 stycken)
```
7. VStack → Vertikal layout (som Column men custom)
8. HStack → Horizontal layout (som Row men custom)
9. ZStack → Layering/stacking (som Stack men custom)
```

---

##  PRIMITIVES ANVÄNDNING

### CustomPaint & Canvas
```dart
CustomPaint(
  painter: _CardPainter(
    color: Colors.blue,
    elevation: 4.0,
    borderRadius: 8.0,
  ),
)

// I CustomPainter:
void paint(Canvas canvas, Size size) {
  canvas.drawShadow(...);  // För elevation
  canvas.drawRRect(...);   // För shape
}
```

### GestureDetector
```dart
GestureDetector(
  onTap: () => setState(() => _isPressed = !_isPressed),
  onTapDown: (_) => setState(() => _isPressed = true),
  onTapUp: (_) => setState(() => _isPressed = false),
  child: CustomPaint(...),
)
```

### Custom RenderBox (Layout)
```dart
class RenderVStack extends RenderBox with ContainerRenderObjectMixin {
  @override
  void performLayout() {
    // 1. Measure children
    // 2. Calculate total size
    // 3. Position children
    // 4. Apply alignment
  }
}
```

---

##  DEMO FLOW (6 minuter)

### Terminal Commands
```bash
# Terminal 1: Start demo
cd project/primitive_demo
flutter run -d chrome

# Terminal 2: Run tests
cd project/primitive_ui
flutter test
```

### Vad att visa i demo:
1. **Header** → Dark mode toggle (PrimitiveToggleSwitch)
2. **Cards** → Different elevations & border radius
3. **Buttons** → Olika variants, hover states
4. **Inputs** → Type in fields, focus states
5. **Toggle** → Smooth 200ms animation
6. **Slider** → Drag för value change
7. **VStack** → Spacing och alignment
8. **ZStack** → Badge overlay

**Tid per component: ~45 sekunder**

---

##  NYCKELFRASER

### Introduktion
```
"Jag har byggt Primitive UI - ett Flutter GUI-bibliotek från grunden 
med CustomPaint, Canvas och GestureDetector. Inga färdiga widgets som 
Column, Row eller Card används."
```

### Vid demo
```
"Detta är [Component]. Den är implementerad med CustomPaint där jag 
manuellt ritar [shadow/shape/animation] med Canvas API."
```

### Vid kod
```
"Här ser ni paint() metoden där Canvas.draw[X]() anropas för att rita 
varje pixel. shouldRepaint() optimerar genom att bara repaint när 
properties faktiskt ändras."
```

### Vid testing
```
"Mina widget tests täcker rendering, interaktion och animationer. 
pumpAndSettle() väntar på 200ms animation att färdigställas innan 
assertions körs."
```

---

##  SNABBA SVAR - TOP 5 FRÅGOR

### Q: "Varför CustomPaint och inte Container?"
**A:** Container är high-level widget. CustomPaint ger direkt Canvas access för att lära hur rendering fungerar.

### Q: "Hur fungerar VStack layout?"
**A:** Custom RenderBox med performLayout() som manually itererar children, beräknar size och positionerar med offsets.

### Q: "Varför AnimationController men inte Column?"
**A:** AnimationController = timing utility. Column = layout widget vi ska lära oss implementera själva.

### Q: "Hur testar du komponenter?"
**A:** Widget tests: pumpWidget → tap → pumpAndSettle → expect callback triggered.

### Q: "Vad är limitations?"
**A:** Performance (custom paint är slower), text rendering (använder TextPainter), platform specificity (samma look överallt).

---

##  FILER ATT HA ÖPPNA

### I VS Code (Font size 16+):
1. `project/primitive_ui/README.md`
2. `project/primitive_ui/lib/src/components/primitive_card.dart`
3. `project/primitive_ui/test/primitive_toggle_switch_test.dart`
4. `FLUTTER_GETTING_STARTED_GUIDE.md`

### I Browser:
1. Demo app (running på Chrome)
2. Denna fil (för quick reference)

### Terminals:
1. `project/primitive_demo` (för demo)
2. `project/primitive_ui` (för tests)

---

## ⏱ TIMING

| Del | Tid | Innehåll |
|-----|-----|----------|
| Intro | 2 min | Vad projektet är |
| Arkitektur | 3 min | 9 komponenter overview |
| **Live Demo** | **6 min** | **HUVUDFOKUS** |
| Code Deep-Dive | 4 min | primitive_card.dart |
| Testing | 3 min | flutter test |
| Getting Started | 2 min | Guide walkthrough |
| Summary | 1 min | Recap + takeaways |
| **TOTAL** | **21 min** | + Q&A (~10 min) |

---

##  CANVAS API EXEMPEL

### Drawing Shapes
```dart
// Rectangle
canvas.drawRect(Rect.fromLTWH(0, 0, 100, 50), paint);

// Circle
canvas.drawCircle(Offset(50, 50), 25, paint);

// Rounded rectangle
canvas.drawRRect(
  RRect.fromRectAndRadius(rect, Radius.circular(8)),
  paint,
);

// Shadow
canvas.drawShadow(path, Colors.black, elevation, false);
```

### Paint Configuration
```dart
final paint = Paint()
  ..color = Colors.blue
  ..style = PaintingStyle.fill  // eller .stroke
  ..strokeWidth = 2.0;
```

---

##  TEST EXEMPEL

```dart
testWidgets('toggle switch changes value on tap', (tester) async {
  bool value = false;
  
  // Render widget
  await tester.pumpWidget(MaterialApp(
    home: PrimitiveToggleSwitch(
      value: value,
      onChanged: (v) => value = v,
    ),
  ));
  
  // Interact
  await tester.tap(find.byType(PrimitiveToggleSwitch));
  
  // Wait for animation
  await tester.pumpAndSettle(Duration(milliseconds: 200));
  
  // Assert
  expect(value, true);
});
```

---

##  GETTING STARTED GUIDE - STRUKTUR

**Täcker (enligt krav):**
1.  Layout → Container, Column, Row, Stack
2.  Interaktion → StatefulWidget, setState, callbacks
3.  Navigering → Navigator.push, routes, data passing

**Format:**
- Code examples för varje concept
- Progressive complexity
- Riktat till programmerare (not complete beginners)
- ~50 pages, comprehensive

---

##  EMERGENCY QUICK FIXES

### Demo kraschar:
1. Tryck `R` (hot restart)
2. Om fails: `q` → `flutter run -d chrome` igen
3. Om fails: Visa screenshots/README

### Tests failar:
1. Kör specifik test: `flutter test test/primitive_toggle_switch_test.dart`
2. Om fails: Visa screenshot från previous run
3. Förklara vad tests gör utan att köra

### Glömt vad du ska säga:
1. Titta på denna fil
2. Deep breath
3. "Låt mig visa istället..." → demo

---

##  BETYG 5 CHECKLIST

- [x] **Grundkrav:** 2+ UI komponenter → Har 6 
- [x] **Grundkrav:** 2+ Layout komponenter → Har 3 
- [x] **Grundkrav:** Från primitives → CustomPaint/Canvas 
- [x] **Grundkrav:** Demo app → primitive_demo 
- [x] **Betyg 5:** Getting Started guide → Flutter guide 
- [x] **Betyg 5:** UI Testing → 47+ tests 

**RESULT: UPPFYLLER ALLA KRAV** 

---

##  SISTA MINUTEN TIPS

**Före du börjar:**
- Deep breath × 3
- Smile (gör dig själv relaxed)
- "Jag är förberedd och redo"

**Under presentation:**
- Speak slowly (don't rush!)
- Point with cursor när du förklarar
- Pause för frågor
- OK att säga "bra fråga, låt mig visa..."

**Om något går fel:**
- "Låt mig fixa det snabbt..."
- Use backup plan
- Don't panic!
- Continue explaining verbally

---

##  DU ÄR REDO

**Du har:**
-  Strong projekt
-  Working demo
-  Passing tests
-  Complete docs
-  Prepared answers

**Du kan:**
-  Explain concepts
-  Show implementation
-  Answer questions
-  Handle problems

**Result:**
# BETYG 5 

---

**Print this page and ha det bredvid dig under presentationen!**

**Lycka till! **
