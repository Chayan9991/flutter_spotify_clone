import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:music_player_v1/core/config/assets-config/app_vector.dart';
import 'package:music_player_v1/core/routes/app_routes.dart';

import '../../../home-page/presentation/pages/get_started.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {

  @override
  void initState() {
    super.initState();
    redirect();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SvgPicture.asset(AppVector.spotifyLogo), // SVG image
      ),
    );
  }

  // Redirect function
  Future<void> redirect() async {
    await Future.delayed(const Duration(seconds: 2));
    AppRoutes.pushReplacement(context, const GetStartedPage());
  }
}
