# Pre-Examination Checklist
**Allt du behöver kolla innan din muntliga examination**

---

##  24 Timmar Före Examen

### Teknisk Setup

#### Flutter & Dependencies
```bash
# Verify Flutter installation
flutter doctor
# All checkmarks should be green (or at least Flutter + one platform)

# Update Flutter if needed
flutter upgrade

# Verify projects work
cd /home/berkay-orhan/Developer/university/TDDC73/project/primitive_demo
flutter pub get
flutter run -d chrome
# Should launch without errors - test navigation and interactions

cd ../primitive_ui
flutter pub get
flutter test
# Should show: 00:02 +47: All tests passed!
```

- [ ] Flutter doctor shows no critical issues
- [ ] Demo app launches successfully
- [ ] All UI components work in demo
- [ ] All tests pass
- [ ] No compile errors or warnings

#### Browser & Platform
```bash
# Test Chrome (recommended for demo)
google-chrome --version
# Should show Chrome 120+ or similar

# Alternative: Test Windows desktop
flutter devices
# Should list "windows" if on Windows

# Choose your demo platform
export DEMO_PLATFORM="chrome"  # eller "windows"
```

- [ ] Chrome is installed and working (if using web)
- [ ] OR Windows desktop environment works (if using desktop)
- [ ] Can launch and interact with demo on chosen platform

---

### Documentation Review

#### Required Files Exist
```bash
cd /home/berkay-orhan/Developer/university/TDDC73

# Check all required files
ls -la MUNTLIG_EXAMINATION_GUIDE.md
ls -la FLUTTER_GETTING_STARTED_GUIDE.md
ls -la DEMO_KÖRNINGS_GUIDE.md
ls -la VANLIGA_FRÅGOR_OCH_SVAR.md
ls -la project/primitive_ui/README.md
ls -la project/primitive_demo/README.md
```

- [ ] Muntlig examination guide finns
- [ ] Flutter getting started guide finns
- [ ] Demo körnings guide finns
- [ ] Vanliga frågor & svar finns
- [ ] Primitive UI README finns
- [ ] Primitive demo README finns

#### Read & Understand
- [ ] Läst igenom MUNTLIG_EXAMINATION_GUIDE.md
- [ ] Förstår presentation structure (7 delar, 21 min)
- [ ] Läst VANLIGA_FRÅGOR_OCH_SVAR.md
- [ ] Kan förklara varje component's implementation
- [ ] Kan förklara testing approach
- [ ] Kan förklara getting started guide struktur

---

### Presentation Materials

#### Visual Aids Ready
- [ ] Screenshots av demo app tagna (backup om demo crashar)
- [ ] Code examples identified (vilka files att öppna)
- [ ] README.md open i browser (backup för visuals)

#### Files to Open in VS Code
Create this list now:
1. `project/primitive_ui/README.md` - Overview
2. `project/primitive_ui/lib/src/components/primitive_card.dart` - Code example
3. `project/primitive_ui/lib/src/components/primitive_toggle_switch.dart` - Animation example
4. `project/primitive_ui/lib/src/components/v_stack.dart` - Layout example
5. `project/primitive_ui/test/primitive_toggle_switch_test.dart` - Test example
6. `FLUTTER_GETTING_STARTED_GUIDE.md` - Getting Started
7. `project/primitive_demo/lib/main.dart` - Demo app code

```bash
# Open all in VS Code
cd /home/berkay-orhan/Developer/university/TDDC73
code project/primitive_ui/README.md
code project/primitive_ui/lib/src/components/primitive_card.dart
code project/primitive_ui/lib/src/components/primitive_toggle_switch.dart
code project/primitive_ui/lib/src/components/v_stack.dart
code project/primitive_ui/test/primitive_toggle_switch_test.dart
code FLUTTER_GETTING_STARTED_GUIDE.md
code project/primitive_demo/lib/main.dart
```

- [ ] All 7 files opened i VS Code
- [ ] Font size increased (Ctrl+Plus flera gånger)
- [ ] Code is formatted and readable

---

##  2 Timmar Före Examen

### Environment Setup

#### Clean Your Desktop
- [ ] Close all unnecessary applications
- [ ] Close personal browser tabs (Facebook, YouTube, etc)
- [ ] Close Slack, Discord, messaging apps
- [ ] Close music players
- [ ] Only keep: VS Code, Terminal, Browser (for demo)

#### Zoom Setup
```bash
# Test Zoom ahead of time
# Join a test meeting if possible
```

- [ ] Zoom installed and working
- [ ] Camera works (if examiner wants to see you)
- [ ] Microphone works and is clear
- [ ] Screen sharing works
- [ ] Tested screen share med examiner eller vän

