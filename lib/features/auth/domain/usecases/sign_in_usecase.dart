import 'package:dartz/dartz.dart';
import 'package:music_player_v1/core/common/entities/user.dart';
import 'package:music_player_v1/core/error/failures.dart';
import 'package:music_player_v1/core/usecases/usecase.dart';
import 'package:music_player_v1/features/auth/domain/repository/auth_repository.dart';
import 'package:music_player_v1/service_locator.dart';

class SignInUseCase extends UseCase<UserEntity, UserSignInParams>{
  final AuthRepository authRepository;
  SignInUseCase(this.authRepository);

  @override
  Future<Either<Failure, UserEntity>> call(UserSignInParams params) async{
    return await authRepository.signIn(email: params.email, password: params.password);
  }

}

class UserSignInParams {
  final String email;
  final String password;
  UserSignInParams({required this.email, required this.password});
}