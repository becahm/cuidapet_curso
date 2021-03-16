import 'scheduling_controller.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'scheduling_page.dart';

class SchedulingModule extends ChildModule {
  static final route = '/scheduling';

  @override
  List<Bind> get binds => [
        $SchedulingController,
      ];

  @override
  List<ModularRouter> get routers => [
        ModularRouter(Modular.initialRoute,
            child: (_, args) => SchedulingPage(
                  services: args.data['services'],
                  providerId: args.data['providerId'],
                )),
      ];

  static Inject get to => Inject<SchedulingModule>.of();
}
