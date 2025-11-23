# Polish Implementation Plan - primitive_ui

**Date:** November 23, 2025  
**Status:** Ready for Implementation  
**Goal:** Eliminate code duplication, add comprehensive test coverage, replace magic numbers, validate parameters, and ensure API consistency

---

## Overview

Systematic refactoring to address technical debt while maintaining backward compatibility where possible. This polish elevates the library from "complete" to "exemplary" quality.

---

## Implementation Steps

### Step 1: Create Shared Intrinsic Size Utilities

**File:** `lib/src/utils/intrinsic_helpers.dart` (new file)

**Goal:** Eliminate ~60 lines of duplicated code across `VStack` and `ZStack`

**Actions:**
1. Create new utility file with 4 helper functions:
   - `computeMaxIntrinsicWidthFromChildren`
   - `computeMinIntrinsicWidthFromChildren`
   - `computeMaxIntrinsicHeightFromChildren`
   - `computeMinIntrinsicHeightFromChildren`
2. Each function iterates over `ContainerRenderObjectMixin` children
3. Refactor `_RenderVStack` in `lib/src/components/v_stack.dart`:
   - Replace 4 intrinsic methods with helper calls
4. Refactor `_RenderZStack` in `lib/src/components/z_stack.dart`:
   - Replace 4 intrinsic methods with helper calls

**Implementation Details:**
```dart
// Helper signature example
double computeMaxIntrinsicWidthFromChildren(
  RenderBox? firstChild,
  double height,
) {
  double width = 0.0;
  RenderBox? child = firstChild;
  while (child != null) {
    final childParentData = child.parentData! as ContainerBoxParentData<RenderBox>;
    final childWidth = child.getMaxIntrinsicWidth(height);
    width = width > childWidth ? width : childWidth;
    child = childParentData.nextSibling;
  }
  return width;
}
```

**Verification:**
- Run `flutter analyze` - should have zero issues
- Run `flutter test` - all existing tests should pass
- No functional changes, pure refactoring

---

### Step 2: Extract Constants in CustomCard

**File:** `lib/src/components/custom_card.dart`

**Goal:** Replace magic numbers with documented constants

**Actions:**
1. In `_CardPainter` class, add static constants:
   ```dart
   // Material Design elevation scale - controls shadow opacity
   static const double _kShadowOpacityDivisor = 24.0;
   
   // Maximum shadow opacity to prevent overly dark shadows
   static const double _kMaxShadowOpacity = 0.3;
   ```
2. Update `paint` method to use constants:
   ```dart
   final double shadowOpacity = 
     (elevation / _kShadowOpacityDivisor).clamp(0.0, _kMaxShadowOpacity);
   ```

**Verification:**
- Run `flutter analyze` - zero issues
- Visual inspection in demo app - shadow appearance unchanged

---

### Step 3: Extract Constants in CustomToggleSwitch

**File:** `lib/src/components/custom_toggle_switch.dart`

**Goal:** Replace magic numbers with documented constants

**Actions:**
1. In `_CustomToggleSwitchState` class, add static constants:
   ```dart
   // Animation duration for smooth but responsive feel
   static const int _kAnimationDurationMs = 200;
   ```
2. In `_ToggleSwitchPainter` class, add static constants:
   ```dart
   // Thumb radius ratio ensures visible thumb with comfortable tap target
   static const double _kThumbRadiusRatio = 0.4;
   
   // Subdued track color when inactive
   static const double _kTrackOpacity = 0.5;
   
   // Shadow properties for subtle depth effect
   static const double _kShadowBlurRadius = 2.0;
   static const double _kShadowYOffset = 1.0; // Simulates light from above
   ```
3. Update all usages to reference constants

**Verification:**
- Run `flutter analyze` - zero issues
- Visual inspection in demo app - toggle behavior unchanged

---

### Step 4: Add Parameter Validation Assertions

**Files:** All component files

**Goal:** Catch invalid parameters during development

**Actions:**

**In `lib/src/components/v_stack.dart`:**
```dart
const VStack({
  super.key,
  required this.children,
  this.spacing = 0.0,
  this.alignment = VStackAlignment.start,
  this.mainAxisSize = MainAxisSize.max,
}) : assert(spacing >= 0.0, 'Spacing must be non-negative');
```

**In `lib/src/components/custom_card.dart`:**
```dart
const CustomCard({
  super.key,
  required this.child,
  this.color = const Color(0xFFFFFFFF),
  this.borderRadius = 8.0,
  this.elevation = 2.0,
  this.padding = const EdgeInsets.all(16.0),
}) : assert(elevation >= 0.0, 'Elevation cannot be negative'),
     assert(borderRadius >= 0.0, 'Border radius cannot be negative'),
     assert(
       padding.top >= 0.0 && padding.bottom >= 0.0 &&
       padding.left >= 0.0 && padding.right >= 0.0,
       'Padding values must be non-negative',
     );
```

