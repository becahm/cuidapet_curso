import 'package:cuidapet_curso/app/models/chat_model.dart';
import 'package:cuidapet_curso/app/models/chat_msg_model.dart';
import 'package:cuidapet_curso/app/services/chat_service.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

part 'chat_detail_controller.g.dart';

@Injectable()
class ChatDetailController = _ChatDetailControllerBase
    with _$ChatDetailController;

abstract class _ChatDetailControllerBase with Store {
  final ChatService _chatService;

  _ChatDetailControllerBase(this._chatService);

  final messageController = TextEditingController();

  @observable
  ChatModel chat;

  @observable
  ObservableStream<List<ChatMsgModel>> messages;

  @action
  void getMessagens(ChatModel model) {
    chat = model;
    final msgs = _chatService.getMessagens(chat);
    messages = msgs.asObservable();
  }

  @action
  void sendMessage() {
    if (messageController.text.isNotEmpty) {
      _chatService.sendMessage(chat, messageController.text);
      messageController.text = '';
    }
  }
}
