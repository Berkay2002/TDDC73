# Demo Körnings-Guide
**Snabb referens för att köra demos under presentationen**

---

##  Quick Start Commands

### Primitive UI Demo (Huvudprojekt)

```bash
# Terminal 1 - Main Demo
cd /home/berkay-orhan/Developer/university/TDDC73/project/primitive_demo
flutter pub get
flutter run -d chrome    # Web (rekommenderat för demo)
# ELLER
flutter run -d windows   # Windows desktop
```

**Vad demoen visar:**
- Alla 6 UI komponenter (Button, Input, Card, Toggle, Slider, Progress)
- Alla 3 layout komponenter (VStack, HStack, ZStack)
- Interaktiva examples med state changes
- Different variants och styles

**Viktiga routes i demoen:**
- `/` - Main demo homepage
- `/slider` - PrimitiveSlider showcase
- `/progress` - PrimitiveCircularProgress
- `/vstack` - VStack flexible demo
- `/hstack` - HStack flex demo
- `/zstack` - ZStack positioned demo
- `/accessibility` - Accessibility features
- `/animations` - Animation examples

---

### UI Tests

```bash
# Terminal 2 - Tests
cd /home/berkay-orhan/Developer/university/TDDC73/project/primitive_ui
flutter test

# Kör specifik test file
flutter test test/primitive_toggle_switch_test.dart

# Verbose output
flutter test --reporter expanded
```

**Expected output:**
```
00:02 +47: All tests passed!
```

**Test files:**
- `primitive_button_test.dart` - Button interaction & variants
- `primitive_input_test.dart` - Input validation & focus
- `primitive_card_test.dart` - Card rendering & animations
- `primitive_toggle_switch_test.dart` - Toggle animations & callbacks
- `primitive_slider_test.dart` - Slider drag & value changes
- `primitive_circular_progress_test.dart` - Progress animations
- `v_stack_test.dart` - Layout calculations
- `h_stack_test.dart` - Layout calculations
- `z_stack_test.dart` - Stacking behavior

---

##  Device Options

### Lista tillgängliga devices

```bash
flutter devices
```

Possible outputs:
```
Chrome (web)        • chrome        • web-javascript • Google Chrome
Windows (desktop)   • windows       • windows-x64    • Microsoft Windows
Linux (desktop)     • linux         • linux-x64      • Ubuntu
```

### Välj specific device

```bash
# Web browser (best för demo - inga dependencies)
flutter run -d chrome

# Windows desktop
flutter run -d windows

# Linux desktop  
flutter run -d linux

# Om du har Android emulator
flutter run -d emulator-5554
```

**Rekommendation:** Chrome är bäst för oral exam eftersom:
- Inga platform-specific dependencies
- Snabb startup
- Screen sharing funkar smooth
- Hot reload fungerar perfekt

---

##  Demo Flow under Presentation

### 1. Start Demo App (0:00)

```bash
cd project/primitive_demo
flutter run -d chrome
```

Vänta tills appen laddar (~10-20 sekunder första gången)

### 2. Navigera genom Componenter (0:30)

**Main Page (`/`):**
- Scrolla och visa overview
- Poängtera dark mode toggle (PrimitiveToggleSwitch)
- Visa olika cards med elevations

**PrimitiveButton (`/button` eller i main page):**
- Klicka på olika button variants
- Hover för att visa hover state
- Disabled state
- Loading state

**PrimitiveInput:**
- Type in fields
- Show placeholder
- Focus states
- Different variants (outline/filled/flushed)

**PrimitiveToggleSwitch:**
- Toggle flera switches
- Poängtera smooth 200ms animation
- Show color customization

**PrimitiveSlider (`/slider`):**
- Drag slider
- Show value updates
- Implicit animations

**Layout Components:**
- VStack: Different alignments (start/center/end/stretch)
- HStack: Spacing examples
- ZStack: Badge overlay example

### 3. Visa Kod (5:00)

Öppna i VS Code:
```
project/primitive_ui/lib/src/components/primitive_card.dart
```

Scroll till `paint()` metoden och förklara Canvas usage.

### 4. Kör Tests (8:00)

```bash
cd project/primitive_ui
flutter test
```

Visa output när alla tests passerar.

---

##  Troubleshooting under Demo

### Problem: "Waiting for another flutter command to release the startup lock"

**Fix:**
```bash
killall -9 dart
# eller
rm -rf /tmp/flutter_tool_state/
flutter doctor
```

### Problem: Demo app kraschar vid start

**Fix:**
```bash
flutter clean
flutter pub get
flutter run -d chrome --verbose
```

### Problem: Hot reload fungerar inte

**Fix:**
- Tryck `R` i terminal (hot restart)
- Eller stäng appen och kör `flutter run` igen

### Problem: Chrome öppnas inte

**Fix:**
```bash
# Kolla att Chrome är installerad
which google-chrome
which chromium-browser

# Sätt environment variable
export CHROME_EXECUTABLE=/usr/bin/google-chrome
flutter run -d chrome
```

### Problem: Tests failar

**Check:**
```bash
# Se vilka tests som failar
flutter test --reporter expanded

# Kör en test file i taget
flutter test test/primitive_toggle_switch_test.dart
```

### Problem: Dependencies saknas

**Fix:**
```bash
cd project/primitive_demo
flutter pub get

cd ../primitive_ui
flutter pub get
```

---

##  Demo Checklist (Kolla innan presentation)

### 5 minuter före:

- [ ] Stäng alla andra apps (för clean screen share)
- [ ] Öka font size i VS Code (Ctrl+Plus)
- [ ] Öppna dessa filer i VS Code:
  - `project/primitive_ui/README.md`
  - `project/primitive_ui/lib/src/components/primitive_card.dart`
  - `project/primitive_ui/test/primitive_toggle_switch_test.dart`
  - `FLUTTER_GETTING_STARTED_GUIDE.md`
- [ ] Ha 2 terminals ready:
  - Terminal 1: `cd project/primitive_demo`
  - Terminal 2: `cd project/primitive_ui`
- [ ] Testa internet connection
- [ ] Testa Zoom screen sharing & audio
- [ ] Stäng notifications (Do Not Disturb mode)

### Test run:

```bash
# Terminal 1
cd project/primitive_demo
flutter run -d chrome
# Vänta tills appen laddar
# Klicka runt för att se att allt fungerar
# Stäng appen (Ctrl+C)

# Terminal 2  
cd project/primitive_ui
flutter test
# Verify alla tests passar
```

### Under presentation:

- [ ] Start screen share i Zoom
- [ ] Öka zoom level i browser (Ctrl+Plus) för större UI
- [ ] Speak clearly och slowly
- [ ] Peka med musen vad du förklarar
- [ ] Pause efter varje section för frågor

---

##  Screen Sharing Tips

### I Zoom:

1. **Share screen** (inte specifik window)
2. **Check "Share computer sound"** om du visar video
3. **Don't share:** Notifications, personal tabs, Slack messages

### Browser Tips:

```
Zoom in: Ctrl+Plus eller Cmd+Plus
Zoom out: Ctrl+Minus eller Cmd+Minus
Full screen: F11
Exit full screen: F11 eller Esc
```

### Terminal Tips:

```bash
# Öka font size
Ctrl+Shift+Plus

# Minska font size
Ctrl+Shift+Minus

# Clear terminal
clear
# eller Ctrl+L
```

---

##  Demo Script (vad du säger medan du kör)

### Vid app start:
```
"Jag kör nu demo-appen. Den är byggd med Flutter och showcasar alla 
komponenter från Primitive UI biblioteket."
```

### När du visar component:
```
"Här ser ni [Component Name]. Den är implementerad med CustomPaint och Canvas.
Notera [specific feature] - allt ritat manuellt utan att använda färdiga widgets."
```

### När du interagerar:
```
"När jag klickar här... *klicka* ...ser ni att [vad som händer]. Detta triggar
setState() som rebuildar komponenten med nya värden."
```

### När du visar kod:
```
"I koden ser ni att vi använder Canvas.draw[Shape]() metoderna för att rita.
paint() anropas varje gång komponenten behöver renderas."
```

### När du kör tests:
```
"Låt mig nu köra UI-testerna. Vi har [X] test files som täcker alla komponenter.
*kör flutter test*
Som ni ser passerar alla tests. Testerna verifierar rendering, interaktion,
och animationer."
```

---

##  Backup Plan

Om något går fel live:

### Demo app kraschar:
- **Plan A:** Hot restart (tryck `R` i terminal)
- **Plan B:** Stäng och kör `flutter run` igen
- **Plan C:** Visa pre-recorded video (spela in en innan!)
- **Plan D:** Visa screenshots från README.md

### Tests failar:
- **Plan A:** Kör specifik test file som du vet fungerar
- **Plan B:** Visa tidigare test output (ta screenshot innan!)
- **Plan C:** Förklara vad testerna gör utan att köra dem

### Internet dör:
- Demo app kan köra offline om redan startad
- Screenshots finns i README.md
- Fortsätt förklara conceptuellt

### Screen share freezar:
- Stop och start sharing igen
- Fortsätt förklara verbal
- Visa kod i GitHub istället

---

##  Quick Reference - File Paths

```
project/
 primitive_ui/                    # Main library
    lib/
       primitive_ui.dart       # Barrel export
       src/
           components/
               primitive_button.dart
               primitive_input.dart
               primitive_card.dart
               primitive_toggle_switch.dart
               primitive_slider.dart
               primitive_circular_progress.dart
               v_stack.dart
               h_stack.dart
               z_stack.dart
    test/                       # UI Tests
       primitive_button_test.dart
       primitive_input_test.dart
       primitive_card_test.dart
       primitive_toggle_switch_test.dart
       primitive_slider_test.dart
       primitive_circular_progress_test.dart
       v_stack_test.dart
       h_stack_test.dart
       z_stack_test.dart
    README.md                   # API Documentation

 primitive_demo/                 # Demo Application
     lib/
        main.dart              # Main demo
        snippets.dart          # Code examples
     README.md                  # Demo guide
```

---

##  Keyboard Shortcuts i Demo

### Flutter App:
- `r` - Hot reload
- `R` - Hot restart  
- `q` - Quit app
- `p` - Toggle performance overlay
- `w` - Toggle widget inspector

### Browser (Chrome):
- `Ctrl+Plus` - Zoom in
- `Ctrl+Minus` - Zoom out
- `Ctrl+0` - Reset zoom
- `F11` - Fullscreen
- `F12` - Developer tools (visa om nån frågar om rendering)

### VS Code:
- `Ctrl+Plus` - Öka font size
- `Ctrl+B` - Toggle sidebar
- `Ctrl+P` - Quick file open
- `Ctrl+Shift+F` - Search in files

---

**Lycka till med demon! **
