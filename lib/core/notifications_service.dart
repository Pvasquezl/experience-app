import 'dart:convert';

import 'package:experience_app/core/navigation/router.dart';
import 'package:experience_app/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:experience_app/core/log_data_source.dart';

@pragma('vm:entry-point')
Future<void> _firebaseBackgroundHandler(RemoteMessage message) async {
  try {} catch (e) {
    print('already set: $e');
  }

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Trabajo corto y sin UI: cachear, contar, loguear
  final data = message.data;
  // await _guardarEnCacheLocal(data);
  print('Background message received: ${message.notification?.title}');
  print('Background message data: $data');

  LogDataSource logDataSource = LogDataSource();
  await logDataSource.logEvent('background_message', {
    ...data,
    'title': message.notification?.title ?? '',
  });
}

class NotificationsService {
  NotificationsService({
    FirebaseMessaging? firebaseMessaging,
    FlutterLocalNotificationsPlugin? localNotifications,
  }) : _localNotifications =
           localNotifications ?? FlutterLocalNotificationsPlugin(),
       _firebaseMessaging = firebaseMessaging ?? FirebaseMessaging.instance;

  final FirebaseMessaging _firebaseMessaging;
  final FlutterLocalNotificationsPlugin _localNotifications;

  RemoteMessage? _initialMessage;

  Future<void> init() async {
    await _requestPermissions();
    await _initRemoteNotifications();
    await _initLocalNotifications();
    _initBackgroundHandler();
    _initMessageOpenedApp();
  }

  Future<void> _requestPermissions() async {
    // Initialize local notifications here
    final actualSettings = await _firebaseMessaging.getNotificationSettings();
    print(
      'Actual notification settings: ${actualSettings.authorizationStatus}',
    );

    final settings = await _firebaseMessaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    print('Notification settings: ${settings.authorizationStatus}');
  }

  Future<void> _initRemoteNotifications() async {
    final token = await _firebaseMessaging.getToken();
    _firebaseMessaging.onTokenRefresh.listen((newToken) {
      print('FCM Token refreshed: $newToken');
    });
    print('FCM Token: $token');

    await _initLocalNotifications();
    FirebaseMessaging.onMessage.listen(_foregroundMessageHandler);
  }

  void _foregroundMessageHandler(RemoteMessage message) {
    if (message.notification != null) {
      print('Foreground message received: ${message.notification!.title}');
      _showLocalNotification(message);
    }
  }

  Future<void> _initLocalNotifications() async {
    // Initialize local notifications here

    const canal = AndroidNotificationChannel(
      'canal_alta_prioridad',
      'Avisos importantes',
      importance: Importance.high, // sin esto no suena ni aparece flotante
    );

    await _localNotifications
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >()
        ?.createNotificationChannel(canal);

    await _localNotifications.initialize(
      settings: const InitializationSettings(
        android: AndroidInitializationSettings('@mipmap/ic_launcher'),
        iOS: DarwinInitializationSettings(),
      ),
      onDidReceiveNotificationResponse: (response) {
        print(
          'Notification response received: ${response.notificationResponseType}',
        );

        if (response.payload == null || response.payload!.isEmpty) {
          return;
        }

        try {
          print('Notification response payload: ${response.payload}');
          final data = jsonDecode(response.payload!);
          final message = RemoteMessage(
            data: data is Map
                ? Map<String, String>.from(
                    data.map(
                      (key, value) =>
                          MapEntry(key.toString(), value?.toString() ?? ''),
                    ),
                  )
                : <String, String>{},
          );
          _handleNotificationNavigation(message);
        } catch (e) {
          print('Error parsing notification payload: $e');
        }
      },
    );
  }

  Future<void> _showLocalNotification(RemoteMessage message) async {
    final payload = jsonEncode({
      ...message.data,
      'title': message.notification?.title ?? '',
      'body': message.notification?.body ?? '',
    });

    const androidDetails = AndroidNotificationDetails(
      'canal_alta_prioridad',
      'Avisos importantes',
      channelDescription: 'Avisos importantes',
      importance: Importance.max,
      priority: Priority.high,
    );

    const details = NotificationDetails(android: androidDetails);

    await _localNotifications.show(
      id: DateTime.now().millisecondsSinceEpoch ~/ 1000,
      title: message.notification?.title ?? 'Notificación',
      body: message.notification?.body ?? 'Esta es una notificación local',
      notificationDetails: details,
      payload: payload,
    );
  }

  void _initBackgroundHandler() {
    FirebaseMessaging.onBackgroundMessage(_firebaseBackgroundHandler);
  }

  void _initMessageOpenedApp() {
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      _handleNotificationNavigation(message);
    });
  }

  void _handleNotificationNavigation(RemoteMessage message) {
    final data = message.data;
    final saleId = data['sale_id'] ?? data['saleId'] ?? '';

    switch (data['feature']) {
      case 'sale_details':
        router.goNamed(Routes.saleDetails, extra: {'saleId': saleId});
        break;
      default:
        router.goNamed(Routes.explore);
    }
  }

  Future<RemoteMessage?> getInitialMessage() async {
    _initialMessage = await _firebaseMessaging.getInitialMessage();
    return _initialMessage;
  }
}
