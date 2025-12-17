# Oral Exam Q&A - Quick Reference
**Ultra-kort svar på vanligaste frågorna**

---

## Projekt Overview

**Q: Vad är Primitive UI?**
→ Flutter GUI-bibliotek byggt från grunden med CustomPaint, Canvas, GestureDetector. Inga färdiga widgets.

**Q: Hur många komponenter?**
→ 9 totalt: 6 UI (Button, Input, Card, Toggle, Slider, Progress) + 3 layout (VStack, HStack, ZStack)

**Q: Vad är målet?**
→ Förstå hur Flutter rendering fungerar "under huven" genom att bygga allt från primitives.

---

## Teknisk Implementation

**Q: Varför CustomPaint?**
→ Direkt access till Canvas API. Container är high-level abstraction. CustomPaint låter oss rita varje pixel själva.

**Q: Hur ritar du shapes?**
→ Canvas.drawRect(), drawCircle(), drawRRect(), drawShadow() med Paint objects för colors/styles.

**Q: Hur fungerar layout i VStack?**
→ Custom RenderBox: performLayout() → iterate children → layout() → calculate size → position med offsets → apply alignment.

**Q: Hur hanterar du touch input?**
→ GestureDetector wrapper med onTap, onTapDown, onTapUp callbacks som triggar setState().

**Q: Hur fungerar animationer?**
→ AnimationController från 0.0→1.0, addListener() triggar setState(), interpolate värden i paint() baserat på animation.value.

**Q: Vad är shouldRepaint()?**
→ Optimization i CustomPainter. Returnerar true endast om properties ändrats → skip repaint annars.

---

## Designval

**Q: Varför AnimationController men inte Column?**
→ AnimationController = timing utility (OK helper). Column = layout widget (vad vi ska lära oss bygga).

**Q: Hur skulle du adda ny komponent?**
→ 1) Skapa widget file 2) Define API 3) State + AnimationController 4) CustomPaint + painter 5) GestureDetector 6) Export 7) Tests 8) Docs.

**Q: Vad är limitations?**
→ Performance (custom paint slower), Text (använder TextPainter), Accessibility (basic), Platform styles (samma överallt).

**Q: Förbättringar om mer tid?**
→ Fler komponenter (dropdown, modal, tabs), grid layout, physics animations, theme system, golden tests.

---

## Testing

**Q: Varför widget tests?**
→ UI components → widget tests är rätt tool. Testar rendering + interaction + animation. Flutter recommended approach.

**Q: Hur testar du animationer?**
→ tester.tap() → tester.pumpAndSettle(Duration(milliseconds: 200)) → expect callback triggered.

**Q: Vad är svårt att testa?**
→ Canvas calls (test indirectly), gestures (behöver coordinates), visual appearance (behöver golden tests).

**Q: Hur många tests?**
→ 10 test files, 47+ test cases, covers alla komponenter.

---

## Flutter Concepts

**Q: Rendering pipeline?**
→ Widget tree (config) → Element tree (lifecycle) → Render tree (layout/paint). setState() → build() → diff → update RenderObjects → layout → paint → screen.

**Q: State management approach?**
→ StatefulWidget + setState() för component-local state. Enkelt och fungerar för detta scope.

**Q: Varför Flutter vs React Native?**
→ Flutter ger Canvas access för custom rendering. React Native använder native components (svårare att customize fully). Dart är typed (less bugs).

---

## Getting Started Guide

**Q: Vad täcker din guide?**
→ 1) Installation/setup 2) Layout (Container, Column, Row, Stack) 3) Interaktion (setState, callbacks) 4) Navigering (Navigator, routes).

**Q: Vem är target audience?**
→ Programmerare nya till Flutter (inte complete beginners). Förutsätter programming kunskap men inte Flutter specifikt.

**Q: Hur skiljer sig från Flutter docs?**
→ Flutter docs: comprehensive, reference-style, för alla. Min guide: focused på essentials, tutorial-style, för programmerare, Swenglish.

---

## Betyg 5 Specifikt

**Q: Uppfyller du alla krav?**
→ Ja! Grundkrav: 6 UI + 3 layout från primitives . Betyg 5: Getting Started guide  + UI Testing .

