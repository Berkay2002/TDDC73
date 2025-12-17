# START HERE - Oral Exam Preparation
**Din guide till att förbereda för den muntliga examinationen**

---

##  Vad är det här?

Du har byggt Primitive UI projektet och ska nu presentera det i en muntlig examination via Zoom. Det här är din starting point för att förbereda.

---

##  Alla Presentation-Dokument

Jag har skapat dessa guides för dig:

### 1. **MUNTLIG_EXAMINATION_GUIDE.md**  VIKTIGAST
**Vad:** Komplett presentation guide  
**Innehåller:**
- Presentation struktur (7 delar, 21 min)
- Vad du ska säga i varje del
- Live demo flow
- Förväntade frågor med svar
- Technical checklist
- Backup plans

**Läs detta FÖRST!**

---

### 2. **PRE_EXAMINATION_CHECKLIST.md**  VIKTIGT
**Vad:** Step-by-step checklist  
**Innehåller:**
- 24 timmar före: Technical setup
- 2 timmar före: Environment setup
- 30 min före: Mental prep
- 5 min före: Final checks
- Under exam: Do's and Don'ts
- Emergency protocols

**Gå igenom detta dagen innan!**

---

### 3. **DEMO_KÖRNINGS_GUIDE.md**
**Vad:** Hur man kör demos  
**Innehåller:**
- Quick start commands
- Device options
- Demo flow (exakt vad du ska klicka)
- Troubleshooting
- Keyboard shortcuts

**Ha denna öppen under demo!**

---

### 4. **VANLIGA_FRÅGOR_OCH_SVAR.md**
**Vad:** Q&A preparation  
**Innehåller:**
- 20 vanliga frågor med detaljerade svar
- Tekniska frågor (CustomPaint, layout, testing)
- Conceptual frågor (rendering pipeline, Flutter vs React Native)
- Getting Started guide frågor
- Testing frågor

**Läs igenom detta dagen innan!**

---

### 5. **FLUTTER_GETTING_STARTED_GUIDE.md** (BETYG 5 KRAV)
**Vad:** Din Getting Started guide för Flutter  
**Innehåller:**
- Installation & setup
- Layout basics (Container, Column, Row, Stack)
- Interaktion (StatefulWidget, setState, callbacks)
- Navigering (Navigator, routes, passing data)
- Next steps (async, HTTP, state management)

**Detta är required för betyg 5!**

---

##  Snabb Start - Vad ska du göra NU?

### Steg 1: Verifiera att allt fungerar (10 min)

```bash
# Terminal 1: Test demo app
cd /home/berkay-orhan/Developer/university/TDDC73/project/primitive_demo
flutter pub get
flutter run -d chrome
# Kolla att app:en laddar och alla komponenter fungerar
# Tryck 'q' för att quit

# Terminal 2: Test UI tests
cd /home/berkay-orhan/Developer/university/TDDC73/project/primitive_ui
flutter pub get
flutter test
# Should see: 00:02 +47: All tests passed!
```

**Checklist:**
- [ ] Demo app startar utan errors
- [ ] Alla UI komponenter syns och fungerar
- [ ] Alla tests passerar
- [ ] Ingen compile warnings

---

### Steg 2: Läs MUNTLIG_EXAMINATION_GUIDE.md (30 min)

```bash
# Öppna i din editor
code MUNTLIG_EXAMINATION_GUIDE.md
# Eller läs i terminal
cat MUNTLIG_EXAMINATION_GUIDE.md | less
```

**Fokusera på:**
- Presentations-struktur (7 delar)
- Vad du ska säga i introduktionen
- Live demo flow
- Förväntade frågor (Q1-Q8 minst)

---

### Steg 3: Övningskörning (20 min)

**Genomför hela presentationen för dig själv:**

1. Öppna MUNTLIG_EXAMINATION_GUIDE.md
2. Följ presentation structure
3. Kör demo app
4. Förklara högt (som om examiner lyssnar)
5. Kör tests
6. Tima dig själv (ska vara ~20 min)

