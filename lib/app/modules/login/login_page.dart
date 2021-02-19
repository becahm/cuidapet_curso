import 'package:cuidapet_curso/app/core/database/connection.dart';
import 'package:cuidapet_curso/app/modules/login/cadastro/cadastro_module.dart';
import 'package:cuidapet_curso/app/shared/components/facebook_button.dart';
import 'package:cuidapet_curso/app/shared/theme_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'login_controller.dart';

class LoginPage extends StatefulWidget {
  final String title;
  const LoginPage({Key key, this.title = "Login"}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends ModularState<LoginPage, LoginController> {
  @override
  void initState() {
    super.initState();
    testConnection();
  }

  Future<void> testConnection() async {
    var db = await Connection().instance;
    var result = await db.rawQuery('select * from endereco');
    print(result);
  }
  //use 'controller' variable to access controller

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeUtils.primaryColor,
      body: SingleChildScrollView(
        child: Container(
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
                margin: EdgeInsets.only(top: ScreenUtil.statusBarHeight + 30),
                width: double.infinity,
                child: Column(
                  children: [
                    Image.asset(
                      'lib/assets/images/logo.png',
                      fit: BoxFit.fill,
                      width: ScreenUtil().setWidth(400),
                    ),
                    Text(DotEnv().env['profile']),
                    _buildForm(),
                  ],
                ),
              )
            ],
          ),
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
                obscureText: controller.obscureText,
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
            Container(
              width: ScreenUtil.screenWidthDp,
              height: 50,
              child: RaisedButton(
                onPressed: () async {
                  controller.login();
                },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
                color: ThemeUtils.primaryColor,
                child: Text(
                  'Entrar',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.white),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                children: [
                  Expanded(
                    child: Divider(
                      color: ThemeUtils.primaryColor,
                      thickness: 1,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15, right: 15),
                    child: Text(
                      'ou',
                      style: TextStyle(
                          color: ThemeUtils.primaryColor,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Expanded(
                    child: Divider(
                      color: ThemeUtils.primaryColor,
                      thickness: 1,
                    ),
                  )
                ],
              ),
            ),
            FacebookButton(
              onTap: () => controller.facebookLogin(),
            ),
            FlatButton(
              onPressed: () => Modular.link.pushNamed(CadastroModule.route),
              child: Text('Cadastre-se'),
            )
          ],
        ),
      ),
    );
  }
}
