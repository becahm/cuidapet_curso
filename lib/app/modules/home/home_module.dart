import 'package:cuidapet_curso/app/modules/home/addresses/addresses_module.dart';
import 'package:cuidapet_curso/app/modules/provider/provider_module.dart';
import 'package:cuidapet_curso/app/repository/categories_repository.dart';
import 'package:cuidapet_curso/app/services/categories_service.dart';

import 'home_controller.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'home_page.dart';

class HomeModule extends ChildModule {
  static final route = '/home';

  @override
  List<Bind> get binds => [
        Bind((i) => CategoriesRepository()),
        Bind((i) => CategoriesService(i.get())),
        Bind((i) => HomeController(i.get(), i.get(), i.get())),
      ];

  @override
  List<ModularRouter> get routers => [
        ModularRouter(Modular.initialRoute, child: (_, args) => HomePage()),
        //ModularRouter(AddressesModule.route, module: AddressesModule()),
      ];

  static Inject get to => Inject<HomeModule>.of();
}
