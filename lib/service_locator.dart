import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'core/common/entities/user.dart';
import 'core/secrets/app_secrets.dart';
import 'core/usecases/usecase.dart';
import 'features/auth/data/datasources/auth_firebase_datasource.dart';
import 'features/auth/data/datasources/auth_supabase_datasource.dart';
import 'features/auth/data/repositories/auth_repo_impl.dart';
import 'features/auth/domain/repository/auth_repository.dart';
import 'features/auth/domain/usecases/current_user.dart';
import 'features/auth/domain/usecases/sign_in_usecase.dart';
import 'features/auth/domain/usecases/sign_up_usecase.dart';
import 'features/home-page/data/datasources/song_datasource.dart';
import 'features/home-page/data/repositories/songs_repositoryImpl.dart';
import 'features/home-page/domain/repositories/song_repository.dart';
import 'features/home-page/domain/usecases/get_all_songs.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependency() async {
  // Initializing Supabase
  final supabase = await Supabase.initialize(
    url: AppSecrets.supabaseUrl,
    anonKey: AppSecrets.anonKey,
  );
  serviceLocator.registerLazySingleton(() => supabase.client);

  // Register Firebase Auth Data Sources
  serviceLocator.registerSingleton<AuthFirebaseDatasource>(AuthFirebaseDatasourceImpl());

  // Register Supabase Auth Data Sources
  serviceLocator.registerSingleton<AuthSupabaseDatasource>(AuthSupabaseDataSourceImpl(serviceLocator()));

  // Register Supabase Song Data Sources
  serviceLocator.registerSingleton<SongDataSource>(SongDataSourceImpl(serviceLocator()));

  // Register Repositories
  serviceLocator.registerSingleton<AuthRepository>(AuthRepoImpl(serviceLocator()));
  serviceLocator.registerSingleton<SongRepository>(SongRepositoryImpl(serviceLocator()));

  // Register Use Cases
  serviceLocator.registerSingleton<UseCase<UserEntity, UserSignUpParams>>(
    SignUpUseCase(serviceLocator()),
  );
  serviceLocator.registerSingleton<UseCase<UserEntity, UserSignInParams>>(
    SignInUseCase(serviceLocator()),
  );

  // Also register specific types for direct access by AuthCubit
  serviceLocator.registerSingleton<SignUpUseCase>(
    SignUpUseCase(serviceLocator()),
  );
  serviceLocator.registerSingleton<SignInUseCase>(
    SignInUseCase(serviceLocator()),
  );

  // Register other Use Cases
  serviceLocator.registerSingleton<CurrentUserUseCase>(
    CurrentUserUseCase(serviceLocator()),
  );
  serviceLocator.registerSingleton<GetAllSongsUseCase>(
    GetAllSongsUseCase(serviceLocator()),
  );
}