#### Notifications & Distractions
- [ ] Enable Do Not Disturb mode
- [ ] Disable desktop notifications
- [ ] Phone on silent and away
- [ ] Email client closed
- [ ] Calendar notifications disabled

---

### Terminal Preparation

#### Terminal 1: Demo App
```bash
# Open Terminal 1
cd /home/berkay-orhan/Developer/university/TDDC73/project/primitive_demo

# DON'T start app yet, just navigate there
pwd
# Should show: /home/berkay-orhan/Developer/university/TDDC73/project/primitive_demo

# When ready to demo, run:
# flutter run -d chrome
```

- [ ] Terminal 1 open at `project/primitive_demo`
- [ ] Font size increased (Ctrl+Shift+Plus)
- [ ] Command ready but NOT executed yet

#### Terminal 2: Tests
```bash
# Open Terminal 2
cd /home/berkay-orhan/Developer/university/TDDC73/project/primitive_ui

# DON'T run tests yet
pwd
# Should show: /home/berkay-orhan/Developer/university/TDDC73/project/primitive_ui

# When ready to show tests, run:
# flutter test
```

- [ ] Terminal 2 open at `project/primitive_ui`
- [ ] Font size increased
- [ ] Command ready but NOT executed yet

---

### Final Tech Check

#### One More Test Run
```bash
# Terminal 1
cd /home/berkay-orhan/Developer/university/TDDC73/project/primitive_demo
flutter run -d chrome
# Let it load completely
# Click around
# Verify all components work
# Press 'q' to quit

# Terminal 2
cd /home/berkay-orhan/Developer/university/TDDC73/project/primitive_ui
flutter test
# Wait for all tests to pass
# Should see: 00:02 +47: All tests passed!
```

- [ ] Demo app launched successfully
- [ ] Tested all major features (buttons, toggles, cards, etc)
- [ ] No errors in console
- [ ] Tests all passed
- [ ] No warnings or deprecations

#### Backup Plan Ready
- [ ] Screenshots saved to `/home/berkay-orhan/Desktop/demo-backup/`
- [ ] README.md bookmarked in browser
- [ ] GitHub repo URL ready: https://github.com/yourusername/primitive-ui (if applicable)

---

##  30 Minuter Före Examen

### Mental Preparation

#### Review Key Points
- [ ] Can explain what Primitive UI is (30 seconds)
- [ ] Can list all 9 components (6 UI + 3 layout)
- [ ] Remember primitives used: CustomPaint, Canvas, GestureDetector
- [ ] Know why AnimationController is OK but Column isn't
- [ ] Can explain one component in detail (PrimitiveCard recommended)

#### Practice Introduction
Say this out loud:
```
"Hej! Jag har byggt Primitive UI - ett Flutter GUI-bibliotek som är byggt 
helt från grunden med endast primitiva komponenter. Istället för att använda 
färdiga widgets som Column, Row, Card eller Switch, har jag implementerat allt 
själv med CustomPaint, Canvas och GestureDetector. Biblioteket består av 
6 UI-komponenter och 3 layout-komponenter."
```

- [ ] Practiced introduction 3 times
- [ ] Sounds natural and confident
- [ ] Under 30 seconds

---

### Physical Setup

#### Ergonomics
- [ ] Chair adjusted to comfortable height
- [ ] Screen at eye level
- [ ] Good lighting (not too dark, not backlit)
- [ ] Water bottle nearby
- [ ] Comfortable clothes
- [ ] Room temperature OK

