import 'package:cuidapet_curso/app/models/chat_model.dart';
import 'package:cuidapet_curso/app/modules/chat/chat_detail/chat_detail_module.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'chat_controller.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({Key key}) : super(key: key);

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends ModularState<ChatPage, ChatController> {
  //use 'controller' variable to access controller
  @override
  void initState() {
    super.initState();
    controller.getChats();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chats'),
      ),
      body: FutureBuilder<List<ChatModel>>(
          future: controller.chatsFuture,
          builder: (context, snapshot) {
            final chats = snapshot.data;
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                return Container();
                break;
              case ConnectionState.waiting:
              case ConnectionState.active:
                return Center(
                  child: CircularProgressIndicator(),
                );
                break;
              case ConnectionState.done:
                if (snapshot.hasError) {
                  return Center(
                    child: Text('Erro ao carregar Chats.'),
                  );
                }
                if (snapshot.hasData && chats.isEmpty) {
                  return Center(child: Text('Você ainda não possui chats!'));
                }

                if (snapshot.hasData) {
                  return _buildChatList(chats);
                } else {
                  return Container();
                }

                break;
              default:
                return Container();
            }
          }),
    );
  }

  Widget _buildChatList(List<ChatModel> chats) {
    return ListView.separated(
      itemCount: chats.length,
      separatorBuilder: (_, __) => Divider(),
      itemBuilder: (context, index) {
        final chat = chats[index];
        return ListTile(
          onTap: () =>
              Modular.link.pushNamed(ChatDetailModule.route, arguments: chat),
          title: Text(chat.fornecedor.nome),
          subtitle: Text(chat.nomePet),
          leading: CircleAvatar(
            backgroundImage: NetworkImage(chat.fornecedor.logo),
          ),
        );
      },
    );
  }
}
