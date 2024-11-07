
import 'package:flutter/material.dart';
import 'package:music_player_v1/core/error/firebase_error_handler.dart';

void showSnackBar(BuildContext context, String e) {

  String errorMessage  = getFirebaseAuthErrorMessage(e) ;

  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(SnackBar(content: Text(errorMessage, style: const TextStyle(fontWeight: FontWeight.bold),)));
}
