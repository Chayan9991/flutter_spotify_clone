
import 'package:firebase_auth/firebase_auth.dart';
import 'package:music_player_v1/core/error/server_exception.dart';
import 'package:music_player_v1/features/auth/data/model/user_model.dart';

abstract class AuthFirebaseDatasource {

  Future<UserModel> signUpWithEmailPassword(
      {required String name, required String email, required String password});

  Future<UserModel> signInWithEmailPassword(
      {required String email, required String password});

  Future<UserModel> getCurrentUser();
}

class AuthFirebaseDatasourceImpl implements AuthFirebaseDatasource {


  @override
  Future<UserModel> signUpWithEmailPassword(
      {required String name, required String email, required String password}) async {
    try {
      final response = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
          email: email, password: password);

      final user = response.user;

      if (user == null) {
        throw const ServerException("User is Null");
      }

      //Update the user's display name
      await user.updateDisplayName(name);
      await user.reload();

      return UserModel(
          name: user.displayName ?? name, id: user.uid, email: user.email ?? email);

    } on FirebaseAuthException catch (e) {
      throw ServerException(e.code);
    }
  }

  @override
  Future<UserModel> getCurrentUser() async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      throw const ServerException("Can't find user");
    }

    return UserModel(
      id: user.uid,
      email: user.email ?? "",
      name: user.displayName ?? "",
    );
  }

  @override
  Future<UserModel> signInWithEmailPassword({required String email, required String password}) async{

    try{
      final response = await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
      final user = response.user;

      if(user == null){
        throw const ServerException("User is null");
      }
      return UserModel(id: user.uid, email: user.email ?? "No Email Found", name: user.displayName ?? "No Display Name Found");
    }on FirebaseAuthException catch (e){
      throw ServerException(e.code);
    }
  }



}
