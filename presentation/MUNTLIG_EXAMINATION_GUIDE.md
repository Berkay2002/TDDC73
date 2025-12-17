# Muntlig Examination Guide - Primitive UI

##  Översikt

**Kurs:** TDDC73 - Interaktionsprogrammering  
**Projekt:** Primitive UI Library  
**Målbetyg:** Betyg 5  
**Format:** Zoom/online presentation  
**Tid:** ~15-20 minuter + frågor

---

##  Betyg 5 Requirements Checklist

### Grundkrav (Betyg 3):
- [x] **2 UI Komponenter:** Button, Input, Card, ToggleSwitch, Slider, CircularProgress (6 st!)
- [x] **2 Layout Komponenter:** VStack, HStack, ZStack (3 st!)
- [x] **Bygg från primitiver:** Endast CustomPaint, Canvas, GestureDetector
- [x] **Demo application:** `primitive_demo` app visar alla komponenter
- [x] **SDK struktur:** Återanvändbart package med tydlig API

### Extra för Betyg 4:
- [x] **Getting Started Guide:** Se `FLUTTER_GETTING_STARTED_GUIDE.md`
- [x] **ELLER UI Testing:** Se `project/primitive_ui/test/`

### Extra för Betyg 5 (BÅDA krävs):
- [x] **Getting Started Guide för Flutter:**  Klar
- [x] **UI Testing:**  10 test files, alla komponenter testade

---

##  Presentations-Struktur (15-20 min)

### Del 1: Introduktion (2 min)
**Vad du säger:**
```
"Hej! Jag har byggt Primitive UI - ett Flutter GUI-bibliotek som är byggt 
helt från grunden med endast primitiva komponenter. Istället för att använda 
färdiga widgets som Column, Row, Card eller Switch, har jag implementerat allt 
själv med CustomPaint, Canvas och GestureDetector.

Målet har varit att förstå hur Flutter's rendering engine fungerar 'under huven' 
och bygga ett återanvändbart SDK."
```

**Visa:** Din README.md i `primitive_ui/`

---

### Del 2: Arkitektur & Design (3 min)

**Vad du säger:**
```
"Biblioteket består av 6 UI-komponenter och 3 layout-komponenter.

UI Components:
- PrimitiveButton: Knapp med olika variants (primary, destructive, outline, etc)
- PrimitiveInput: Text input med filled/outline/flushed variants
- PrimitiveCard: Container med shadow och border radius
- PrimitiveToggleSwitch: Animerad switch
- PrimitiveSlider: Drag slider
- PrimitiveCircularProgress: Loading indicator

Layout Components:
- VStack: Vertical layout, som Column men custom-byggd
- HStack: Horizontal layout, som Row men custom-byggd  
- ZStack: Layering/stacking, som Stack men custom-byggd

Allt är byggt med ENDAST dessa primitives:
- CustomPaint & Canvas för all rendering
- GestureDetector för input
- Custom RenderBox för layout logic
- AnimationController för smooth animationer
```

**Visa:** 
- `primitive_ui/lib/src/components/` strukturen
- Öppna en component file (t.ex. `primitive_card.dart`) och visa CustomPaint usage

---

### Del 3: Live Demo (5-7 min)

**Kör demo appen:**
```bash
cd project/primitive_demo
flutter run -d chrome  # eller -d windows
```

**Gå igenom varje component interaktivt:**

1. **PrimitiveCard:** "Här ser ni olika elevation levels och border radius. Allt ritat med Canvas."
2. **PrimitiveButton:** "Olika variants - primary, destructive, outline, ghost. Hover och press states."
3. **PrimitiveInput:** "Text input med placeholder, focus states, error states."
4. **PrimitiveToggleSwitch:** "Toggla några switches, notera smooth 200ms animation."
5. **PrimitiveSlider:** "Drag för att ändra värde, implicit animation."
6. **VStack/HStack:** "Layout komponenter med spacing och alignment options."
7. **ZStack:** "Layering - notera badge overlay exemplet."

**Poängtera:**
- "Inga färdiga Material/Cupertino widgets används"
- "All rendering är manual med Canvas API"
- "Layout calculations är custom RenderBox implementations"

---

### Del 4: Teknisk Deep-Dive (3-4 min)

**Välj EN komponent att visa i detalj. Rekommendation: PrimitiveCard**

**Öppna:** `primitive_ui/lib/src/components/primitive_card.dart`

**Förklara:**
```
"Låt mig visa hur PrimitiveCard fungerar internt.

1. CustomPaint Widget: Vi använder CustomPaint för att få tillgång till Canvas
2. CustomPainter: _CardPainter implementerar paint() metoden
3. Canvas API:
   - drawShadow() för elevation effekten
   - drawRRect() för rounded corners
   - Paint objects för färger och styles
4. RenderShiftedBox: För padding och layout av child
5. TweenAnimationBuilder: För smooth transitions när properties ändras

Så när du sätter elevation: 4.0, renderas en shadow manuellt med Canvas,
istället för att använda Material's Card widget."
```

