import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:music_player_v1/core/common/entities/user.dart';
import 'package:music_player_v1/features/auth/domain/usecases/sign_up_usecase.dart';

import '../../../../core/error/failures.dart';
import '../../domain/usecases/sign_in_usecase.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {

  final SignUpUseCase signUpUseCase ;
  final SignInUseCase signInUseCase ;
  AuthCubit({required this.signUpUseCase,required this.signInUseCase}) : super(AuthInitial());



  Future<void> onAuthSignUp(UserSignUpParams params)async{
    emit(AuthLoading());
    final result = await signUpUseCase.call(params);
    result.fold((failure)=>emit(AuthFailure(failure)), (user)=>emit(AuthSuccess(user)));
  }

  Future<void> onAuthSignIn(UserSignInParams params)async{
    emit(AuthLoading());
    final result = await signInUseCase.call(params);
    result.fold((failure)=>emit(AuthFailure(failure)), (user)=>emit(AuthSuccess(user)));
  }
}