**In `lib/src/components/custom_toggle_switch.dart`:**
```dart
const CustomToggleSwitch({
  super.key,
  required this.value,
  required this.onChanged,
  this.activeColor = const Color(0xFF2196F3),
  this.inactiveColor = const Color(0xFF9E9E9E),
  this.width = 50.0,
  this.height = 30.0,
}) : assert(width > height, 'Width must exceed height for proper switch appearance'),
     assert(width > 0 && height > 0, 'Dimensions must be positive');
```

**Verification:**
- Run `flutter analyze` - zero issues
- Run `flutter test` - all tests should pass
- Manually test assertion with negative values in debug mode

---

### Step 5: Rename StackFit to ZStackFit

**Files:** `lib/src/components/z_stack.dart`, `lib/primitive_ui.dart`

**Goal:** API consistency with `VStackAlignment` naming pattern

**Actions:**
1. In `lib/src/components/z_stack.dart`:
   - Rename `enum StackFit` to `enum ZStackFit`
   - Update 6 internal usages in `_RenderZStack` class
2. Verify `lib/primitive_ui.dart` exports are correct (enum exported automatically)
3. Check demo app - no explicit `fit` usage, defaults to `ZStackFit.loose`

**Breaking Change Note:**
- Package is version `0.0.1` (pre-release)
- Direct rename without deprecation period is acceptable
- Demo app unaffected (uses default parameter)
- Version should bump to `0.1.0` after polish

**Verification:**
- Run `flutter analyze` in both `primitive_ui` and `primitive_demo`
- Run demo app - all sections work correctly
- Search for `StackFit` usage - should find zero results

---

### Step 6: Create CustomCard Tests

**File:** `test/custom_card_test.dart` (new file)

**Goal:** Match quality of `custom_toggle_switch_test.dart` with ~10 tests

**Test Cases:**
1. **Basic Rendering**
   - Renders with child widget
   - Child is visible and positioned correctly

2. **Color Customization**
   - Applies custom background color
   - Renders with default white color

3. **Border Radius**
   - Applies custom border radius
   - Renders with default 8.0 radius

4. **Elevation/Shadow**
   - Renders shadow with elevation > 0
   - No shadow when elevation = 0
   - Higher elevation = more visible shadow

5. **Padding**
   - Applies custom padding correctly
   - Different padding values (symmetric, asymmetric)
   - Default padding is 16.0 on all sides

6. **Layout Constraints**
   - Maintains child size constraints
   - Card size = child size + padding
   - Handles tight constraints

7. **Edge Cases**
   - Zero elevation (no shadow rendering)
   - Very large elevation (clamped opacity)
   - Minimal constraints
   - Assertion fires for negative elevation (death test)

**Structure:**
```dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:primitive_ui/primitive_ui.dart';

void main() {
  group('CustomCard', () {
    testWidgets('renders with child widget', (tester) async { /* ... */ });
    // ... more tests
  });
  
  group('CustomCard - Edge Cases', () {
    // Edge case tests
  });
}
```

**Verification:**
- Run `flutter test test/custom_card_test.dart`
- All 10 tests should pass

---

### Step 7: Create VStack Tests

**File:** `test/v_stack_test.dart` (new file)

**Goal:** Comprehensive coverage of layout behavior (~12 tests)

**Test Cases:**
1. **Basic Rendering**
   - Renders empty children list (SizedBox.shrink)
   - Renders single child (returns child directly)
   - Renders multiple children

2. **Spacing**
   - Applies spacing between children
   - No spacing with spacing = 0.0
   - Correct total height calculation

3. **Alignment Modes** (4 tests)
   - VStackAlignment.start (left in LTR, right in RTL)
   - VStackAlignment.center
   - VStackAlignment.end (right in LTR, left in RTL)
   - VStackAlignment.stretch (children fill width)

4. **MainAxisSize**
   - MainAxisSize.max (fills available height)
   - MainAxisSize.min (wraps content)

5. **Text Direction**
   - RTL reverses start/end alignment
   - Center and stretch unaffected by text direction

6. **Layout Calculations**
   - Proper child sizing with stretch
   - Nested VStacks work correctly

7. **Edge Cases**
   - Negative spacing assertion fires (death test)
   - Handles unbounded constraints

**Structure:**
```dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:primitive_ui/primitive_ui.dart';

void main() {
  group('VStack', () {
    testWidgets('renders empty children', (tester) async { /* ... */ });
    // ... alignment tests
  });
  
  group('VStack - Spacing', () {
    // Spacing tests
  });
  
  group('VStack - Edge Cases', () {
    // Edge case tests
  });
}
```

**Verification:**
- Run `flutter test test/v_stack_test.dart`
- All 12 tests should pass

---

### Step 8: Create ZStack Tests

**File:** `test/z_stack_test.dart` (new file)

**Goal:** Test layering and fit modes (~10 tests)

