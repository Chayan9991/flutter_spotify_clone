import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:music_player_v1/core/common/widgets/custom_app_bar.dart';
import 'package:music_player_v1/core/config/assets-config/app_images.dart';
import 'package:music_player_v1/core/config/assets-config/app_vector.dart';
import 'package:music_player_v1/core/routes/app_routes.dart';
import 'package:music_player_v1/core/theme/is_dark_mode.dart';
import 'package:music_player_v1/features/auth/presentation/pages/signin_page.dart';
import 'package:music_player_v1/features/auth/presentation/pages/signup_page.dart';
import 'package:music_player_v1/features/home-page/presentation/pages/local_song_page.dart';

import '../../../../core/common/widgets/basic_button.dart';
import '../../../../core/theme/app_palette.dart';

class AuthHomePage extends StatelessWidget {
  const AuthHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const CustomAppBar(),
          Align(
            alignment: Alignment.topRight,
            child: SvgPicture.asset(AppVector.topPattern),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: SvgPicture.asset(AppVector.bottomPattern),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Image.asset(AppImages.authBgImage),
          ),
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.all(40),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Spotify Logo
                  SvgPicture.asset(
                    AppVector.spotifyLogo,
                    height: 80, // Adjusted size for better visibility
                  ),
                  const SizedBox(height: 40),

                  // Main Title
                  const Text(
                    "Enjoy Listening To Music",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 26,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),

                  // Description
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 32.0), // Added padding for better readability
                    child: Text(
                      "Spotify is a proprietary Swedish audio streaming and media service provider.",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: AppPalette.grayColor,
                        fontSize: 14,
                        height: 1.5, // Adjusted line height for readability
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 30),

                  // Register & Sign In Buttons
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: BasicButton(
                            onPressed: () {
                              AppRoutes.push(context, const SignupPage());
                            },
                            text: "Register",
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () {
                              AppRoutes.push(context, const SignInPage());
                            },
                            style: OutlinedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              side: BorderSide(
                                color: isDarkMode(context) ? AppPalette.whiteColor : Colors.black,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: Text(
                              "Sign In",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: isDarkMode(context) ? AppPalette.whiteColor : Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 25),

                  // Or Text Divider
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Divider(
                          color: Colors.grey.shade400,
                          thickness: 1,
                          indent: 30,
                          endIndent: 15,
                        ),
                      ),
                      const Text("Or"),
                      Expanded(
                        child: Divider(
                          color: Colors.grey.shade400,
                          thickness: 1,
                          indent: 15,
                          endIndent: 30,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),

                  // Offline Music Text
                  GestureDetector(
                    onTap: (){AppRoutes.pushAndRemoveUntil(context,const LocalSongPage());},
                    child: Text(
                      "Enjoy Local Music Offline",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: isDarkMode(context) ? AppPalette.grayColor : Colors.black54,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
