import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:music_player_v1/core/theme/app_theme.dart';
import 'package:music_player_v1/features/auth/presentation/bloc/auth_cubit.dart';
import 'package:music_player_v1/features/home-page/presentation/bloc/song-bloc/song_cubit.dart';
import 'package:music_player_v1/features/home-page/presentation/bloc/theme_cubit.dart';
import 'package:music_player_v1/features/splash-page/presentation/pages/splash_page.dart';
import 'package:music_player_v1/firebase_options.dart';
import 'package:music_player_v1/service_locator.dart';
import 'package:path_provider/path_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: kIsWeb
        ? HydratedStorage.webStorageDirectory
        : await getApplicationDocumentsDirectory(),
  );
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await initDependency();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => ThemeCubit()),
        BlocProvider(create: (_)=>SongCubit(serviceLocator())),
        BlocProvider(create: (_)=>AuthCubit(signUpUseCase: serviceLocator(), signInUseCase: serviceLocator())),
      ],
      child: BlocBuilder<ThemeCubit, ThemeMode>(
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            darkTheme: AppTheme.darkTheme,
            themeMode: state,
            theme: AppTheme.lightTheme,
               home: const SplashPage(),

          );
        },
      ),
    );
  }
}
