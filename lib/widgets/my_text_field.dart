import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  const MyTextField({
    super.key,
    this.enabled = true,
    this.readOnly = false,
    this.hintText = 'hint',
    this.autofocus = false,
    this.textInputAction = TextInputAction.search,
    this.onSubmitted,
    required this.controller
  });

  final bool enabled;
  final bool readOnly;
  final String hintText;
  final bool autofocus;
  final TextInputAction textInputAction;
  final void Function(String value)? onSubmitted;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextField(
      autofocus: autofocus,
      textInputAction: textInputAction,
      enabled: enabled,
      readOnly: readOnly,
      textAlign: TextAlign.end,
      controller: controller,
      style: TextStyle(
        overflow: TextOverflow.ellipsis,
        fontSize: 35,
        // height: 1,
        fontWeight: FontWeight.w500,
        color: Theme.of(context).colorScheme.onSurface
      ),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.zero,
        border: InputBorder.none,
        hintText: hintText,
        hintStyle: const TextStyle(
          fontSize: 35,
          height: 1,
          fontWeight: FontWeight.w500
        )
      ),
      onSubmitted: (value) {
        if (onSubmitted != null) {
          onSubmitted!(value);
        }
      },
    );
  }
}