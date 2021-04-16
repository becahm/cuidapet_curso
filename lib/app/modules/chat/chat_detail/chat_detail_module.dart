import 'chat_detail_controller.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'chat_detail_page.dart';

class ChatDetailModule extends ChildModule {
  static final route = '/chatDetail';
  @override
  List<Bind> get binds => [
        Bind((i) => ChatDetailController(i())),
      ];

  @override
  List<ModularRouter> get routers => [
        ModularRouter(Modular.initialRoute,
            child: (_, args) => ChatDetailPage(chat: args.data)),
      ];

  static Inject get to => Inject<ChatDetailModule>.of();
}
