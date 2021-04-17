import 'dart:io';

import 'package:cuidapet_curso/app/repository/shared_prefs_repository.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class PushMessagingConfigure {
  final FirebaseMessaging _fcm = FirebaseMessaging();
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> configure() async {
    final initializationSettingsAndroid =
        AndroidInitializationSettings('ic_launcher');
    final initializationSettingsIOS = IOSInitializationSettings(
        onDidReceiveLocalNotification: _onDidReceiveLocalNotification);
    final initializationSettings = InitializationSettings(
        initializationSettingsAndroid, initializationSettingsIOS);
    await _flutterLocalNotificationPlugin.initialize(initializationSettings);
    final androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'br.com.rebecamotta.cuidapet_curso',
      'cuidapet_curso',
      'Cuidapet',
      importance: Importance.Max,
      priority: Priority.High,
      ticker: 'ticker',
    );

    final iOSplatformChannelSpecifics = IOSNotificationDetails();

    final platformChannelSpecifics = NotificationDetails(
        androidPlatformChannelSpecifics, iOSplatformChannelSpecifics);

    if (Platform.isIOS) {
      await _fcm.requestNotificationPermissions(IosNotificationSettings());
      _fcm.onIosSettingsRegistered.listen((settings) {
        print('Configurações do ios registradas $settings');
      });
    }
    _fcm.configure(
      onMessage: (Map<String, dynamic> message) async {
        print('onMessage: $message');
        await _flutterLocalNotificationPlugin.show(
          99,
          message['notification']['title'],
          message['notification']['body'],
          platformChannelSpecifics,
        );
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

  Future _onDidReceiveLocalNotification(
      int id, String title, String body, String payload) {
    print(title);
  }
}
