import 'package:cuidapet_curso/app/core/database/connection.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_modular/flutter_modular.dart';

class ConnectionADM extends WidgetsBindingObserver with Disposable {
  var conn = Connection();

  ConnectionADM() {
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        break;
      case AppLifecycleState.inactive:
        conn.closeConnection();

        break;
      case AppLifecycleState.paused:
        conn.closeConnection();

        break;
      case AppLifecycleState.detached:
        conn.closeConnection();

        break;
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
  }
}
