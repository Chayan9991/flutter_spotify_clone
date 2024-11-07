import 'package:dartz/dartz.dart';
import 'package:music_player_v1/core/error/failures.dart';
import 'package:music_player_v1/core/usecases/usecase.dart';
import 'package:music_player_v1/features/auth/domain/repository/auth_repository.dart';
import 'package:music_player_v1/service_locator.dart';

import '../../../../core/common/entities/user.dart';

class SignUpUseCase implements UseCase<UserEntity, UserSignUpParams> {

  final AuthRepository authRepository;
  SignUpUseCase(this.authRepository);
  @override
  Future<Either<Failure, UserEntity>> call(
      UserSignUpParams params) async {
    return await authRepository.signUp(
        name: params.name, email: params.email, password: params.password);
  }
}

class UserSignUpParams {
  final String email;
  final String password;
  final String name;

  UserSignUpParams(
      {required this.email, required this.password, required this.name});
}
