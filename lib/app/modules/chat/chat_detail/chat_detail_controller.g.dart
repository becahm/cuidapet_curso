// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_detail_controller.dart';

// **************************************************************************
// InjectionGenerator
// **************************************************************************

final $ChatDetailController = BindInject(
  (i) => ChatDetailController(i<ChatService>()),
  singleton: true,
  lazy: true,
);

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ChatDetailController on _ChatDetailControllerBase, Store {
  final _$chatAtom = Atom(name: '_ChatDetailControllerBase.chat');

  @override
  ChatModel get chat {
    _$chatAtom.reportRead();
    return super.chat;
  }

  @override
  set chat(ChatModel value) {
    _$chatAtom.reportWrite(value, super.chat, () {
      super.chat = value;
    });
  }

  final _$messagesAtom = Atom(name: '_ChatDetailControllerBase.messages');

  @override
  ObservableStream<List<ChatMsgModel>> get messages {
    _$messagesAtom.reportRead();
    return super.messages;
  }

  @override
  set messages(ObservableStream<List<ChatMsgModel>> value) {
    _$messagesAtom.reportWrite(value, super.messages, () {
      super.messages = value;
    });
  }

  final _$_ChatDetailControllerBaseActionController =
      ActionController(name: '_ChatDetailControllerBase');

  @override
  void getMessagens(ChatModel model) {
    final _$actionInfo = _$_ChatDetailControllerBaseActionController
        .startAction(name: '_ChatDetailControllerBase.getMessagens');
    try {
      return super.getMessagens(model);
    } finally {
      _$_ChatDetailControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void sendMessage() {
    final _$actionInfo = _$_ChatDetailControllerBaseActionController
        .startAction(name: '_ChatDetailControllerBase.sendMessage');
    try {
      return super.sendMessage();
    } finally {
      _$_ChatDetailControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
chat: ${chat},
messages: ${messages}
    ''';
  }
}
