import 'package:cuidapet_curso/app/models/chat_model.dart';
import 'package:cuidapet_curso/app/models/chat_msg_model.dart';
import 'package:cuidapet_curso/app/repository/chat_repository.dart';

class ChatService {
  final ChatRepository _repository;

  ChatService(this._repository);

  Future<List<ChatModel>> getUserChats() {
    return _repository.getUserChats();
  }

  Stream<List<ChatMsgModel>> getMessagens(ChatModel chat) {
    return _repository.getMessages(chat);
  }

  void sendMessage(ChatModel chat, String message) {
    _repository.sendMessage(chat, message);
    _repository.notifyUser(chat, message);
  }
}
