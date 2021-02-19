import 'package:cuidapet_curso/app/modules/home/addresses/detail/detail_page.dart';
import 'detail/detail_controller.dart';
import 'addresses_controller.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'addresses_page.dart';

class AddressesModule extends ChildModule {
  static final route = '/addresses';
  @override
  List<Bind> get binds => [
        Bind((i) => DetailController(i.get())),
        Bind((i) => AddressesController(i.get())),
      ];

  @override
  List<ModularRouter> get routers => [
        ModularRouter(Modular.initialRoute,
            child: (_, args) => AddressesPage()),
        ModularRouter(DetailPage.route,
            child: (_, args) => DetailPage(
                  addressModel: args.data,
                )),
      ];

  static Inject get to => Inject<AddressesModule>.of();
}
