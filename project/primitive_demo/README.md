# Primitive UI Demo

A demonstration app showcasing the Primitive UI library components.

## Overview

This app demonstrates all components from the Primitive UI library, which is built using only primitive Flutter components (CustomPaint, Canvas, GestureDetector).

## Features

The demo includes:
- **CustomCard** examples with various configurations
- **CustomToggleSwitch** with interactive state management
- **VStack** layout demonstrations
- **ZStack** layering examples

## Running the Demo

1. Ensure the `primitive_ui` package is available at `../primitive_ui`
2. Get dependencies:
   ```bash
   flutter pub get
   ```
3. Run the app:
   ```bash
   flutter run
   ```

## Project Structure

```
lib/
  └── main.dart    # Main demo app with all component examples
```

## Components Demonstrated

### CustomCard
Shows cards with different:
- Border radius values
- Elevation (shadow) levels
- Background colors
- Padding configurations

### CustomToggleSwitch
Interactive toggles that demonstrate:
- State changes
- Smooth animations
- Custom colors
- Callback handling

### VStack
Vertical layouts showing:
- Different spacing values
- Alignment options
- Mixed content types

### ZStack
Layered layouts demonstrating:
- Z-ordering of widgets
- Alignment options
- Overlapping elements

## Learn More

For detailed API documentation, see the [Primitive UI README](../primitive_ui/README.md).