**Tips:**
- Spela in dig själv (OBS software eller mobil)
- Lyssna på inspelningen
- Notera vad du kan förbättra

---

### Steg 4: Förbered miljön (10 min)

**Öppna dessa filer i VS Code:**
```bash
code project/primitive_ui/README.md
code project/primitive_ui/lib/src/components/primitive_card.dart
code project/primitive_ui/test/primitive_toggle_switch_test.dart
code FLUTTER_GETTING_STARTED_GUIDE.md
```

**Sätt upp terminals:**
- Terminal 1: `cd project/primitive_demo`
- Terminal 2: `cd project/primitive_ui`

**Öka font sizes:**
- VS Code: Ctrl+Plus (flera gånger)
- Terminal: Ctrl+Shift+Plus

---

##  Timeline till Examen

### Dagen före (idag!)

**2-3 timmar:**
- [ ] Läs MUNTLIG_EXAMINATION_GUIDE.md
- [ ] Läs PRE_EXAMINATION_CHECKLIST.md
- [ ] Läs VANLIGA_FRÅGOR_OCH_SVAR.md
- [ ] Gör övningskörning (med timer)
- [ ] Förbered backup screenshots

---

### 2 timmar före examen (imorgon)

**30 minuter:**
- [ ] Gå igenom PRE_EXAMINATION_CHECKLIST.md steg-för-steg
- [ ] Test run demo + tests en sista gång
- [ ] Stäng alla distractions
- [ ] Enable Do Not Disturb
- [ ] Öppna alla relevanta filer

---

### 5 minuter före examen

**Quick check:**
- [ ] Terminals ready
- [ ] VS Code open med rätt files
- [ ] Font sizes OK
- [ ] Microphone tested
- [ ] Screen sharing tested
- [ ] MUNTLIG_EXAMINATION_GUIDE.md open (för reference)

---

##  Betyg 5 Requirements - Summary

Du behöver visa att du har:

###  Betyg 3 (Grund)
- **2+ UI komponenter** → Har 6 
- **2+ Layout komponenter** → Har 3 
- **Byggt från primitiver** → CustomPaint, Canvas, GestureDetector 
- **Demo application** → primitive_demo 
- **Icke-triviala komponenter** → Alla är non-trivial 

###  Betyg 5 (Båda krävs)
- **Getting Started guide** → FLUTTER_GETTING_STARTED_GUIDE.md 
- **UI Testing** → 47+ tests i project/primitive_ui/test/ 

**Du uppfyller ALLA krav!** 

---

##  Viktigaste Poängerna att Kommunicera

När du presenterar, betona dessa:

### 1. Byggt från PRIMITIVES
```
"Jag har INTE använt färdiga widgets som Column, Row, Card, eller Switch.
ALLT är byggt med endast CustomPaint, Canvas och GestureDetector."
```

### 2. Fler komponenter än required
```
"Projektet krävde 2 UI + 2 layout komponenter.
Jag har byggt 6 UI komponenter och 3 layout komponenter - totalt 9 stycken."
```

### 3. Comprehensive testing
```
"För betyg 5 krävs UI testing. Jag har 10 test files med 47+ test cases
som täcker alla komponenter - rendering, interaction, och animations."
```

### 4. Full documentation
```
"Jag har skrivit en Getting Started guide för Flutter som täcker installation,
layout, interaktion och navigering - riktat till programmerare nya till Flutter."
```

### 5. Educational focus
```
"Syftet har varit att förstå hur Flutter fungerar 'under huven' - hur rendering,
layout och event handling faktiskt implementeras."
```

---

##  Quick Reference - Vanliga Frågor

**"Vad är Primitive UI?"**
→ Ett Flutter GUI-bibliotek byggt från grunden med endast CustomPaint, Canvas och GestureDetector.

**"Varför CustomPaint och inte vanliga widgets?"**
→ För att lära mig hur rendering faktiskt fungerar. CustomPaint ger direkt access till Canvas API.

**"Hur fungerar din layout logic?"**
→ Custom RenderBox med performLayout() som manually beräknar constraints och positionerar children.