**Q: Visa getting started guiden.**
→ *Öppna FLUTTER_GETTING_STARTED_GUIDE.md* "Här täcker jag installation, layout med exempel, state management, och navigation."

**Q: Visa UI tests.**
→ *cd project/primitive_ui && flutter test* "47+ tests för alla komponenter. Täcker rendering, interaction, animationer."

---

## Personlig Reflektion

**Q: Vad har du lärt dig?**
→ 1) Hur Canvas API fungerar 2) Layout protocol (constraints down, sizes up) 3) setState() patterns 4) Testing strategies 5) API design för reusable components.

**Q: Biggest takeaway?**
→ High-level widgets gör MYCKET arbete. Att bygga dem själv ger appreciation för framework complexity.

**Q: Svåraste delen?**
→ VStack intrinsic sizing (layout bugs svåra att debug), Canvas learning curve initialt, animation state management.

**Q: Skulle du göra något annorlunda?**
→ Start med testing earlier (TDD), plan API design better upfront (less refactoring), document as I go (inte all at end).

---

## Demo Specifikt

**Q: Visa mig en komponent.**
→ *Kör demo app* "Här är PrimitiveCard. *Öppna primitive_card.dart* Canvas.drawShadow för elevation, drawRRect för shape."

**Q: Hur testar du denna komponenten?**
→ *Öppna primitive_card_test.dart* "Widget test: pumpWidget → verify renders → change properties → pumpAndSettle → verify animation."

**Q: Hur använder någon ditt bibliotek?**
→ *Öppna primitive_demo/pubspec.yaml* "Add dependency. *Öppna main.dart* Import package. Use components: PrimitiveCard(child: ...)."

---

## Edge Cases

**Q: Vad händer om child size ändras i VStack?**
→ Flutter detekterar detta → parent's performLayout() körs igen → recalculate positions → repaint. Framework hanterar automatiskt.

**Q: Performance med många componenter?**
→ shouldRepaint() optimization, const constructors, RepaintBoundary. Kan mäta med Flutter DevTools performance overlay.

**Q: RTL text support?**
→ HStack använder Directionality.of(context) för text direction. Automatic i Flutter.

**Q: Accessibility?**
→ Semantics widgets för screen readers. Roles (button, switch), states (checked, values), actions (tap, increase). Basic implementation finns.

---

## Jämförelser

**Q: Flutter vs Native (Swift/Kotlin)?**
→ Native: bäst performance, men måste bygga twice. Flutter: en codebase, near-native performance, snabbare development.

**Q: Ditt bibliotek vs Material widgets?**
→ Material: production-ready, tested, optimized, follows platform guidelines. Mitt: educational, custom från grunden, samma look överallt.

**Q: CustomPaint vs Composition?**
→ CustomPaint: manual rendering, full control, potentially slower. Composition (Container, Column): optimized, easy, less control.

---

## Projekt Management

**Q: Hur lång tid tog projektet?**
→ ~90 timmar totalt: Research (10h) + Components (40h) + Demo (8h) + Testing (12h) + Docs (20h).

**Q: Hur planerade du?**
→ 1) Research phase 2) Prototype (PrimitiveCard först) 3) Implementation (övriga komponenter) 4) Testing 5) Documentation 6) Polish.

**Q: Tools använda?**
→ VS Code + Flutter extensions, Git version control, Flutter DevTools för debugging, Markdown för docs.

---

## Snabba Tekniska Facts

**Allowed primitives:**
- CustomPaint, Canvas, Paint
- GestureDetector, GestureRecognizer
- Custom RenderBox
- AnimationController (timing only)
- TextPainter (for text rendering)

**Forbidden:**
- Column, Row, Stack, Positioned
- Container (i component code)
- Material/Cupertino widgets
- Pre-built interactive widgets

**Project structure:**
```
project/
  primitive_ui/        # SDK package
    lib/src/components/  # 9 component files
    test/               # 10 test files
  primitive_demo/      # Demo app
    lib/main.dart      # Demo code
```

**Test command:**
```bash
cd project/primitive_ui
flutter test
```

**Demo command:**
```bash
cd project/primitive_demo
flutter run -d chrome
```

---

**Print denna sida som quick reference! **
