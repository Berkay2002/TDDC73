// ignore_for_file: deprecated_member_use, curly_braces_in_flow_control_structures, unreachable_switch_default, unused_field
import 'package:flutter/material.dart';

enum PrimitiveButtonVariant {
  primary,
  secondary,
  destructive,
  outline,
  ghost,
  link,
}

enum PrimitiveButtonSize { sm, md, lg, icon }

class PrimitiveButton extends StatefulWidget {
  final VoidCallback? onPressed;
  final Widget? child;
  final PrimitiveButtonVariant variant;
  final PrimitiveButtonSize size;
  final bool isLoading;
  final Widget? leading;
  final Widget? trailing;
  final bool isDisabled;

  const PrimitiveButton({
    super.key,
    required this.onPressed,
    this.child,
    this.variant = PrimitiveButtonVariant.primary,
    this.size = PrimitiveButtonSize.md,
    this.isLoading = false,
    this.isDisabled = false,
    this.leading,
    this.trailing,
  });

  @override
  State<PrimitiveButton> createState() => _PrimitiveButtonState();
}

class _PrimitiveButtonState extends State<PrimitiveButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  bool _isHovered = false;
  bool _isPressed = false;

  bool get _effectiveDisabled =>
      widget.isDisabled || widget.isLoading || widget.onPressed == null;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
    );
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 0.97,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleTapDown(TapDownDetails details) {
    if (!_effectiveDisabled) {
      setState(() => _isPressed = true);
      _controller.forward();
    }
  }

  void _handleTapUp(TapUpDetails details) {
    if (!_effectiveDisabled) {
      setState(() => _isPressed = false);
      _controller.reverse();
      widget.onPressed?.call();
    }
  }

  void _handleTapCancel() {
    if (!_effectiveDisabled) {
      setState(() => _isPressed = false);
      _controller.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    // ═══════════════════════════════════════════════════════════════════
    // STEP 1: Resolve Colors & Styles Based on Variant
    // ═══════════════════════════════════════════════════════════════════
    // Each variant has different visual characteristics:
    // - primary: Solid color, high emphasis
    // - secondary: Alternate solid color, medium emphasis
    // - destructive: Error color for dangerous actions
    // - outline: Transparent with border
    // - ghost: Transparent, minimal emphasis
    // - link: Text-style button with underline on hover
    Color backgroundColor;
    Color foregroundColor;
    Border? border;

    switch (widget.variant) {
      case PrimitiveButtonVariant.primary:
        backgroundColor = colorScheme.primary;
        foregroundColor = colorScheme.onPrimary;
        // Hover state: slightly darker for visual feedback
        if (_isHovered) backgroundColor = colorScheme.primary.withOpacity(0.9);
        break;
      case PrimitiveButtonVariant.secondary:
        backgroundColor = colorScheme.secondary;
        foregroundColor = colorScheme.onSecondary;
        if (_isHovered)
          backgroundColor = colorScheme.secondary.withOpacity(0.8);
        break;
      case PrimitiveButtonVariant.destructive:
        backgroundColor = colorScheme.error;
        foregroundColor = colorScheme.onError;
        if (_isHovered) backgroundColor = colorScheme.error.withOpacity(0.9);
        break;
      case PrimitiveButtonVariant.outline:
        backgroundColor = Colors.transparent;
        foregroundColor = colorScheme.onSurface;
        border = Border.all(color: colorScheme.outline);
        // Hover: subtle background fill
        if (_isHovered)
          backgroundColor = colorScheme.surfaceContainerHighest.withOpacity(
            0.5,
          );
        break;
      case PrimitiveButtonVariant.ghost:
        backgroundColor = Colors.transparent;
        foregroundColor = colorScheme.onSurface;
        if (_isHovered)
          backgroundColor = colorScheme.surfaceContainerHighest.withOpacity(
            0.5,
          );
        break;
      case PrimitiveButtonVariant.link:
        backgroundColor = Colors.transparent;
        foregroundColor = colorScheme.primary;
        if (_isHovered) {
          // Link style: text becomes slightly dimmer on hover
          // (underline is applied in text decoration below)
          foregroundColor = colorScheme.primary.withOpacity(0.8);
        }
        break;
    }

    // ───────────────────────────────────────────────────────────────────
    // Handle Disabled State
    // ───────────────────────────────────────────────────────────────────
    if (_effectiveDisabled) {
      // Transparent variants stay transparent when disabled
      backgroundColor =
          widget.variant == PrimitiveButtonVariant.ghost ||
              widget.variant == PrimitiveButtonVariant.link ||
              widget.variant == PrimitiveButtonVariant.outline
          ? Colors.transparent
          : colorScheme.onSurface.withOpacity(0.12);
      // Disabled text is muted (Material Design standard opacity)
      foregroundColor = colorScheme.onSurface.withOpacity(0.38);
      // Outline variant needs muted border in disabled state
      if (widget.variant == PrimitiveButtonVariant.outline) {
        border = Border.all(color: colorScheme.onSurface.withOpacity(0.12));
      }
    }

    // ═══════════════════════════════════════════════════════════════════
    // STEP 2: Resolve Size Parameters
    // ═══════════════════════════════════════════════════════════════════
    // Each size preset defines button dimensions and spacing
    double height;
    EdgeInsets padding;
    double fontSize;
    double iconSize;

    switch (widget.size) {
      case PrimitiveButtonSize.sm:
        height = 36;
        padding = const EdgeInsets.symmetric(horizontal: 12);
        fontSize = 13;
        iconSize = 14;
        break;
      case PrimitiveButtonSize.lg:
        height = 44;
        padding = const EdgeInsets.symmetric(horizontal: 32);
        fontSize = 16;
        iconSize = 18;
        break;
      case PrimitiveButtonSize.icon:
        // Icon button is square (width = height)
        height = 40;
        padding = EdgeInsets.zero; // No padding, content is centered
        fontSize = 14;
        iconSize = 18;
        break;
      case PrimitiveButtonSize.md:
      default:
        height = 40;
        padding = const EdgeInsets.symmetric(horizontal: 16);
        fontSize = 14;
        iconSize = 16;
        break;
    }

    // ═══════════════════════════════════════════════════════════════════
    // STEP 3: Construct Button Content
    // ═══════════════════════════════════════════════════════════════════
    Widget content;
    if (widget.isLoading) {
      // ───────────────────────────────────────────────────────────────────
      // Loading State: Show spinner
      // ───────────────────────────────────────────────────────────────────
      content = SizedBox(
        width: iconSize,
        height: iconSize,
        child: CircularProgressIndicator(
          strokeWidth: 2,
          color: foregroundColor,
        ),
      );
      // If there's text and it's not an icon-only button, show spinner + text
      if (widget.child != null && widget.size != PrimitiveButtonSize.icon) {
        content = Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            content,
            const SizedBox(width: 8),
            DefaultTextStyle(
              style: TextStyle(
                color: foregroundColor,
                fontSize: fontSize,
                fontWeight: FontWeight.w500,
              ),
              child: widget.child!,
            ),
          ],
        );
      }
    } else {
      // ───────────────────────────────────────────────────────────────────
      // Normal State: Build content from leading, child, trailing
      // ───────────────────────────────────────────────────────────────────
      List<Widget> children = [];

      // Add leading icon if provided
      if (widget.leading != null) {
        children.add(
          IconTheme(
            data: IconThemeData(size: iconSize, color: foregroundColor),
            child: widget.leading!,
          ),
        );
        // Add spacing between icon and text
        if (widget.child != null) children.add(const SizedBox(width: 8));
      }

      // Add main text content
      if (widget.child != null) {
        children.add(
          DefaultTextStyle(
            style: TextStyle(
              color: foregroundColor,
              fontSize: fontSize,
              fontWeight: FontWeight.w500,
              // Link variant gets underline on hover
              decoration:
                  widget.variant == PrimitiveButtonVariant.link && _isHovered
                  ? TextDecoration.underline
                  : TextDecoration.none,
            ),
            child: widget.child!,
          ),
        );
      }

      // Add trailing icon if provided
      if (widget.trailing != null) {
        if (widget.child != null) children.add(const SizedBox(width: 8));
        children.add(
          IconTheme(
            data: IconThemeData(size: iconSize, color: foregroundColor),
            child: widget.trailing!,
          ),
        );
      }

      // Combine all content into a horizontal row
      content = Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: children,
      );
    }

    // ═══════════════════════════════════════════════════════════════════
    // STEP 4: Build Widget Tree with Interactions
    // ═══════════════════════════════════════════════════════════════════
    return MouseRegion(
      // ─────────────────────────────────────────────────────────────────
      // Track hover state for visual feedback
      // ─────────────────────────────────────────────────────────────────
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      // Change cursor based on disabled state
      cursor: _effectiveDisabled
          ? SystemMouseCursors.forbidden
          : SystemMouseCursors.click,
      child: GestureDetector(
        // ─────────────────────────────────────────────────────────────────
        // Handle tap interactions for press animation and callback
        // ─────────────────────────────────────────────────────────────────
        onTapDown: _handleTapDown, // Start press animation
        onTapUp: _handleTapUp, // End animation + trigger callback
        onTapCancel: _handleTapCancel, // End animation if tap cancelled
        child: ScaleTransition(
          // ─────────────────────────────────────────────────────────────────
          // Press animation: button scales down slightly when pressed
          // ─────────────────────────────────────────────────────────────────
          scale: _scaleAnimation,
          child: AnimatedContainer(
            // ─────────────────────────────────────────────────────────────────
            // Animate color changes smoothly (hover, disabled states)
            // ─────────────────────────────────────────────────────────────────
            duration: const Duration(milliseconds: 150),
            height: height,
            // Icon buttons are square
            width: widget.size == PrimitiveButtonSize.icon ? height : null,
            padding: widget.size == PrimitiveButtonSize.icon
                ? EdgeInsets.zero
                : padding,
            decoration: BoxDecoration(
              color: backgroundColor,
              border: border,
              borderRadius: BorderRadius.circular(6), // Shadcn default radius
            ),
            child: Center(child: content),
          ),
        ),
      ),
    );
  }
}
