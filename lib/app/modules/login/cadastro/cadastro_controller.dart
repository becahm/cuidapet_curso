import 'package:cuidapet_curso/app/services/user_service.dart';
import 'package:cuidapet_curso/app/shared/components/loader.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobx/mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

part 'cadastro_controller.g.dart';

@Injectable()
class CadastroController = _CadastroControllerBase with _$CadastroController;

abstract class _CadastroControllerBase with Store {
  final UserService _service;
  GlobalKey<FormState> formKey = GlobalKey();
  var loginController = TextEditingController();
  var senhaController = TextEditingController();
  var confirmarSenhaController = TextEditingController();

  @observable
  bool obscureTextSenha = true;
  @observable
  bool obscureTextConfirmaSenha = true;

  _CadastroControllerBase(this._service);

  @action
  void showPassword() => obscureTextSenha = !obscureTextSenha;

  @action
  void showConfirmPassword() =>
      obscureTextConfirmaSenha = !obscureTextConfirmaSenha;

  @action
  Future<void> register() async {
    if (formKey.currentState.validate()) {
      try {
        Loader.show();
        await _service.register(loginController.text, senhaController.text);
        Loader.hide();
        Modular.to.pop();
      } catch (e) {
        Loader.hide();

        print('Erro de login : ${e.response.data}');
        Get.snackbar('Erro', 'Erro ao cadastrar usuário!');
      }
    }
  }
}
