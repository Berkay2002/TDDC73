## 0.0.1

* Initial release of Primitive UI.
* Added `CustomCard` component: A container with shadow, rounded corners, and padding.
* Added `CustomToggleSwitch` component: An animated toggle switch.
* Added `VStack` layout: A vertical stack layout with alignment options.
* Added `ZStack` layout: A layered stack layout with alignment options.
* Implemented using only low-level primitives: `CustomPaint`, `Canvas`, `GestureDetector`, and custom `RenderBox`.

## 0.0.2

* Added `HStack` layout: A horizontal stack layout with alignment options.
* Added `MainAxisAlignment` support to `VStack` and `HStack` for distributing free space (start, center, end, spaceBetween, spaceAround, spaceEvenly).
* Improved layout logic for stacks to correctly handle single children with alignment.
* Added `CustomSlider` component: A slider built with `CustomPaint` and `GestureDetector`.
* Added `CustomCircularProgress` component: An indeterminate progress indicator built with `CustomPaint` and `AnimationController`.
