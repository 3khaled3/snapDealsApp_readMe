import 'dart:convert';
import 'dart:developer';
import 'dart:typed_data';
import 'package:googleapis_auth/auth_io.dart' as googleapis_auth;
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart' show rootBundle;
import 'package:snap_deals/app/auth_feature/model_view/profile_cubit/profile_cubit.dart';
import 'package:snap_deals/app/chat_feature/data/models/chat_config.dart';
import 'package:snap_deals/app/chat_feature/data/services/chat_service.dart';
import 'package:snap_deals/app/notification/data/notification_model.dart';
import 'package:snap_deals/app/notification/data/notification_repo.dart';
import 'package:snap_deals/app/product_feature/data/models/product_model.dart';
import 'package:uuid/uuid.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  NotificationService._privateConstructor();

  static final NotificationService _instance =
      NotificationService._privateConstructor();

  static NotificationService get instance => _instance;

  // Callback for handling foreground message updates (optional)
  Function(RemoteMessage)? onForegroundMessage;

  Future<void> initialize() async {
    // Request permissions for iOS
    NotificationSettings settings = await _firebaseMessaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    log('firebase :: User granted permission: ${settings.authorizationStatus}');

    // Configure Local Notification settings
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const DarwinInitializationSettings initializationSettingsDarwin =
        DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsDarwin,
    );

    await _flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: _onDidReceiveNotificationResponse,
    );

    // Listen for foreground messages
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      log('firebase :: Received a foreground message: ${message.toMap()}');
      if (message.data['type'] == 'supportChat') {
        updateMessagesToDelivered(
            chatType: ChatType.support,
            senderId: message.data['senderId'],
            receiverId: message.data['receiverId']);
      } else if (message.data['type'] == 'freeChat') {
        updateMessagesToDelivered(
            chatType: ChatType.free,
            senderId: message.data['senderId'],
            receiverId: message.data['receiverId']);
      }
      _showNotification(message);

      // If there's a foreground message handler, call it
      if (onForegroundMessage != null) {
        onForegroundMessage!(message);
      }
    });

    // Handle when the app is opened from a notification
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      log('firebase :: Notification clicked! Message: ${message.notification?.title}');
      _handleNotificationClick(message);
    });

    // Handle background messages
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  }

  // Show local notification
  Future<void> _showNotification(RemoteMessage message) async {
    String? imgUrl = message.notification?.android?.imageUrl;
    ByteArrayAndroidBitmap? largeIcon;
// converting image into base65 to show in notification bar
    BigPictureStyleInformation? bigPictureStyleInformation;
    if (imgUrl != null) {
      try {
        Dio dio = Dio();
        // Fetch image bytes using Dio
        Response<List<int>> response = await dio.get<List<int>>(
          imgUrl,
          options: Options(responseType: ResponseType.bytes),
        );
        // Convert image bytes to base64 string
        Uint8List imageBytes = Uint8List.fromList(response.data!);
        String base64Image = base64Encode(imageBytes);
        largeIcon = ByteArrayAndroidBitmap.fromBase64String(base64Image);
        // Create BigPictureStyleInformation for displaying the image
        bigPictureStyleInformation = BigPictureStyleInformation(
          ByteArrayAndroidBitmap.fromBase64String(base64Image),
          contentTitle: message.notification?.title,
          summaryText: message.notification?.body,
        );
      } catch (e) {
        print('Error fetching image: $e');
      }
    }

    AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'high_importance_channel',
      'High Importance Notifications',
      importance: Importance.high,
      priority: Priority.high,
      // largeIcon: largeIcon, // This sets the small image on the right side ofnotification title
      styleInformation: bigPictureStyleInformation,
    );

    NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: const DarwinNotificationDetails(),
    );

    await _flutterLocalNotificationsPlugin.show(
      message.hashCode,
      message.notification?.title ?? 'No Title',
      message.notification?.body ?? 'No Body',
      platformChannelSpecifics,
    );
  }

  // Handle notification click action
  Future<void> _handleNotificationClick(RemoteMessage message) async {
    log('firebase :: User tapped on notification: ${message.notification?.title}');
    // You can navigate to a specific screen using Navigator here
  }

  // Called when a notification is tapped (foreground or background)
  Future<void> _onDidReceiveNotificationResponse(
      NotificationResponse notificationResponse) async {
    final String? payload = notificationResponse.payload;
    if (payload != null) {
      log('firebase :: Notification payload: $payload');
      // Navigate or perform an action based on the payload
    }
  }

  // Background handler (required for background notifications)
  static Future<void> _firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {
    log('firebase :: Handling a background message: ${message.messageId}');
    if (message.data['type'] == 'supportChat') {
      updateMessagesToDelivered(
          chatType: ChatType.support,
          senderId: message.data['senderId'],
          receiverId: message.data['receiverId']);
    } else if (message.data['type'] == 'freeChat') {
      updateMessagesToDelivered(
          chatType: ChatType.free,
          senderId: message.data['senderId'],
          receiverId: message.data['receiverId']);
    }
  }

  // Get device token (you can send this to your server for targeted notifications)
  Future<String?> getDeviceToken() async {
    String? token = await _firebaseMessaging.getToken();
    final user = ProfileCubit.instance.state.profile;
    if (user.notificationToken == token) return token;
    // await FirebaseFirestore.instance
    //     .collection('users')
    //     .doc(user.id)
    //     .set({"notification_token": token}, SetOptions(merge: true));
    print("Device Token: $token");

    return token;
  }

