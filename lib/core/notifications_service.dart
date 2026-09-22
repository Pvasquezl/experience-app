import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class NotificationsService {
  static final instance = NotificationsService();

  NotificationsService({
    FirebaseMessaging? firebaseMessaging,
    FlutterLocalNotificationsPlugin? localNotifications,
    FirebaseAuth? firebaseAuth,
    FirebaseFirestore? firestore,
  }) : _localNotifications =
           localNotifications ?? FlutterLocalNotificationsPlugin(),
       _firebaseMessaging = firebaseMessaging ?? FirebaseMessaging.instance,
       _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
       _firestore = firestore ?? FirebaseFirestore.instance;

  final FirebaseMessaging _firebaseMessaging;
  final FlutterLocalNotificationsPlugin _localNotifications;
  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firestore;

  Future<void> init() async {
    await _requestPermissions();
    await _initRemoteNotifications();
    await _initLocalNotifications();
    _firebaseAuth.authStateChanges().listen((_) => _saveCurrentToken());
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
    await _saveToken(token);
    _firebaseMessaging.onTokenRefresh.listen((newToken) {
      _saveToken(newToken);
      print('FCM Token refreshed: $newToken');
    });
    print('FCM Token: $token');

    FirebaseMessaging.onMessage.listen(_foregroundMessageHandler);
  }

  Future<void> _saveCurrentToken() async {
    await _saveToken(await _firebaseMessaging.getToken());
  }

  Future<void> _saveToken(String? token) async {
    final uid = _firebaseAuth.currentUser?.uid;
    if (uid == null || token == null || token.isEmpty) return;

    await _firestore.collection('users').doc(uid).set({
      'deviceToken': token,
    }, SetOptions(merge: true));
  }

  Future<void> showTransferSentNotification() async {
    await _showLocalNotification(
      title: 'Transferencia enviada',
      body: 'Tu transferencia se ha enviado correctamente.',
    );
  }

  void _foregroundMessageHandler(RemoteMessage message) {
    if (message.notification != null) {
      print('Foreground message received: ${message.notification!.title}');
      _showLocalNotification(
        title: message.notification!.title,
        body: message.notification!.body,
      );
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

    await _localNotifications
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >()
        ?.requestNotificationsPermission();

    await _localNotifications.initialize(
      settings: const InitializationSettings(
        android: AndroidInitializationSettings('@mipmap/ic_launcher'),
        iOS: DarwinInitializationSettings(),
      ),
      onDidReceiveNotificationResponse: (r) =>
          print('se presionó la notificación'), // el tap
    );
  }

  Future<void> _showLocalNotification({String? title, String? body}) async {
    const androidDetails = AndroidNotificationDetails(
      'canal_alta_prioridad',
      'Avisos importantes',
      channelDescription: 'Notificaciones importantes',
      importance: Importance.max,
      priority: Priority.high,
    );

    const details = NotificationDetails(android: androidDetails);

    await _localNotifications.show(
      id: 0,
      title: title ?? 'Notificación',
      body: body ?? 'Esta es una notificación local',
      notificationDetails: details,
    );
  }
}
