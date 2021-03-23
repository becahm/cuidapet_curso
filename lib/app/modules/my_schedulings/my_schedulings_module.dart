import 'my_schedulings_controller.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'my_schedulings_page.dart';

class MySchedulingsModule extends ChildModule {
  static final route = '/my_scheduling';
  @override
  List<Bind> get binds => [
        Bind((i) => MySchedulingsController(i.get())),
      ];

  @override
  List<ModularRouter> get routers => [
        ModularRouter(Modular.initialRoute,
            child: (_, args) => MySchedulingsPage()),
      ];

  static Inject get to => Inject<MySchedulingsModule>.of();
}
