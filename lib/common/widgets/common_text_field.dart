import 'package:flutter/material.dart';

import '../extensions/build_context_extension.dart';

class CommonTextField extends StatelessWidget {
  const CommonTextField({
    super.key,
    required this.controller,
    this.padding = const EdgeInsets.symmetric(
      horizontal: 14,
      vertical: 16,
    ),
    this.onSubmitted,
    this.hintText,
    this.suffixIcon,
    this.prefixIcon,
    this.maxLines = 1,
    this.minLines = 1,
    this.autofocus = true,
    this.onChanged,
    this.onEditingComplete,
    this.onTap,
    this.onTapOutside,
    this.focusNode,
    this.label,
    this.style,
    this.maxLength,
    this.textCapitalization = TextCapitalization.none,
    this.keyboardType,
    this.textInputAction,
    this.autofillHints,
  });

  final String? label;
  final TextEditingController controller;
  final String? hintText;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final int maxLines;
  final int minLines;
  final bool autofocus;
  final EdgeInsetsGeometry padding;

  final TextStyle? style;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final VoidCallback? onEditingComplete;
  final VoidCallback? onTap;
  final TapRegionCallback? onTapOutside;
  final FocusNode? focusNode;
  final int? maxLength;
  final TextCapitalization textCapitalization;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final Iterable<String>? autofillHints;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Visibility(
          visible: label != null,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Text(label ?? ''),
          ),
        ),
        TextFormField(
          controller: controller,
          autofocus: autofocus,
          focusNode: focusNode,
          autofillHints: autofillHints,
          decoration: InputDecoration(
            contentPadding: padding,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide:
                  BorderSide(color: context.colorScheme.primaryContainer),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(color: context.colorScheme.primary),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide:
                  BorderSide(color: context.colorScheme.primaryContainer),
            ),
            hoverColor: context.colorScheme.surface.withOpacity(0.4),
            fillColor: context.colorScheme.background,
            filled: true,
            counter: maxLength == null ? const SizedBox.shrink() : null,
            hintText: hintText,
            hintStyle: style?.copyWith(
              fontWeight: FontWeight.w400,
              color: context.disabledColor,
            ),
            suffixIcon: suffixIcon,
            prefixIcon: prefixIcon,
          ),
          style: style ?? context.textTheme.bodyMedium,
          onEditingComplete: onEditingComplete,
          onChanged: onChanged,
          onFieldSubmitted: onSubmitted,
          onTap: onTap,
          onTapOutside: onTapOutside,
          maxLines: maxLines,
          minLines: minLines,
          maxLength: maxLength,
          textCapitalization: textCapitalization,
          keyboardType: keyboardType,
          textInputAction: textInputAction,
        ),
      ],
    );
  }
}
