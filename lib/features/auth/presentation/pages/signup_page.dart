import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:music_player_v1/core/common/entities/user.dart';
import 'package:music_player_v1/core/common/widgets/basic_button.dart';
import 'package:music_player_v1/core/common/widgets/custom_app_bar.dart';
import 'package:music_player_v1/core/common/widgets/text_input_field.dart';
import 'package:music_player_v1/core/config/assets-config/app_vector.dart';
import 'package:music_player_v1/core/routes/app_routes.dart';
import 'package:music_player_v1/core/usecases/usecase.dart';
import 'package:music_player_v1/core/utils/show_snackbar.dart';
import 'package:music_player_v1/features/auth/domain/usecases/sign_up_usecase.dart';
import 'package:music_player_v1/features/auth/presentation/bloc/auth_cubit.dart';
import 'package:music_player_v1/features/auth/presentation/pages/signin_page.dart';
import 'package:music_player_v1/features/home-page/presentation/pages/home_page.dart';
import 'package:music_player_v1/service_locator.dart';

import '../../../../core/theme/app_palette.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final fullNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    fullNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: SvgPicture.asset(
          AppVector.spotifyLogo,
          height: 40,
          width: 40,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context)
                .size
                .height, // Sets the height to screen height
            alignment: Alignment.center, // Centers content vertically
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _registerText(),
                const SizedBox(height: 30),
                BlocConsumer<AuthCubit, AuthState>(
                  listener: (context, state) {
                    if (state is AuthFailure) {
                      showSnackBar(context, state.failure.message);
                    }
                    if (state is AuthSuccess) {
                      AppRoutes.pushAndRemoveUntil(context, HomePage());
                    }
                  },
                  builder: (context, state) {
                    return Form(
                      child: Column(
                        children: [
                          TextInputField(
                            textController: fullNameController,
                            hintText: "Full Name",
                            obscureText: false,
                          ),
                          const SizedBox(height: 15),
                          TextInputField(
                            textController: emailController,
                            hintText: "Email",
                            obscureText: false,
                          ),
                          const SizedBox(height: 15),
                          TextInputField(
                            textController: passwordController,
                            hintText: "Password",
                            obscureText: false,
                          ),
                          const SizedBox(height: 30),
                          if (state is AuthLoading)
                            const CircularProgressIndicator(),
                          if (state is! AuthLoading)
                            BasicButton(
                              onPressed: () async {
                                final params = UserSignUpParams(
                                    email: emailController.text.trim(),
                                    password: passwordController.text.trim(),
                                    name: fullNameController.text.trim());

                                if (emailController.text.trim().isEmpty ||
                                    passwordController.text.trim().isEmpty ||
                                    fullNameController.text.trim().isEmpty) {
                                  showSnackBar(context,
                                      "Please enter the fields");
                                } else {
                                  context
                                      .read<AuthCubit>()
                                      .onAuthSignUp(params);
                                }
                              },
                              text: "Create Account",
                            ),
                        ],
                      ),
                    );
                  },
                ),
                const SizedBox(
                  height: 40,
                ),
                _signInText(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _registerText() {
    return const Text(
      "Register",
      style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
      textAlign: TextAlign.center,
    );
  }

  Widget _signInText(BuildContext context) {
    return GestureDetector(
      onTap: () {
        AppRoutes.pushReplacement(context, const SignInPage());
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            "Already have an Account?",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).brightness == Brightness.dark
                    ? AppPalette.grayColor
                    : Colors.black54),
          ),
          const Text(
            " Sign In",
            style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }
}
