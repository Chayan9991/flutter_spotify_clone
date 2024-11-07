import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

class ThemeCubit extends HydratedCubit<ThemeMode> {
  ThemeCubit() : super(ThemeMode.system); // Default theme mode

  // Method to update the theme
  void updateTheme(ThemeMode themeMode) => emit(themeMode);

  @override
  ThemeMode? fromJson(Map<String, dynamic> json) {
    // Deserialize the theme mode from JSON
    switch (json['theme'] as String?) {
      case 'ThemeMode.light':
        return ThemeMode.light;
      case 'ThemeMode.dark':
        return ThemeMode.dark;
      default:
        return ThemeMode.system; // Default case if no valid mode is found
    }
  }

  @override
  Map<String, dynamic>? toJson(ThemeMode state) {
    // Serialize the current theme mode to JSON
    return {'theme': state.toString()};
  }
}
