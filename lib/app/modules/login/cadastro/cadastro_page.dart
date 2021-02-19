import 'package:cuidapet_curso/app/shared/theme_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'cadastro_controller.dart';

class CadastroPage extends StatefulWidget {
  final String title;
  const CadastroPage({Key key, this.title = "Cadastro"}) : super(key: key);

  @override
  _CadastroPageState createState() => _CadastroPageState();
}

class _CadastroPageState
    extends ModularState<CadastroPage, CadastroController> {
  //use 'controller' variable to access controller

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastrar usuário'),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      backgroundColor: ThemeUtils.primaryColor,
      body: Container(
        width: ScreenUtil.screenWidthDp,
        height: ScreenUtil.screenHeightDp,
        child: Stack(
          children: [
            Container(
              width: ScreenUtil.screenWidthDp,
              height: ScreenUtil.screenHeightDp * 0.95,
              child: Image.asset(
                'lib/assets/images/login_background.png',
                fit: BoxFit.fill,
              ),
            ),
            Container(
              width: double.infinity,
              child: Column(
                children: [
                  Image.asset(
                    'lib/assets/images/logo.png',
                    fit: BoxFit.fill,
                    width: ScreenUtil().setWidth(400),
                  ),
                  _buildForm(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildForm() {
    return Form(
      key: controller.formKey,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            TextFormField(
              controller: controller.loginController,
              decoration: InputDecoration(
                labelText: 'Login',
                labelStyle: TextStyle(fontSize: 15),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  gapPadding: 0,
                ),
              ),
              validator: (value) {
                if (value.isEmpty) {
                  return 'Login obrigatório!';
                } else {
                  return null;
                }
              },
            ),
            SizedBox(
              height: 20,
            ),
            Observer(builder: (_) {
              return TextFormField(
                controller: controller.senhaController,
                obscureText: controller.obscureTextSenha,
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                    icon: Icon(Icons.lock),
                    onPressed: () => controller.showPassword(),
                  ),
                  labelText: 'Senha',
                  labelStyle: TextStyle(fontSize: 15),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    gapPadding: 0,
                  ),
                ),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Senha obrigatória!';
                  } else if (value.length < 6) {
                    return 'Senha deve ter pelo menos 6 caracteres';
                  } else {
                    return null;
                  }
                },
              );
            }),
            SizedBox(
              height: 20,
            ),
            Observer(builder: (_) {
              return TextFormField(
                controller: controller.confirmarSenhaController,
                obscureText: controller.obscureTextConfirmaSenha,
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                    icon: Icon(Icons.lock),
                    onPressed: () => controller.showConfirmPassword(),
                  ),
                  labelText: 'Confirmar Senha',
                  labelStyle: TextStyle(fontSize: 15),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    gapPadding: 0,
                  ),
                ),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Confirmar Senha obrigatória!';
                  } else if (value.length < 6) {
                    return 'Confirmar Senha deve ter pelo menos 6 caracteres';
                  } else if (value != controller.senhaController.text) {
                    return 'As senhas não conferem!';
                  } else {
                    return null;
                  }
                },
              );
            }),
            SizedBox(
              height: 20,
            ),
            Container(
              width: ScreenUtil.screenWidthDp,
              height: 50,
              child: RaisedButton(
                onPressed: () async {
                  controller.register();
                },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
                color: ThemeUtils.primaryColor,
                child: Text(
                  'Cadastrar',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
