# Quick Reference Guide - Primitive UI Project

**For:** Quick testing, running, and verification of the Primitive UI project

---

## 🚀 Quick Start Commands

### Run the Demo App
```powershell
cd project/primitive_demo
flutter pub get
flutter run
```

### Run Tests
```powershell
cd project/primitive_ui
flutter pub get
flutter test
```

### Static Analysis
```powershell
# In primitive_ui directory
flutter analyze

# In primitive_demo directory
cd ../primitive_demo
flutter analyze
```

### Build Demo for Windows
```powershell
cd project/primitive_demo
flutter build windows --debug
```

---

## 📁 Important File Locations

### Components (Library)
- `project/primitive_ui/lib/src/components/custom_card.dart`
- `project/primitive_ui/lib/src/components/custom_toggle_switch.dart`
- `project/primitive_ui/lib/src/components/v_stack.dart`
- `project/primitive_ui/lib/src/components/z_stack.dart`

### Tests
- `project/primitive_ui/test/custom_toggle_switch_test.dart`
- `project/primitive_ui/test/custom_card_test.dart`
- `project/primitive_ui/test/v_stack_test.dart`
- `project/primitive_ui/test/z_stack_test.dart`

### Demo
- `project/primitive_demo/lib/main.dart`

### Documentation
- `project/GETTING_STARTED_FLUTTER.md` - Flutter tutorial
- `project/primitive_ui/README.md` - API documentation
- `project/primitive_demo/README.md` - Demo guide
- `project/REQUIREMENTS_VERIFICATION.md` - Requirements checklist
- `project/PROJECT_SUMMARY.md` - Project overview
- `README.md` - Repository navigation

---

## ✅ Quick Verification

### Expected Results

**Static Analysis (both packages):**
```
No issues found!
```

**Tests (primitive_ui):**
```
00:04 +61: All tests passed!
```

**Build (primitive_demo):**
```
√ Built build\windows\x64\runner\Debug\primitive_demo.exe
```

---

## 🎯 Component Usage Examples

### CustomCard
```dart
CustomCard(
  color: Colors.white,
  borderRadius: 12.0,
  elevation: 4.0,
  padding: EdgeInsets.all(16.0),
  child: Text('Card content'),
)
```

### CustomToggleSwitch
```dart
CustomToggleSwitch(
  value: _isOn,
  onChanged: (bool value) {
    setState(() => _isOn = value);
  },
  activeColor: Colors.blue,
)
```

### VStack
```dart
VStack(
  spacing: 16.0,
  alignment: VStackAlignment.center,
  children: [
    Text('Item 1'),
    Text('Item 2'),
    Text('Item 3'),
  ],
)
```

### ZStack
```dart
ZStack(
  alignment: Alignment.center,
  children: [
    Container(width: 200, height: 200, color: Colors.blue),
    Container(width: 100, height: 100, color: Colors.red),
  ],
)
```

---

## 📊 Project Statistics

- **Components:** 4 (2 UI + 2 Layout)
- **Lines of Code (Library):** ~1,100
- **Lines of Code (Tests):** ~900
- **Lines of Code (Demo):** 653
- **Test Cases:** 61 (all passing)
- **Documentation:** ~2,500 lines

---

## 🔍 What to Look For in Demo

### Section 1: Header
- Dark mode toggle switch
- Theme changes across entire app

### Section 2: CustomCard Variations
- Different elevations (shadow depth)
- Various border radii
- Color changes with theme

### Section 3: CustomToggleSwitch Examples
- Smooth animations
- Multiple independent toggles
- Show/hide functionality

### Section 4: VStack Layouts
- 4 alignment modes demonstrated
- Different spacing values
- Various content types

### Section 5: ZStack Layouts
- Layered components
- Badge overlay example
- Z-ordering visualization

### Section 6: Combined Components
- Real-world settings panel
- All components working together

---

## ⚡ Troubleshooting

### Issue: "Package primitive_ui not found"
**Solution:**
```powershell
cd project/primitive_demo
flutter pub get
```

### Issue: Build fails
**Solution:**
```powershell
flutter clean
flutter pub get
flutter build windows --debug
```

### Issue: Tests fail
**Solution:** Check that you're in the correct directory:
```powershell
cd project/primitive_ui
flutter test
```

---

## 📝 Grade 5 Requirements Quick Check

- [x] 2 UI Components (CustomCard, CustomToggleSwitch)
- [x] 2 Layout Components (VStack, ZStack)
- [x] Primitive-only implementation (CustomPaint, Canvas, GestureDetector, RenderBox)
- [x] UI Testing (61 comprehensive tests covering all components)
- [x] Getting Started Guide (GETTING_STARTED_FLUTTER.md)
- [x] README with design decisions (primitive_ui/README.md)

**Status: All requirements met ✅**

---

## 🎓 For Demonstration

1. **Show project structure** in VS Code
2. **Run static analysis** - show zero warnings
3. **Run tests** - show all 61 passing
4. **Launch demo app** - demonstrate all sections
5. **Explain code** - show primitive implementation
6. **Discuss documentation** - highlight key docs

---

## 📞 Quick Reference

**Project Location:** `c:\Users\berka\Masters\TDDC73\project\`

**Main Documents:**
- Getting Started: `GETTING_STARTED_FLUTTER.md`
- API Docs: `primitive_ui/README.md`
- Demo Guide: `primitive_demo/README.md`
- Verification: `REQUIREMENTS_VERIFICATION.md`
- Summary: `PROJECT_SUMMARY.md`

**Commands:**
```powershell
# Run demo
cd project/primitive_demo && flutter run

# Run tests
cd project/primitive_ui && flutter test

# Analyze
flutter analyze
```

---

**Last Updated:** November 23, 2025  
**Status:** ✅ Project Complete and Ready
