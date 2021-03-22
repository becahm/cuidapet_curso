import 'dart:io';

import 'package:cuidapet_curso/app/core/dio/custom_dio.dart';
import 'package:cuidapet_curso/app/models/acess_token_model.dart';
import 'package:cuidapet_curso/app/models/confirm_login_model.dart';
import 'package:cuidapet_curso/app/models/user_model.dart';
import 'package:cuidapet_curso/app/repository/shared_prefs_repository.dart';

class UserRepository {
  Future<AcessTokenModel> login(String email,
      {String password, bool facebookLogin = false, avatar = ''}) {
    return CustomDio.instance.post('/login', data: {
      'login': email,
      'senha': password,
      'facebookLogin': facebookLogin,
      'avatar': avatar
    }).then((res) => AcessTokenModel.fromJson(res.data));
  }

  Future<ConfirmLoginModel> confirmLogin() async {
    final prefs = await SharedPrefsRepository.instance;
    final deviceId = prefs.acessDeviceId;

    return CustomDio.authInstance.patch('/login/confirmar', data: {
      'ios_token': Platform.isIOS ? deviceId : null,
      'android_token': Platform.isAndroid ? deviceId : null,
    }).then((value) => ConfirmLoginModel.fromJson(value.data));
  }

  Future<UserModel> getUserData() {
    return CustomDio.authInstance
        .get('/usuario')
        .then((res) => UserModel.fromJson(res.data));
  }

  Future<void> register(String email, String password) async {
    await CustomDio.instance.post('/login/cadastrar', data: {
      'email': email,
      'senha': password,
    });
  }

  Future<UserModel> updateProfileImage(String imageUrl) {
    return CustomDio.authInstance.put('/usuario/avatar', data: {
      'url_avatar': imageUrl
    }).then((res) => UserModel.fromJson(res.data));
  }
}
