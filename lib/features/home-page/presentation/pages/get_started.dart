import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:music_player_v1/core/common/widgets/basic_button.dart';
import 'package:music_player_v1/core/config/assets-config/app_images.dart';
import 'package:music_player_v1/core/theme/app_palette.dart';

import '../../../../core/config/assets-config/app_vector.dart';
import '../../../../core/routes/app_routes.dart';
import 'choose_mode_page.dart';

class GetStartedPage extends StatelessWidget {
  const GetStartedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        Container(
          padding:const EdgeInsets.all(40),
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(AppImages.introBgImage),
                  fit: BoxFit.cover)),
        ),
        Container(
          color: Colors.black.withOpacity(0.15),
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
                "Enjoy Listening to Music",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppPalette.whiteColor,
                    fontSize: 18),
              ),
              const SizedBox(
                height: 21,
              ),
              const Text(
                "Lorem ipsum dolor sit amet, consectetur a dipiscing elit. Cras volutpat molestie justo eu gravida. Quisque pharetra quam tempus, laoreet ligula ut, vulputate turpis. ",
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: AppPalette.grayColor,
                    fontSize: 13),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 20,
              ),
              BasicButton(
                onPressed: () {
                  AppRoutes.push(context, const ChooseModePage());
                },
                text: "Get Started",
              )
            ],
          ),
        ),
      ],
    ));
  }
}
