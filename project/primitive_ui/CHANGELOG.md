## 0.0.6

*   **New Component**: Introduced `PrimitiveButton`, a highly customizable button with multiple variants (primary, secondary, destructive, outline, ghost, link), sizes (sm, md, lg, icon), and states (loading, disabled).
*   **New Component**: Introduced `PrimitiveInput`, a composable text input built on `EditableText` with support for variants, sizes, and decorations.

## 0.0.5

* **Layout Intelligence**: `VStack` and `HStack` now use standard Flutter `CrossAxisAlignment` instead of custom alignment enums.
* **Implicit Animations**: `PrimitiveCard` now implicitly animates color, elevation, and shadow changes.
* **Implicit Animations**: `PrimitiveSlider` now implicitly animates programmatic value changes while keeping drag interactions immediate.
* **Refactor**: Standardized alignment APIs across layout components.

## 0.0.4

* **Accessibility**: Added WAI-ARIA compliant semantics to interactive components.
* **PrimitiveCard**: Added `semanticsLabel` and semantic button/container roles.
* **PrimitiveToggleSwitch**: Added `semanticsLabel` and semantic switch role (`toggled`).
* **PrimitiveSlider**: Added `semanticsLabel`, `semanticsStep` and semantic slider role with increment/decrement actions.
* **PrimitiveCircularProgress**: Added `semanticsLabel` and semantic progress indicator support.

## 0.0.3

* **VStack**: Added `CustomFlexible` and `CustomExpanded` support for flex layouts.
* **HStack**: Added `HCustomFlexible` and `HCustomExpanded` for proportional horizontal sizing.
* **ZStack**: Added `CustomPositioned` support for absolute positioning.
* **PrimitiveCard**: Added `shadowColor` and `onTap` (with visual feedback) support.
* **PrimitiveSlider**: Added `onChangeStart`, `onChangeEnd`, and `thumbColor` customization.
* **PrimitiveCircularProgress**: Added determinate progress support.

## 0.0.2

* Added `HStack` layout: A horizontal stack layout with alignment options
* Added `MainAxisAlignment` support to `VStack` and `HStack` for distributing free space (start, center, end, spaceBetween, spaceAround, spaceEvenly)
* Improved layout logic for stacks to correctly handle single children with alignment
* Added `PrimitiveSlider` component: A slider built with `CustomPaint` and `GestureDetector`
* Added `PrimitiveCircularProgress` component: An indeterminate progress indicator built with `CustomPaint` and `AnimationController`

## 0.0.1

* Initial release.
