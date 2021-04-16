import 'package:cuidapet_curso/app/modules/chat/chat_detail/chat_detail_module.dart';
import 'package:cuidapet_curso/app/modules/chat/chat_detail/chat_detail_page.dart';

import 'chat_controller.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'chat_page.dart';

class ChatModule extends ChildModule {
  static final route = '/chat';
  @override
  List<Bind> get binds => [
        Bind((i) => ChatController(i())),
      ];

  @override
  List<ModularRouter> get routers => [
        ModularRouter(Modular.initialRoute, child: (_, args) => ChatPage()),
        ModularRouter(ChatDetailModule.route, module: ChatDetailModule()),
      ];

  static Inject get to => Inject<ChatModule>.of();
}