// Function to send FCM Notification
  Future<void> sendPushNotification({
    required Partner partner,
    required String type,
    required String title,
    required String body,
  }) async {
    try {
      // Get the OAuth token
      String accessToken = await _getAccessToken();
      print("accessToken: $accessToken");

      // FCM API endPointConst
      String fcmUrl =
          'https://fcm.googleapis.com/v1/projects/eco4u-d794c/messages:send';

      // Create the message payload
      final Map<String, dynamic> message = {
        "message": {
          "token": partner.notificationToken,
          "notification": {
            "title": title,
            "body": body,
          },
          "data": {
            "type": type,
            "click_action": "FLUTTER_NOTIFICATION_CLICK",
            "status": "done",
            "senderId": ProfileCubit.instance.state.profile.id,
            "receiverId": partner.id,
          },
        },
      };

      // Send the HTTP POST request to FCM
      final response = await http.post(
        Uri.parse(fcmUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken',
        },
        body: jsonEncode(message),
      );

      // Check the response status
      if (response.statusCode == 200) {
        print("✅ Notification Sent Successfully!");
        final uuid = Uuid().v4();
        NotificationRepository().addNotification(NotificationModel(
          id: uuid,
          senderId: ProfileCubit.instance.state.profile.id,
          receiverId: partner.id,
          title: title,
          body: body,
          date: DateTime.now().toString(),
          isSeen: false,
        ));
      } else {
        print("❌ Error Sending Notification: ${response.body}");
      }
    } catch (e) {
      print("❌ Error in sendPushNotification: $e");
    }
  }
}

// Function to get OAuth Token
Future<String> _getAccessToken() async {
  try {
    // Load the service account JSON file
    final serviceAccountJson = json.decode(
      await rootBundle.loadString('assets/service-account.json'),
    );
    // Create credentials from the service account JSON
    final accountCredentials =
        googleapis_auth.ServiceAccountCredentials.fromJson(serviceAccountJson);

    // Create a client using the service account credentials
    final scopes = ['https://www.googleapis.com/auth/firebase.messaging'];

    googleapis_auth.AuthClient client = await googleapis_auth
        .clientViaServiceAccount(accountCredentials, scopes);

    // Return the access token
    return client.credentials.accessToken.data;
  } catch (e) {
    print("❌ Error getting access token: $e");
    rethrow;
  }
}
