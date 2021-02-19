import 'package:cuidapet_curso/app/core/database/connection_adm.dart';
import 'package:cuidapet_curso/app/modules/home/home_module.dart';
import 'package:cuidapet_curso/app/modules/login/login_module.dart';
import 'package:cuidapet_curso/app/modules/main/main_page.dart';
import 'package:cuidapet_curso/app/repository/address_repository.dart';
import 'package:cuidapet_curso/app/repository/provider_repository.dart';
import 'package:cuidapet_curso/app/repository/user_repository.dart';
import 'package:cuidapet_curso/app/services/address_service.dart';
import 'package:cuidapet_curso/app/services/provider_service.dart';
import 'package:cuidapet_curso/app/services/user_service.dart';
import 'package:cuidapet_curso/app/shared/auth_store.dart';
import 'app_controller.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter/material.dart';
import 'package:cuidapet_curso/app/app_widget.dart';

class AppModule extends MainModule {
  @override
  List<Bind> get binds => [
        Bind((i) => ConnectionADM(), lazy: false),
        Bind((i) => AppController()),
        Bind((i) => UserRepository()),
        Bind((i) => UserService(i.get())),
        Bind((i) => AddressRepository()),
        Bind((i) => AddressService(i.get())),
        Bind((i) => ProviderRepository()),
        Bind((i) => ProviderService(i.get())),
        Bind((i) => AuthStore()),
      ];

  @override
  List<ModularRouter> get routers => [
        ModularRouter(
          Modular.initialRoute,
          child: (context, args) => MainPage(),
        ),
        ModularRouter(
          HomeModule.route,
          module: HomeModule(),
        ),
        ModularRouter(
          LoginModule.route,
          module: LoginModule(),
        )
      ];

  @override
  Widget get bootstrap => AppWidget();

  static Inject get to => Inject<AppModule>.of();
}
