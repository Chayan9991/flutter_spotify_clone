import 'package:dartz/dartz.dart';
import 'package:music_player_v1/core/common/entities/user.dart';
import 'package:music_player_v1/core/error/server_exception.dart';
import 'package:music_player_v1/features/auth/data/datasources/auth_firebase_datasource.dart';
import 'package:music_player_v1/features/auth/domain/repository/auth_repository.dart';
import 'package:music_player_v1/service_locator.dart';

import '../../../../core/error/failures.dart';
import '../datasources/auth_supabase_datasource.dart';

class AuthRepoImpl implements AuthRepository {
  final AuthSupabaseDatasource authSupabaseDatasource;

  AuthRepoImpl(this.authSupabaseDatasource);

  @override
  Future<Either<Failure, UserEntity>> signUp(
      {required String name,
      required String email,
      required String password}) async {
    try {
      final user = await authSupabaseDatasource.signUpWithEmailPassword(
          name: name, email: email, password: password);

      return Right(UserEntity(email: user.email, name: user.name, id: user.id));

      /*  Firebase Sign Up Method
      final user = await serviceLocator<AuthFirebaseDatasource>()
          .signUpWithEmailPassword(
              name: name, email: email, password: password);
      return Right(UserEntity(email: user.email, name: user.name, id: user.id));  */
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> signIn(
      {required String email, required String password}) async {
    try {

      final user = await authSupabaseDatasource.signInWithEmailPassword(
          email: email, password: password);
      return Right(UserEntity(email: user.email, name: user.name, id: user.id));

      /*  Firebase Sign In Method
      final user = await serviceLocator<AuthFirebaseDatasource>()
          .signInWithEmailPassword(email: email, password: password);
      return Right(UserEntity(email: user.email, name: user.name, id: user.id));
      */
    } on ServerException catch (e) {
      return Left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> currentUser() async {
    try {
      final user =
          await serviceLocator<AuthFirebaseDatasource>().getCurrentUser();
      return Right(UserEntity(id: user.id, email: user.email, name: user.name));
    } on ServerException catch (e) {
      return Left(Failure(e.message));
    }
  }
}
