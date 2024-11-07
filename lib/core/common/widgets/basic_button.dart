import 'package:flutter/material.dart';
import 'package:music_player_v1/core/theme/app_palette.dart';

class BasicButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final double ? height;
  const BasicButton({super.key, required this.onPressed, this.height, required this.text});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        minimumSize: Size.fromHeight(height??80),
      ),
        onPressed: onPressed, child: Text(text, style:const TextStyle(color: AppPalette.whiteColor),)
    );
  }
}
