import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:music_player_v1/core/common/entities/user.dart';
import 'package:music_player_v1/core/routes/app_routes.dart';
import 'package:music_player_v1/features/auth/domain/repository/auth_repository.dart';
import 'package:music_player_v1/features/auth/domain/usecases/current_user.dart';
import 'package:music_player_v1/features/auth/domain/usecases/sign_up_usecase.dart';
import 'package:music_player_v1/features/auth/presentation/pages/auth_home_page.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../../domain/usecases/sign_in_usecase.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final SignUpUseCase signUpUseCase;

  final SignInUseCase signInUseCase;

  final CurrentUserUseCase currentUserUseCase;
  final AuthRepository authRepository;

  AuthCubit(
      {required this.signUpUseCase,
      required this.signInUseCase,
      required this.currentUserUseCase,
      required this.authRepository})
      : super(AuthInitial());

  Future<void> onAuthSignUp(UserSignUpParams params) async {
    emit(AuthLoading());
    final result = await signUpUseCase.call(params);
    result.fold((failure) => emit(AuthFailure(failure)),
        (user) => emit(AuthSuccess(user)));
  }

  Future<void> onAuthSignIn(UserSignInParams params) async {
    emit(AuthLoading());
    final result = await signInUseCase.call(params);
    result.fold((failure) => emit(AuthFailure(failure)),
        (user) => emit(AuthSuccess(user)));
  }

  Future<void> getCurrentUser() async {
    emit(AuthLoading());
    final result = await currentUserUseCase.call(NoParams());

    result.fold(
      (failure) => emit(AuthFailure(failure)),
      (user) => emit(AuthSuccess(user)),
    );
  }

  Future<void> onAuthLogout(BuildContext context) async {
    emit(AuthLoading());  // Indicate that logout is in progress
    try {
      await authRepository.userLogout();  // Perform logout via the repository
      emit(AuthInitial());  // Reset authentication state

      // Navigate to the AuthHomePage (login or authentication page)
      AppRoutes.pushReplacement(context, const AuthHomePage());
    } catch (e) {
      emit(AuthFailure(Failure(e.toString())));  // Handle failure if logout fails
    }
  }

}
