import 'package:dartz/dartz.dart';
import 'package:music_player_v1/core/common/entities/user.dart';
import 'package:music_player_v1/core/error/failures.dart';
import 'package:music_player_v1/features/auth/data/datasources/auth_supabase_datasource.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class AuthRepository {

  Future<Either<Failure, UserEntity>> signUp(
      {required String name, required String email, required String password});

  Future<Either<Failure, UserEntity>> signIn({required String email, required String password});

  Future<Either<Failure, UserEntity>> currentUser();
}
