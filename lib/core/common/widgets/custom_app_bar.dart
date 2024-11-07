import 'package:flutter/material.dart';

import '../../theme/is_dark_mode.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget? title;
  final bool hideBackBtn;
  const CustomAppBar({super.key, this.title, this.hideBackBtn = false});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      shadowColor: Colors.transparent, // Removes any shadow or hint of color
      scrolledUnderElevation: 0, // Ensures no color on scroll
      centerTitle: true,
      title: title ?? const Text(""),
      leading: hideBackBtn ? null : IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: Container(
          height: 40,
          width: 40,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isDarkMode(context)
                ? Colors.white.withOpacity(0.03)
                : Colors.black.withOpacity(.06),
          ),
          child: Icon(
            Icons.arrow_back_ios_sharp,
            color: isDarkMode(context) ? Colors.white : Colors.black,
            size: 18,
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}