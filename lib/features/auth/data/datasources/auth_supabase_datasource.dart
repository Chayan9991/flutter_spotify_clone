import 'package:music_player_v1/core/error/server_exception.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../model/user_model.dart';

abstract interface class AuthSupabaseDatasource {
  Session? get currentUserSession;

  Future<UserModel> signUpWithEmailPassword(
      {required String name, required String email, required String password});

  Future<UserModel> signInWithEmailPassword(
      {required String email, required String password});

  Future<UserModel> getCurrentUser();
}

class AuthSupabaseDataSourceImpl implements AuthSupabaseDatasource {
  final SupabaseClient supabaseClient;
  AuthSupabaseDataSourceImpl(this.supabaseClient);

  @override
  Session? get currentUserSession => supabaseClient.auth.currentSession;

  @override
  Future<UserModel> getCurrentUser() async{

    User? user = supabaseClient.auth.currentUser;

    if(user == null){
      throw const ServerException("No user signed in");
    }

    return UserModel(id: user.id, email: user.email ?? "", name: user.userMetadata?['name'] ?? "");
    
  }

  @override
  Future<UserModel> signInWithEmailPassword(
      {required String email, required String password}) async {
    try {
      final response = await supabaseClient.auth
          .signInWithPassword(password: password, email: email);
      final user = response.user;
      if (user == null) {
        throw const ServerException("User is null");
      }
      print(user);
      return UserModel(
          id: user.id, email: user.email!, name: user.userMetadata?['name']);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<UserModel> signUpWithEmailPassword(
      {required String name,
      required String email,
      required String password}) async {
    try {
      final response = await supabaseClient.auth
          .signUp(password: password, email: email, data: {'name': name} );
      final user = response.user;
      if (user == null) {
        throw const ServerException("User is null");
      }
      return UserModel(
          id: user.id, email: user.email!, name: user.userMetadata?['name']);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
