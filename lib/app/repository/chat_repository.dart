import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cuidapet_curso/app/core/dio/custom_dio.dart';
import 'package:cuidapet_curso/app/models/chat_model.dart';
import 'package:cuidapet_curso/app/models/chat_msg_model.dart';

class ChatRepository {
  final _firestore = Firestore.instance;

  Future<List<ChatModel>> getUserChats() {
    return CustomDio.authInstance.get('/chats/usuario').then((res) =>
        res.data.map<ChatModel>((c) => ChatModel.fromJson(c)).toList());
  }

  Stream<List<ChatMsgModel>> getMessages(ChatModel chat) {
    return _firestore
        .collection('chat')
        .document(chat.id.toString())
        .collection('messages')
        .orderBy('data_mensagem', descending: false)
        .snapshots()
        .map((querySnapshot) {
      return querySnapshot.documents
          .map((m) => ChatMsgModel(
              usuario: m['usuario'],
              fornecedor: m['fornecedor'],
              mensagem: m['mensagem']))
          .toList();
    });
  }

  void sendMessage(ChatModel chat, String message) {
    final data = <String, dynamic>{
      'mensagem': message,
      'data_mensagem': DateTime.now(),
      'usuario': chat.usuario
    };
    _firestore
        .collection('chat')
        .document(chat.id.toString())
        .collection('messages')
        .add(data);
  }

  void notifyUser(ChatModel chat, String message) {
    CustomDio.authInstance.post('/chats/notificar',
        data: {'chat': chat.id, 'mensagem': message, 'para': 'F'});
  }
}
