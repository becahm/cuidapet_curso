import 'package:cuidapet_curso/app/models/chat_model.dart';
import 'package:cuidapet_curso/app/services/chat_service.dart';
import 'package:mobx/mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

part 'chat_controller.g.dart';

@Injectable()
class ChatController = _ChatControllerBase with _$ChatController;

abstract class _ChatControllerBase with Store {
  final ChatService _chatService;

  _ChatControllerBase(this._chatService);

  @observable
  ObservableFuture<List<ChatModel>> chatsFuture;

  @action
  void getChats() {
    chatsFuture = ObservableFuture(_chatService.getUserChats());
  }
}
