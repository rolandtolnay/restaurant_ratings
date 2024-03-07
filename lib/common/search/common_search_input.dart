import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../translations/locale_keys.g.dart';
import '../widgets/common_text_field.dart';

class CommonSearchInput extends HookConsumerWidget {
  const CommonSearchInput({
    super.key,
    required this.controller,
    this.hintText,
    this.onChanged,
    this.hasPrefixIcon = true,
    this.autofocus = true,
  });

  final TextEditingController controller;
  final ValueChanged<String>? onChanged;

  final String? hintText;
  final bool hasPrefixIcon;
  final bool autofocus;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    useListenable(controller);

    final focusNode = useFocusNode();

    return CommonTextField(
      controller: controller,
      autofocus: autofocus,
      focusNode: focusNode,
      hintText: hintText ?? tr(LocaleKeys.search),
      onChanged: (input) => onChanged?.call(input),
      prefixIcon: hasPrefixIcon
          ? const SizedBox.square(
              dimension: 20,
              child: Center(
                child: Icon(Icons.search, size: 20),
              ),
            )
          : null,
      suffixIcon: Visibility(
        visible: controller.text.isNotEmpty,
        child: InkWell(
          onTap: () {
            controller.clear();
            onChanged?.call('');
            focusNode.requestFocus();
          },
          child: const SizedBox.square(
            dimension: 20,
            child: Center(
              child: Icon(Icons.cancel_outlined, size: 20),
            ),
          ),
        ),
      ),
    );
  }
}
