import 'package:cuidapet_curso/app/models/chat_model.dart';
import 'package:cuidapet_curso/app/models/chat_msg_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'chat_detail_controller.dart';

class ChatDetailPage extends StatefulWidget {
  final ChatModel chat;
  const ChatDetailPage({Key key, @required this.chat}) : super(key: key);

  @override
  _ChatDetailPageState createState() => _ChatDetailPageState(chat);
}

class _ChatDetailPageState
    extends ModularState<ChatDetailPage, ChatDetailController> {
  final ChatModel chat;

  _ChatDetailPageState(this.chat);

  @override
  void initState() {
    super.initState();
    controller.getMessagens(chat);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.chat.fornecedor.nome),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Observer(builder: (_) {
              final List<ChatMsgModel> msgs = controller.messages?.data;
              if (msgs == null) {
                return SizedBox.shrink();
              }
              return ListView.builder(
                shrinkWrap: true,
                itemCount: msgs.length,
                itemBuilder: (context, index) {
                  final msg = msgs[index];
                  if (msg.fornecedor != null) {
                    return ListTile(
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(chat.fornecedor.logo),
                      ),
                      title: Text(chat.fornecedor.nome),
                      subtitle: Text(msg.mensagem),
                    );
                  } else {
                    return ListTile(
                      title: Text(chat.nome, textAlign: TextAlign.end),
                      subtitle: Text(
                        msg.mensagem,
                        textAlign: TextAlign.end,
                      ),
                    );
                  }
                },
              );
            }),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 20),
            padding: EdgeInsets.all(10),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: controller.messageController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30)),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CircleAvatar(
                    minRadius: 25,
                    child: IconButton(
                        icon: Icon(Icons.send),
                        onPressed: () => controller.sendMessage()),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