#### Internet & Power
- [ ] Internet connection stable (test: `ping google.com`)
- [ ] Laptop plugged in (don't rely on battery)
- [ ] Backup internet available (phone hotspot if needed)

---

##  5 Minuter Fore Examen

### Final Checklist

#### Screen
- [ ] Only VS Code, Terminal, and Browser visible
- [ ] All tabs in browser are relevant (no Reddit, Twitter, etc)
- [ ] Desktop clean (no embarrassing files visible)
- [ ] Font sizes increased everywhere (VS Code, Terminal, Browser)

#### Audio/Video
- [ ] Microphone tested (record and playback)
- [ ] Camera tested (if needed)
- [ ] Background is neutral and professional
- [ ] Good lighting on your face

#### Documents Open
- [ ] MUNTLIG_EXAMINATION_GUIDE.md open i en tab
- [ ] VANLIGA_FRÅGOR_OCH_SVAR.md open i en tab
- [ ] README.md från primitive_ui open i browser (as backup)

#### Terminals Ready
- [ ] Terminal 1: `cd project/primitive_demo`
- [ ] Terminal 2: `cd project/primitive_ui`
- [ ] Both terminals have large font
- [ ] Both terminals are visible (split screen or tabbed)

#### VS Code Ready
- [ ] 7 key files open (see list above)
- [ ] Font size: 16-18pt minimum
- [ ] Color theme: High contrast (for visibility)
- [ ] Sidebar hidden (Ctrl+B) for more code space

---

##  Under Examen

### Do's
 Speak clearly and slowly  
 Point with mouse cursor when explaining code  
 Ask examiner to repeat if you don't understand question  
 Say "Let me show you" before switching windows  
 Pause after each section to ask "Några frågor?"  
 Admit if you don't know something  
 Explain WHY, not just WHAT  

### Don'ts
 Rush through presentation  
 Read code line-by-line without explanation  
 Assume examiner knows Flutter  
 Get defensive about limitations  
 Panic if demo crashes (use backup plan)  
 Use technical jargon without explanation  

---

##  Emergency Protocols

### Demo App Crashes
1. Press `R` for hot restart (in terminal)
2. If that fails: `q` to quit, then `flutter run -d chrome` again
3. If that fails: Show screenshots from backup folder
4. Continue presentation without demo (use README screenshots)

### Tests Fail
1. Run specific test file: `flutter test test/primitive_toggle_switch_test.dart`
2. If that fails: Show screenshot of previous successful test run
3. Explain what tests SHOULD do (you know this!)

### Zoom Connection Issues
1. Check internet: `ping google.com`
2. Restart Zoom
3. Use phone as hotspot
4. Call examiner via phone if needed

### Screen Sharing Stops
1. Stop and restart screen share
2. Ask examiner: "Ser du min skärm nu?"
3. Continue explaining verbally while fixing

### Can't Find File
1. Use Ctrl+P in VS Code (Quick Open)
2. Type filename
3. OR show in GitHub if uploaded

### Mind Goes Blank
1. Take deep breath
2. Look at MUNTLIG_EXAMINATION_GUIDE.md
3. Say: "Låt mig samla mina tankar en sekund..."
4. Continue from checklist

---

##  After Examination

### Immediate
- [ ] Thank examiner
- [ ] Ask about next steps
- [ ] Ask when to expect results
- [ ] Note any feedback given

### Within 24 Hours
- [ ] Write down what questions were asked
- [ ] Note what went well
- [ ] Note what could be improved
- [ ] Share experience with classmates (if allowed)

### For Future Reference
- [ ] Save all presentation materials
- [ ] Commit final version to Git
- [ ] Update README if examiner suggested improvements
- [ ] Add to portfolio if proud of work

---

##  Grading Rubric Review

### Betyg 3 Requirements (Grundkrav)
- [x] 2+ UI komponenter implementerade (har 6!)
- [x] 2+ Layout komponenter implementerade (har 3!)
- [x] Byggt från primitiver (CustomPaint, Canvas, GestureDetector)
- [x] Demo application som visar användning
- [x] Tydlig skillnad mellan SDK och demo app
- [x] Icke-triviala komponenter
- [x] Effektiv kod med bra konventioner
- [x] Godtagbar kommentering

### Betyg 4 Requirements (EN av dessa)
- [x] Getting Started guide för Flutter 
- [x] UI Testing för komponenter 

### Betyg 5 Requirements (BÅDA krävs)
- [x] Getting Started guide för Flutter 
- [x] UI Testing för komponenter 

**Status: REDO FÖR BETYG 5** 

---

##  Confidence Boosters

### You Have:
 9 fully implemented components (6 UI + 3 layout)  
 Comprehensive README with API docs  
 Working demo application  
 47+ passing widget tests  
 Complete Getting Started guide  
 Clean, well-documented code  
 Understanding of Flutter rendering pipeline  
 Prepared answers for common questions  

### You Are Ready To:
 Explain what primitives you used and why  
 Demonstrate all components live  
 Show test execution  
 Discuss implementation details  
 Answer technical questions  
 Explain design decisions  
 Discuss limitations honestly  

---

##  Final Reminders

**Time Management:**
- Introduction: 2 min
- Architecture: 3 min
- Live Demo: 6 min
- Code Deep-Dive: 4 min
- Testing: 3 min
- Getting Started: 2 min
- Summary: 1 min
- **Total: 21 minutes**

**Key Messages:**
1. "Byggt från PRIMITIVER - CustomPaint, Canvas, GestureDetector"
2. "9 komponenter - mer än required 4"
3. "Comprehensive testing - alla komponenter testade"
4. "Full documentation - README + Getting Started guide"
5. "Educational focus - lära hur Flutter fungerar under huven"

**If Nervous:**
- You've done the work
- You understand your code
- You can answer questions
- Examiner wants you to succeed
- It's OK to not know everything
- Breathe and take your time

---

##  You Got This! 

Du har gjort allt jobb. Projektet är strong. Documentation är comprehensive. 
Tests passar. Du är redo.

Lycka till! 

---

**Version:** 1.0  
**Created:** 2024-12-17  
**Last Updated:** Right before your exam  
**Status:** READY TO GO 
