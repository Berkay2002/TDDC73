import 'package:flutter/material.dart';

enum PrimitiveButtonVariant {
  primary,
  secondary,
  destructive,
  outline,
  ghost,
  link,
}

enum PrimitiveButtonSize {
  sm,
  md,
  lg,
  icon,
}

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

  bool get _effectiveDisabled => widget.isDisabled || widget.isLoading || widget.onPressed == null;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.97).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
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

    // --- 1. Resolve Styles based on Variant ---
    Color backgroundColor;
    Color foregroundColor;
    Border? border;

    switch (widget.variant) {
      case PrimitiveButtonVariant.primary:
        backgroundColor = colorScheme.primary;
        foregroundColor = colorScheme.onPrimary;
        if (_isHovered) backgroundColor = colorScheme.primary.withOpacity(0.9);
        break;
      case PrimitiveButtonVariant.secondary:
        backgroundColor = colorScheme.secondary;
        foregroundColor = colorScheme.onSecondary;
        if (_isHovered) backgroundColor = colorScheme.secondary.withOpacity(0.8);
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
        if (_isHovered) backgroundColor = colorScheme.surfaceContainerHighest.withOpacity(0.5);
        break;
      case PrimitiveButtonVariant.ghost:
        backgroundColor = Colors.transparent;
        foregroundColor = colorScheme.onSurface;
        if (_isHovered) backgroundColor = colorScheme.surfaceContainerHighest.withOpacity(0.5);
        break;
      case PrimitiveButtonVariant.link:
        backgroundColor = Colors.transparent;
        foregroundColor = colorScheme.primary;
        if (_isHovered) {
          // In a real web link, this might be underline, but for now we just dim/shift
          foregroundColor = colorScheme.primary.withOpacity(0.8);
        }
        break;
    }

    if (_effectiveDisabled) {
      backgroundColor = widget.variant == PrimitiveButtonVariant.ghost ||
              widget.variant == PrimitiveButtonVariant.link || 
              widget.variant == PrimitiveButtonVariant.outline
          ? Colors.transparent
          : colorScheme.onSurface.withOpacity(0.12);
      foregroundColor = colorScheme.onSurface.withOpacity(0.38);
      if (widget.variant == PrimitiveButtonVariant.outline) {
        border = Border.all(color: colorScheme.onSurface.withOpacity(0.12));
      }
    }

    // --- 2. Resolve Size ---
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
        height = 40;
        padding = EdgeInsets.zero; // Square aspect ratio handled by width=height constraint
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

    // --- 3. Construct Content ---
    Widget content;
    if (widget.isLoading) {
      content = SizedBox(
        width: iconSize,
        height: iconSize,
        child: CircularProgressIndicator(
          strokeWidth: 2,
          color: foregroundColor,
        ),
      );
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
                  fontWeight: FontWeight.w500),
              child: widget.child!,
            ),
          ],
        );
      }
    } else {
      List<Widget> children = [];
      if (widget.leading != null) {
        children.add(IconTheme(
          data: IconThemeData(size: iconSize, color: foregroundColor),
          child: widget.leading!,
        ));
        if (widget.child != null) children.add(const SizedBox(width: 8));
      }

      if (widget.child != null) {
        children.add(DefaultTextStyle(
          style: TextStyle(
            color: foregroundColor,
            fontSize: fontSize,
            fontWeight: FontWeight.w500,
            decoration: widget.variant == PrimitiveButtonVariant.link && _isHovered
              ? TextDecoration.underline
              : TextDecoration.none,
          ),
          child: widget.child!,
        ));
      }

      if (widget.trailing != null) {
        if (widget.child != null) children.add(const SizedBox(width: 8));
        children.add(IconTheme(
          data: IconThemeData(size: iconSize, color: foregroundColor),
          child: widget.trailing!,
        ));
      }

      content = Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: children,
      );
    }

    // --- 4. Build Structure ---
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: _effectiveDisabled
          ? SystemMouseCursors.forbidden
          : SystemMouseCursors.click,
      child: GestureDetector(
        onTapDown: _handleTapDown,
        onTapUp: _handleTapUp,
        onTapCancel: _handleTapCancel,
        child: ScaleTransition(
          scale: _scaleAnimation,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 150),
            height: height,
            width: widget.size == PrimitiveButtonSize.icon ? height : null, // Square if icon
            padding: widget.size == PrimitiveButtonSize.icon ? EdgeInsets.zero : padding,
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
