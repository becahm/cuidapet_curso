import 'package:cuidapet_curso/app/modules/main/main_page.dart';
import 'package:cuidapet_curso/app/services/user_service.dart';
import 'package:cuidapet_curso/app/shared/components/loader.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobx/mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

part 'login_controller.g.dart';

@Injectable()
class LoginController = _LoginControllerBase with _$LoginController;

abstract class _LoginControllerBase with Store {
  final UserService _service;
  GlobalKey<FormState> formKey = GlobalKey();
  var loginController = TextEditingController();
  var senhaController = TextEditingController();

  @observable
  bool obscureText = true;

  _LoginControllerBase(this._service);

  @action
  void showPassword() {
    obscureText = !obscureText;
  }

  @action
  Future<void> login() async {
    if (formKey.currentState.validate()) {
      try {
        Loader.show();
        await _service.login(false,
            email: loginController.text, password: senhaController.text);
        Loader.hide();
        Modular.to.pushReplacementNamed(MainPage.route);
      } catch (e) {
        Loader.hide();

        //print('Erro de login : ${e.response.data}');
        Get.snackbar('Erro', 'Erro ao efetuar login!');
      }
    }
  }

  @action
  Future<void> facebookLogin() async {
    try {
      Loader.show();
      await _service.login(true);
      Loader.hide();
      Modular.to.pushReplacementNamed(MainPage.route);
    } catch (e) {
      Loader.hide();

      //print('Erro de login : ${e.response.data}');
      Get.snackbar('Erro', 'Erro ao efetuar login!');
    }
  }
}
