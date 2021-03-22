import 'package:cuidapet_curso/app/models/acess_token_model.dart';
import 'package:cuidapet_curso/app/models/user_model.dart';
import 'package:cuidapet_curso/app/repository/facebook_repository.dart';
import 'package:cuidapet_curso/app/repository/secure_storage_repository.dart';
import 'package:cuidapet_curso/app/repository/shared_prefs_repository.dart';
import 'package:cuidapet_curso/app/repository/user_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';

class UserService {
  final UserRepository _repository;

  UserService(this._repository);

  Future<void> login(bool facebookLogin,
      {String email, String password}) async {
    try {
      final prefs = await SharedPrefsRepository.instance;
      final fireAuth = FirebaseAuth.instance;
      AcessTokenModel acessTokenModel;

      if (!facebookLogin) {
        acessTokenModel = await _repository.login(
          email,
          password: password,
          facebookLogin: facebookLogin,
          avatar: '',
        );

        await fireAuth.signInWithEmailAndPassword(
            email: email, password: password);
      } else {
        var facebookModel = await FacebookRepository().login();
        if (facebookModel != null) {
          acessTokenModel = await _repository.login(
            facebookModel.email,
            password: password,
            facebookLogin: facebookLogin,
            avatar: facebookModel.picture,
          );
          final facebookCredential = FacebookAuthProvider.getCredential(
              accessToken: facebookModel.token);
          await fireAuth.signInWithCredential(facebookCredential);
        } else {
          throw Exception();
        }
      }

      prefs.registerAcessToken(acessTokenModel.acessToken);

      final confirmModel = await _repository.confirmLogin();
      await prefs.registerAcessToken(confirmModel.acessToken);
      SecureStorageRepository().registerRefreshToken(confirmModel.refreshToken);
      final userData = await _repository.getUserData();
      await prefs.registerUserData(userData);
    } on PlatformException catch (e) {
      print('Erro ao fazer login no Firebase: $e');
    } catch (e, s) {
      print('Erro ao fazer login: $e');
      print('printando s: $s');
      rethrow;
    }
  }

  Future<void> register(String email, String password) async {
    await _repository.register(email, password);
    var fireAuth = FirebaseAuth.instance;
    await fireAuth.createUserWithEmailAndPassword(
        email: email, password: password);
  }

  Future<UserModel> updateProfileImage(String imageUrl) {
    return _repository.updateProfileImage(imageUrl);
  }
}