**Test Cases:**
1. **Basic Rendering**
   - Renders empty children list (SizedBox.shrink)
   - Renders single child (returns child directly)
   - Renders multiple children

2. **Z-Ordering/Layering**
   - Children painted in order (last on top)
   - Verify paint order with hit testing

3. **Fit Modes** (3 tests)
   - ZStackFit.loose (children size naturally)
   - ZStackFit.expand (children expanded to fill)
   - ZStackFit.passthrough (children use exact constraints)

4. **Alignment**
   - Alignment.center positions correctly
   - Alignment.topLeft positions correctly
   - Alignment.bottomRight positions correctly
   - Other corner/edge alignments

5. **Size Calculation**
   - Stack sizes to largest child (loose mode)
   - Stack sizes to constraints (expand mode)

6. **Text Direction**
   - RTL affects alignment resolution
   - AlignmentDirectional works correctly

7. **Edge Cases**
   - Nested ZStacks
   - Mixed-size children
   - Handles tight constraints

**Structure:**
```dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:primitive_ui/primitive_ui.dart';

void main() {
  group('ZStack', () {
    testWidgets('renders empty children', (tester) async { /* ... */ });
    // ... fit mode tests
  });
  
  group('ZStack - Alignment', () {
    // Alignment tests
  });
  
  group('ZStack - Edge Cases', () {
    // Edge case tests
  });
}
```

**Verification:**
- Run `flutter test test/z_stack_test.dart`
- All 10 tests should pass

---

### Step 9: Run Full Verification Suite

**Goal:** Ensure all changes work together correctly

**Actions:**

1. **Run all tests:**
   ```powershell
   cd project/primitive_ui
   flutter test
   ```
   **Expected:** 46+ passing tests (14 existing + 32 new)

2. **Static analysis - library:**
   ```powershell
   cd project/primitive_ui
   flutter analyze
   ```
   **Expected:** No issues found!

3. **Static analysis - demo:**
   ```powershell
   cd project/primitive_demo
   flutter analyze
   ```
   **Expected:** No issues found!

4. **Run demo app:**
   ```powershell
   cd project/primitive_demo
   flutter run
   ```
   **Expected:** All 6 sections work correctly, no visual regressions

5. **Update documentation:**
   - Update `QUICK_REFERENCE.md` test count to ~46
   - Verify `README.md` accuracy
   - Ensure code examples still work

**Final Checklist:**
- [ ] All tests pass (46+)
- [ ] Zero analyzer warnings
- [ ] Demo app runs without errors
- [ ] No visual regressions
- [ ] Documentation updated
- [ ] Code duplication eliminated
- [ ] Magic numbers replaced
- [ ] Parameters validated
- [ ] API naming consistent

---

## Recommendations Summary

### Breaking Change Strategy
**Direct rename `StackFit` → `ZStackFit`** without deprecation period because:
- Package is version `0.0.1` (pre-release)
- Demo app doesn't use explicit `fit` parameter
- If published, bump to `0.1.0` as minor breaking change

### Assertion Approach
**Use debug-only `assert()` statements** (not `ArgumentError`) because:
- Maintains zero runtime overhead in release builds
- Catches developer errors during development
- Standard Flutter pattern for parameter validation

### Helper Visibility
**Keep intrinsic helpers internal** (`lib/src/utils/`) because:
- Implementation details specific to `ContainerRenderObjectMixin`
- Not general-purpose API
- Keeps public API surface clean

### Constant Scope
**Define constants as `static const` private fields** (`_k` prefix) because:
- Keeps constants close to usage context
- Avoids global namespace pollution
- Clear ownership and documentation

### Test Coverage Target
**~10 tests per component** matching `CustomToggleSwitch` quality:
- Covers rendering, behavior, customization
- Tests edge cases without over-testing internals
- Total: 46+ tests (14 existing + 32 new)

---

## Estimated Effort

- **Step 1 (Intrinsic Helpers):** 1 hour
- **Step 2 (CustomCard Constants):** 30 minutes
- **Step 3 (CustomToggleSwitch Constants):** 30 minutes
- **Step 4 (Parameter Validation):** 1 hour
- **Step 5 (Rename StackFit):** 30 minutes
- **Step 6 (CustomCard Tests):** 2 hours
- **Step 7 (VStack Tests):** 2.5 hours
- **Step 8 (ZStack Tests):** 2 hours
- **Step 9 (Verification):** 1 hour

**Total:** ~11.5 hours

---

## Success Criteria

✅ Zero code duplication in intrinsic size calculations  
✅ All magic numbers replaced with documented constants  
✅ All parameters validated with helpful assertions  
✅ API naming consistent across all components  
✅ 46+ passing tests with comprehensive coverage  
✅ Zero analyzer warnings in library and demo  
✅ No visual or functional regressions  
✅ Documentation updated and accurate  

---

**Status:** Ready for implementation  
**Next Action:** Begin with Step 1 (Intrinsic Helpers)
