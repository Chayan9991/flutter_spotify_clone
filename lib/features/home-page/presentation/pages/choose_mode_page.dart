import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:music_player_v1/core/routes/app_routes.dart';
import 'package:music_player_v1/features/auth/presentation/pages/auth_home_page.dart';
import 'package:music_player_v1/features/home-page/presentation/bloc/theme_cubit.dart';
import '../../../../core/common/widgets/basic_button.dart';
import '../../../../core/config/assets-config/app_images.dart';
import '../../../../core/config/assets-config/app_vector.dart';
import '../../../../core/theme/app_palette.dart';

class ChooseModePage extends StatelessWidget {
  const ChooseModePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        Container(
          padding: const EdgeInsets.all(40),
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(AppImages.chooseModeBg),
                  fit: BoxFit.cover)),
        ),
        Container(
          color: Colors.black.withOpacity(0.1),
        ),
        Padding(
          padding: const EdgeInsets.all(40),
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              Align(
                  alignment: Alignment.topCenter,
                  child: SvgPicture.asset(AppVector.spotifyLogo)),
              const Spacer(),
              const Text(
                "Choose Mode",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppPalette.whiteColor,
                    fontSize: 20),
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      ClipOval(
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
                          child: Container(
                            height: 60,
                            width: 60,
                            decoration: BoxDecoration(
                              color: Colors.grey.withOpacity(.2),
                            ),
                            child: IconButton(
                                onPressed: () {
                                  context.read<ThemeCubit>().updateTheme(ThemeMode.light);
                                },
                                icon: SvgPicture.asset(AppVector.sunLogo)),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 7,
                      ),
                      const Text(
                        "Light Mode",
                        style: TextStyle(
                            color: AppPalette.whiteColor,
                            fontSize: 13,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  Column(
                    children: [
                      ClipOval(
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
                          child: Container(
                            height: 60,
                            width: 60,
                            decoration: BoxDecoration(
                              color: Colors.grey.withOpacity(.2),
                            ),
                            child: IconButton(
                                onPressed: () {
                                  context.read<ThemeCubit>().updateTheme(ThemeMode.dark);
                                },
                                icon: SvgPicture.asset(AppVector.moonLogo)),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 7,
                      ),
                      const Text(
                        "Dark Mode",
                        style: TextStyle(
                            color: AppPalette.whiteColor,
                            fontSize: 13,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 80,
              ),
              BasicButton(
                onPressed: () {
                  AppRoutes.push(context,const AuthHomePage());
                },
                text: "Continue",
              )
            ],
          ),
        ),
      ],
    ));
  }
}
