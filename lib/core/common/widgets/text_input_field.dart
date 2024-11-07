import 'package:flutter/material.dart';
import 'package:music_player_v1/core/theme/app_palette.dart';

class TextInputField extends StatelessWidget {
  final TextEditingController textController;

  final String hintText;

  final bool obscureText;

  const TextInputField(
      {super.key,
      required this.textController,
      required this.hintText,
      required this.obscureText});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: textController,
      obscureText: obscureText,
      decoration: InputDecoration(
          hintText: hintText,
          hintStyle: const TextStyle(color: AppPalette.grayColor)),

    );
  }
}
