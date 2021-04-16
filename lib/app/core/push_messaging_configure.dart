import 'dart:io';

import 'package:cuidapet_curso/app/repository/shared_prefs_repository.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class PushMessagingConfigure {
  FirebaseMessaging _fcm = FirebaseMessaging();

  Future<void> configure() async {
    if (Platform.isIOS) {
      await _fcm.requestNotificationPermissions();
    }
    _fcm.configure(
      onMessage: (Map<String, dynamic> message) async {
        print('onMessage: $message');
      },
      onLaunch: (Map<String, dynamic> message) async {
        print('onLaunch: $message');
      },
      onResume: (Map<String, dynamic> message) async {
        print('onResume: $message');
      },
    );

    String deviceId = await _fcm.getToken();
    final prefs = await SharedPrefsRepository.instance;
    prefs.registerDeviceId(deviceId);
  }
}