**Visa kod:**
```dart
void paint(Canvas canvas, Size size) {
  final rect = Offset.zero & size;
  final rrect = RRect.fromRectAndRadius(rect, Radius.circular(borderRadius));
  
  // Manual shadow rendering
  canvas.drawShadow(Path()..addRRect(rrect), Colors.black, elevation, false);
  
  // Manual background drawing
  canvas.drawRRect(rrect, Paint()..color = color);
}
```

---

### Del 5: UI Testing (3 min)

**Förklara testing approach:**
```
"För betyg 5 krävs UI testing. Jag har skrivit comprehensive tests för alla 
komponenter med Flutter's widget testing framework.

Låt mig visa toggle switch tests som exempel."
```

**Öppna:** `primitive_ui/test/primitive_toggle_switch_test.dart`

**Kör tests:**
```bash
cd project/primitive_ui
flutter test
```

**Förklara vad testerna gör:**
```
"Mina tester täcker:
1. Rendering: Att komponenten renderas korrekt i on/off states
2. Interaction: Att tap callbacks triggas med rätt värden
3. Animation: Att 200ms animation körs smoothly
4. Edge cases: Rapid taps, state persistence
5. Customization: Custom colors och dimensions

Totalt 10 test files med full coverage av alla komponenter."
```

**Visa test output:**
```
00:02 +47: All tests passed!
```

---

### Del 6: Getting Started Guide (2 min)

**Förklara:**
```
"För betyg 5 krävs också en Getting Started guide. Jag har skrivit en komplett 
guide för Flutter som täcker:

1. Layout: Hur man bygger UI med widgets (Column, Row, Container)
2. Interaktion: Event handlers och callbacks
3. Navigering: Navigator API för att byta mellan screens

Guiden vänder sig till programmerare som inte använt Flutter tidigare."
```

**Visa:** `FLUTTER_GETTING_STARTED_GUIDE.md`

**Snabbt scroll igenom:**
- Installation section
- Layout examples med kod
- State management med StatefulWidget
- Navigation examples

---

### Del 7: Sammanfattning & Takeaways (1 min)

**Avsluta:**
```
"Sammanfattning:
- Byggt 9 komponenter från grunden (6 UI + 3 layout)
- Använt endast CustomPaint, Canvas, GestureDetector - inga högre widgets
- Comprehensive UI testing med Flutter widget tests
- Getting Started guide för Flutter
- Fullt fungerande demo app som showcasar allt

Det här projektet har gett mig djup förståelse för hur Flutter's rendering 
pipeline fungerar - från widgets till render objects till pixels på skärmen."
```

---

##  Förväntade Frågor & Svar

### Fråga 1: "Varför använde du CustomPaint istället för Canvas direkt?"
**Svar:**
```
"CustomPaint är ett Widget som integrerar med Flutter's widget tree. Den ger 
oss tillgång till Canvas i paint() metoden. Vi kan inte använda Canvas direkt 
eftersom den måste kopplas till en RenderObject. CustomPaint är den lägsta 
nivån där vi kan komma åt Canvas API:t medan vi fortfarande är i widget layer."
```

### Fråga 2: "Hur fungerar din layout logic i VStack?"
**Svar:**
```
"VStack använder en custom RenderBox som extends ContainerRenderObjectMixin. 
I performLayout():
1. Iterera över alla children
2. Anropa child.layout() med constraints
3. Beräkna total höjd (sum av child heights + spacing)
4. Positionera varje child vertikalt med offset
5. Applicera alignment (start/center/end/stretch)

Det är samma algoritm som Column använder, men jag har implementerat den själv."
```

**Visa kod:** `primitive_ui/lib/src/components/v_stack.dart` - `performLayout()` metoden

### Fråga 3: "Hur hanterar du input i PrimitiveButton?"
**Svar:**
```
"Jag använder GestureDetector som wrapper:
- onTapDown: Sätter _isPressed = true, trigger rebuild
- onTapUp: Sätter _isPressed = false
- onTapCancel: Reset state om tap avbryts
- onTap: Anropar användarens onPressed callback

State changes triggrar setState() vilket renderar om knappen med pressed styling."
```

### Fråga 4: "Varför tillåter du AnimationController men inte Column?"
**Svar:**
```
"Syftet med projektet är att förstå RENDERING och LAYOUT från grunden. 
AnimationController är en timing utility - den genererar värden över tid men 
ritar ingenting.

Att implementera egen animation timing (easing curves, frame scheduling) hade 
varit en distraction från core learning objectives. Men Column är en layout 
widget - det är exakt vad vi ska lära oss att bygga själva."
```

