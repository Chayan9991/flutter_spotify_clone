import 'package:dartz/dartz.dart';
import 'package:music_player_v1/core/common/entities/user.dart';
import 'package:music_player_v1/core/usecases/usecase.dart';
import 'package:music_player_v1/features/auth/domain/repository/auth_repository.dart';
import 'package:music_player_v1/service_locator.dart';

import '../../../../core/error/failures.dart';

class CurrentUserUseCase extends UseCase<UserEntity, NoParams> {
  final AuthRepository authRepository;
  CurrentUserUseCase(this.authRepository);

  @override
  Future<Either<Failure, UserEntity>> call(NoParams params) async {
    return await authRepository.currentUser();
  }
}
