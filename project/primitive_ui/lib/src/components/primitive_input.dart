import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

enum PrimitiveInputVariant {
  outline,
  filled,
  flushed,
}

enum PrimitiveInputSize {
  sm,
  md,
  lg,
}

class PrimitiveInput extends StatefulWidget {
  final TextEditingController? controller;
  final String? placeholder;
  final String? label; // Rendered outside or inside? Shadcn usually puts label outside. We'll handle placeholder only for "Input".
  final bool obscureText;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final bool autofocus;
  final bool enabled;
  final bool hasError;
  final Widget? leading;
  final Widget? trailing;
  final PrimitiveInputVariant variant;
  final PrimitiveInputSize size;

  const PrimitiveInput({
    super.key,
    this.controller,
    this.placeholder,
    this.label,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.textInputAction = TextInputAction.done,
    this.onChanged,
    this.onSubmitted,
    this.autofocus = false,
    this.enabled = true,
    this.hasError = false,
    this.leading,
    this.trailing,
    this.variant = PrimitiveInputVariant.outline,
    this.size = PrimitiveInputSize.md,
  });

  @override
  State<PrimitiveInput> createState() => _PrimitiveInputState();
}

class _PrimitiveInputState extends State<PrimitiveInput> {
  late TextEditingController _controller;
  late FocusNode _focusNode;
  bool _isFocused = false;
  bool _isHovered = false;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();
    _focusNode = FocusNode();
    _focusNode.addListener(_handleFocusChange);
  }

  @override
  void dispose() {
    _focusNode.removeListener(_handleFocusChange);
    _focusNode.dispose();
    if (widget.controller == null) {
      _controller.dispose();
    }
    super.dispose();
  }

  void _handleFocusChange() {
    setState(() {
      _isFocused = _focusNode.hasFocus;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    // --- Resolve Styles ---
    Color borderColor;
    Color backgroundColor;
    double borderWidth = 1.0;
    
    // Base Colors
    if (widget.variant == PrimitiveInputVariant.filled) {
      backgroundColor = colorScheme.surfaceContainerHighest.withOpacity(0.5);
      borderColor = Colors.transparent;
    } else if (widget.variant == PrimitiveInputVariant.flushed) {
      backgroundColor = Colors.transparent;
      borderColor = colorScheme.outline.withOpacity(0.5);
    } else {
      // Outline
      backgroundColor = Colors.transparent;
      borderColor = colorScheme.outline.withOpacity(0.5);
    }

    // State Overrides
    if (widget.hasError) {
      borderColor = colorScheme.error;
    } else if (_isFocused) {
      borderColor = colorScheme.primary;
      borderWidth = widget.variant == PrimitiveInputVariant.flushed ? 2.0 : 2.0;
    } else if (_isHovered && widget.enabled) {
      borderColor = colorScheme.outline;
    }

    if (!widget.enabled) {
      backgroundColor = colorScheme.onSurface.withOpacity(0.04);
      borderColor = colorScheme.outline.withOpacity(0.2);
    }

    // Size Params
    double height;
    double fontSize;
    EdgeInsets contentPadding;

    switch (widget.size) {
      case PrimitiveInputSize.sm:
        height = 32;
        fontSize = 12;
        contentPadding = const EdgeInsets.symmetric(horizontal: 8, vertical: 8);
        break;
      case PrimitiveInputSize.lg:
        height = 48;
        fontSize = 16;
        contentPadding = const EdgeInsets.symmetric(horizontal: 16, vertical: 12);
        break;
      case PrimitiveInputSize.md:
      default:
        height = 40;
        fontSize = 14;
        contentPadding = const EdgeInsets.symmetric(horizontal: 12, vertical: 10);
        break;
    }

    // --- Build Decorations ---
    final borderDecoration = BoxDecoration(
      color: backgroundColor,
      border: widget.variant == PrimitiveInputVariant.flushed
          ? Border(bottom: BorderSide(color: borderColor, width: borderWidth))
          : Border.all(color: borderColor, width: borderWidth),
      borderRadius: widget.variant == PrimitiveInputVariant.flushed
          ? null
          : BorderRadius.circular(6),
    );

    final textStyle = TextStyle(
      fontSize: fontSize,
      color: widget.enabled ? colorScheme.onSurface : colorScheme.onSurface.withOpacity(0.38),
    );

    final placeholderStyle = TextStyle(
      fontSize: fontSize,
      color: colorScheme.onSurface.withOpacity(0.38),
    );

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: widget.enabled ? SystemMouseCursors.text : SystemMouseCursors.forbidden,
      child: GestureDetector(
        onTap: widget.enabled ? () => _focusNode.requestFocus() : null,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          height: height,
          decoration: borderDecoration,
          padding: EdgeInsets.symmetric(horizontal: widget.variant == PrimitiveInputVariant.flushed ? 0 : 0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (widget.leading != null) ...[
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: IconTheme(
                    data: IconThemeData(
                      size: fontSize + 2,
                      color: colorScheme.onSurface.withOpacity(0.5),
                    ),
                    child: widget.leading!,
                  ),
                ),
              ],
              Expanded(
                child: Padding(
                  padding: contentPadding,
                  child: Stack(
                    alignment: Alignment.centerLeft,
                    children: [
                      // Placeholder
                      if ((_controller.text.isEmpty) && widget.placeholder != null)
                        Padding(
                          padding: const EdgeInsets.only(left: 1), // Minor optical adjustment
                          child: Text(
                            widget.placeholder!,
                            style: placeholderStyle,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      // Actual Input
                      EditableText(
                        controller: _controller,
                        focusNode: _focusNode,
                        style: textStyle,
                        cursorColor: colorScheme.primary,
                        backgroundCursorColor: colorScheme.surface,
                        obscureText: widget.obscureText,
                        keyboardType: widget.keyboardType,
                        textInputAction: widget.textInputAction,
                        onChanged: (val) {
                          setState(() {}); // Rebuild to hide/show placeholder
                          widget.onChanged?.call(val);
                        },
                        onSubmitted: widget.onSubmitted,
                        autofocus: widget.autofocus,
                        readOnly: !widget.enabled,
                        selectionControls: materialTextSelectionControls,
                        rendererIgnoresPointer: !widget.enabled, // IMPORTANT
                        cursorWidth: 1.5,
                        maxLines: 1,
                      ),
                    ],
                  ),
                ),
              ),
              if (widget.trailing != null) ...[
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: IconTheme(
                    data: IconThemeData(
                      size: fontSize + 2,
                      color: colorScheme.onSurface.withOpacity(0.5),
                    ),
                    child: widget.trailing!,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