### Fråga 5: "Hur kan någon använda ditt bibliotek i sin app?"
**Svar:**
```
"Biblioteket är strukturerat som ett standard Dart package:

1. Lägg till dependency i pubspec.yaml:
   dependencies:
     primitive_ui:
       path: ../primitive_ui

2. Import:
   import 'package:primitive_ui/primitive_ui.dart';

3. Använd components:
   PrimitiveCard(
     child: Text('Hello'),
   )

Allt exporteras från en enda barrel file för clean API."
```

### Fråga 6: "Vad är begränsningarna med din implementation?"
**Svar:**
```
"Några trade-offs:
1. Performance: Custom painting kan vara långsammare än compositing
2. Text: Jag använder Flutters TextPainter - att implementera text rendering 
   från scratch är extremely complex
3. Accessibility: Grundläggande semantics finns men kunde vara mer omfattande
4. Platform specifics: Min rendering är agnostic - jag renderar inte native 
   iOS/Android styles

Men poängen var pedagogisk - att lära sig principles, inte att bygga 
production-ready library."
```

### Fråga 7: "Hur testar du att animationer fungerar?"
**Svar:**
```
"Med Flutter's widget testing:
1. Pump widget till initial state
2. Trigger interaction (tap)
3. pump() - advance 1 frame
4. pumpAndSettle() - kör hela animationen till slut
5. Assert att final state är korrekt

För toggle switch:
- Tap switch
- pumpAndSettle(Duration(milliseconds: 200))
- Verify callback called med rätt value
```

### Fråga 8: "Förklara din Getting Started guide struktur"
**Svar:**
```
"Guiden följer progression:
1. Installation & Setup: flutter doctor, create project
2. Layout Basics: Container, Column, Row med exempel
3. Interaktion: StatefulWidget, setState, callbacks
4. Navigation: Navigator.push, named routes

Varje section har:
- Conceptual explanation
- Code exempel
- Output förklaring
- Common pitfalls

Riktar sig till developers som kan programmera men är nya till Flutter."
```

---

##  Pre-Presentation Technical Checklist

### 1. Testa att allt körs
```bash
# Test library
cd project/primitive_ui
flutter test
# Should pass all tests

# Test demo app
cd ../primitive_demo
flutter pub get
flutter run -d chrome
# Should launch without errors
```

### 2. Ha dessa filer öppna i VS Code:
- `project/primitive_ui/README.md` (overview)
- `project/primitive_ui/lib/src/components/primitive_card.dart` (code example)
- `project/primitive_ui/test/primitive_toggle_switch_test.dart` (testing example)
- `FLUTTER_GETTING_STARTED_GUIDE.md` (getting started)
- `project/primitive_demo/lib/main.dart` (demo code)

### 3. Ha dessa terminals redo:
- Terminal 1: `cd project/primitive_demo` (för att köra demo)
- Terminal 2: `cd project/primitive_ui` (för att köra tests)

### 4. Kolla internet connection
- Demo appen kan behöva hämta assets
- Om demo körs på web, behövs internet

### 5. Screen sharing tips
- Öka font size i VS Code (Ctrl+Plus)
- Stäng notifications
- Stäng andra applications
- Testa ljudet i Zoom före

---

## ⏱ Timing Breakdown

| Del | Innehåll | Tid |
|-----|----------|-----|
| 1 | Introduktion | 2 min |
| 2 | Arkitektur | 3 min |
| 3 | Live Demo | 6 min |
| 4 | Code Deep-Dive | 4 min |
| 5 | UI Testing | 3 min |
| 6 | Getting Started | 2 min |
| 7 | Sammanfattning | 1 min |
| **Total** | | **21 min** |
| Frågor | | +10-15 min |

---

##  Presentations-Tips

### Gör:
 Börja med high-level overview  
 Visa live demo tidigt (engaging)  
 Förklara WHY, inte bara WHAT  
 Använd concrete examples  
 Var prepared för tekniska frågor  
 Ha backup plan om demo kraschar  

### Gör INTE:
 Läs kod rad-för-rad  
 Dwell för länge på implementation details  
 Anta att examinatorn känner till Flutter  
 Glöm att förklara varför projektet är relevant  
 Stressa - ta det lugnt  

---

##  Backup Plan

Om något går fel under demo:

### Demo appen kraschar:
- Visa pre-recorded video/screenshots (ta några innan!)
- Eller: Förklara med README.md screenshots

### Internet dör:
- Demo kan köra locally (inte web)
- Ha screenshots sparade offline

### Zoom freezar:
- Ha presentation script printed
- Fortsätt förklara verbal

### Kod öppnas inte:
- Ha GitHub repo öppet i browser som backup
- Kan visa kod där

---

##  Post-Presentation Notes

Efter din presentation, notera:
- Vilka frågor ställdes?
- Vad var examinatorn mest intresserad av?
- Vad gick bra? Vad kunde varit bättre?

Detta hjälper andra studenter! 

---

**Lycka till! You got this! **
