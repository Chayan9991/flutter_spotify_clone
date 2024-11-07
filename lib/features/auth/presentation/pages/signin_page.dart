import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:music_player_v1/core/usecases/usecase.dart';
import 'package:music_player_v1/features/auth/domain/usecases/sign_in_usecase.dart';
import 'package:music_player_v1/features/auth/presentation/bloc/auth_cubit.dart';
import 'package:music_player_v1/features/auth/presentation/pages/signup_page.dart';
import 'package:music_player_v1/service_locator.dart';

import '../../../../core/common/entities/user.dart';
import '../../../../core/common/widgets/basic_button.dart';
import '../../../../core/common/widgets/custom_app_bar.dart';
import '../../../../core/common/widgets/text_input_field.dart';
import '../../../../core/config/assets-config/app_vector.dart';
import '../../../../core/routes/app_routes.dart';
import '../../../../core/theme/app_palette.dart';
import '../../../../core/utils/show_snackbar.dart';
import '../../../home-page/presentation/pages/home_page.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
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
            height: MediaQuery
                .of(context)
                .size
                .height, // Sets the height to screen height
            alignment: Alignment.center, // Centers content vertically
            child: BlocConsumer<AuthCubit, AuthState>(
              listener: (context, state) {
                if (state is AuthFailure) {
                  showSnackBar(context, state.failure.message);
                } else if (state is AuthSuccess) {
                  AppRoutes.pushAndRemoveUntil(context, HomePage());
                }
              },
              builder: (context, state) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    _signInText(),
                    const SizedBox(height: 30),
                    Form(
                      child: Column(
                        children: [
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
                          if (state is AuthLoading) const CircularProgressIndicator(),
                          if (state is! AuthLoading)
                            BasicButton(
                              onPressed: () async {
                                final params = UserSignInParams(
                                    email: emailController.text.trim(),
                                    password: passwordController.text.trim());

                                if (emailController.text.trim().isEmpty || passwordController.text.trim().isEmpty) {
                                  showSnackBar(context, "Please enter both email and password");
                                } else {
                                  context.read<AuthCubit>().onAuthSignIn(params);
                                }

                              },
                              text: "Sign In",
                            ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    _signUpText(context)
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _signInText() {
    return const Text(
      "Sign In",
      style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
      textAlign: TextAlign.center,
    );
  }

  Widget _signUpText(BuildContext context) {
    return GestureDetector(
      onTap: () {
        AppRoutes.pushReplacement(context, const SignupPage());
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            "Not A Member?",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Theme
                    .of(context)
                    .brightness == Brightness.dark
                    ? AppPalette.grayColor
                    : Colors.black54),
          ),
          const Text(
            " Register Now",
            style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }
}
