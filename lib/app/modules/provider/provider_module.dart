import 'provider_controller.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'provider_page.dart';

class ProviderModule extends ChildModule {
  static final route = '/provider';

  @override
  List<Bind> get binds => [
        Bind((i) => ProviderController(i.get())),
      ];

  @override
  List<ModularRouter> get routers => [
        ModularRouter(Modular.initialRoute,
            child: (_, args) => ProviderPage(providerId: args.data)),
      ];

  static Inject get to => Inject<ProviderModule>.of();
}