**"Varför AnimationController men inte Column?"**
→ AnimationController är timing utility, Column är layout widget. Projektet fokuserar på att lära layout/rendering, inte timing algorithms.

**"Hur testar du komponenter?"**
→ Flutter widget tests med testWidgets, pumpWidget, tap, och pumpAndSettle för animations.

**Fler svar: Se VANLIGA_FRÅGOR_OCH_SVAR.md**

---

##  Tekniska Kommandon - Snabbreferens

### Kör Demo
```bash
cd project/primitive_demo
flutter run -d chrome
```

### Kör Tests
```bash
cd project/primitive_ui
flutter test
```

### Fixa "Waiting for another flutter command"
```bash
killall -9 dart
flutter doctor
```

### Öka Font Size
```
VS Code: Ctrl+Plus
Terminal: Ctrl+Shift+Plus
Browser: Ctrl+Plus
```

---

##  Essential Files Location

```
/home/berkay-orhan/Developer/university/TDDC73/
 MUNTLIG_EXAMINATION_GUIDE.md        Main presentation guide
 PRE_EXAMINATION_CHECKLIST.md        Checklist
 DEMO_KÖRNINGS_GUIDE.md              How to run demos
 VANLIGA_FRÅGOR_OCH_SVAR.md          Q&A preparation
 FLUTTER_GETTING_STARTED_GUIDE.md    Getting Started (Grade 5)

 project/
    primitive_ui/                   Main library (SDK)
       lib/src/components/         All components here
       test/                       All tests here
       README.md                   API documentation
   
    primitive_demo/                 Demo application
        lib/main.dart               Demo code
        README.md                   Demo guide
```

---

##  Presentation Flow - Ultra Quick Summary

1. **Intro** (2 min): "Primitive UI är ett Flutter bibliotek byggt från grunden..."
2. **Arkitektur** (3 min): "6 UI + 3 layout komponenter med CustomPaint..."
3. **Live Demo** (6 min): Kör appen, visa alla komponenter interaktivt
4. **Code Deep-Dive** (4 min): Visa primitive_card.dart, förklara Canvas usage
5. **Testing** (3 min): Kör `flutter test`, förklara test approach
6. **Getting Started** (2 min): Visa FLUTTER_GETTING_STARTED_GUIDE.md
7. **Summary** (1 min): "9 komponenter, comprehensive testing, full docs..."

**Total: 21 minuter + Q&A**

---

##  You Got This!

### Du har:
 Byggt 9 komponenter från grunden  
 47+ passing tests  
 Complete documentation  
 Getting Started guide  
 Working demo app  
 Prepared answers för frågor  

### Du är redo att:
 Demonstrera projektet  
 Förklara implementation  
 Svara på tekniska frågor  
 Få betyg 5  

---

##  Emergency Contacts During Prep

Om något inte fungerar tekniskt:

**Flutter issues:**
```bash
flutter doctor -v
flutter clean
flutter pub get
```

**Git issues (om du vill se tidigare version):**
```bash
git log --oneline
git diff HEAD~1
```

**Can't find file:**
```bash
find . -name "*.dart" | grep primitive
```

---

## ⏭ Next Steps

**Right now (15 min):**
1.  Verify demo + tests work
2. → Read MUNTLIG_EXAMINATION_GUIDE.md

**Today (2-3 hours):**
1. → Read all preparation documents
2. → Do practice run
3. → Prepare backup screenshots

**Tomorrow before exam (30 min):**
1. → Follow PRE_EXAMINATION_CHECKLIST.md
2. → Test run one more time
3. → Open all necessary files

**5 min before exam:**
1. → Deep breath
2. → Check MUNTLIG_EXAMINATION_GUIDE.md one last time
3. → Start Zoom
4. → **You're ready! **

---

##  Final Reminder

**The goal:**
Visa att du har byggt ett custom GUI-bibliotek från primitives, förstår hur Flutter fungerar, och kan förklara dina design decisions.

**You already have all of this!**

Det enda som återstår är att PRESENTERA vad du redan byggt.

---

**Börja med: MUNTLIG_EXAMINATION_GUIDE.md**

**Lycka till! **
