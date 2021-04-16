// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_controller.dart';

// **************************************************************************
// InjectionGenerator
// **************************************************************************

final $ChatController = BindInject(
  (i) => ChatController(i<ChatService>()),
  singleton: true,
  lazy: true,
);

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ChatController on _ChatControllerBase, Store {
  final _$chatsFutureAtom = Atom(name: '_ChatControllerBase.chatsFuture');

  @override
  ObservableFuture<List<ChatModel>> get chatsFuture {
    _$chatsFutureAtom.reportRead();
    return super.chatsFuture;
  }

  @override
  set chatsFuture(ObservableFuture<List<ChatModel>> value) {
    _$chatsFutureAtom.reportWrite(value, super.chatsFuture, () {
      super.chatsFuture = value;
    });
  }

  final _$_ChatControllerBaseActionController =
      ActionController(name: '_ChatControllerBase');

  @override
  void getChats() {
    final _$actionInfo = _$_ChatControllerBaseActionController.startAction(
        name: '_ChatControllerBase.getChats');
    try {
      return super.getChats();
    } finally {
      _$_ChatControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
chatsFuture: ${chatsFuture}
    ''';
  }
}
