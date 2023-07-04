// // import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// // class LocalNotificationService {
// //   final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
// //       FlutterLocalNotificationsPlugin();

// //   Future<void> initialize() async {
// //     const AndroidInitializationSettings androidInitializationSettings =
// //         AndroidInitializationSettings('@drawable/ic_stat_work_outline');

// //     final DarwinInitializationSettings initializationSettingsDarwin =
// //         DarwinInitializationSettings(
// //       requestAlertPermission: false,
// //       requestBadgePermission: false,
// //       requestSoundPermission: false,
// //       onDidReceiveLocalNotification:
// //           (int id, String? title, String? body, String? payload) async {
// //         print('id $id');
// //         // didReceiveLocalNotificationStream.add(
// //         //   ReceivedNotification(
// //         //     id: id,
// //         //     title: title,
// //         //     body: body,
// //         //     payload: payload,
// //         //   ),
// //         // );
// //       },
// //       // notificationCategories: darwinNotificationCategories,
// //     );
// //     final InitializationSettings settings = InitializationSettings(
// //       android: androidInitializationSettings,
// //       iOS: initializationSettingsDarwin,
// //     );

// //     await flutterLocalNotificationsPlugin.initialize(
// //       settings,
// //     );
// //   }

// //   Future<void> showNotification(
// //       {required int id, required String title, required String body}) async {
// //     final details = await _notificationDetails();
// //     await flutterLocalNotificationsPlugin.show(id, title, body, details);
// //   }

// //   Future<NotificationDetails> _notificationDetails() async {
// //     const AndroidNotificationDetails androidNotificationDetails =
// //         AndroidNotificationDetails('your channel id', 'your channel name',
// //             channelDescription: 'your channel description',
// //             importance: Importance.max,
// //             priority: Priority.high,
// //             ticker: 'ticker');
// //     const DarwinNotificationDetails iOSNotificationDetails =
// //         DarwinNotificationDetails();

// //     const NotificationDetails notificationDetails =
// //         NotificationDetails(android: androidNotificationDetails);

// //     await flutterLocalNotificationsPlugin.show(
// //         1, 'plain title', 'plain body', notificationDetails,
// //         payload: 'item x');

// //     return const NotificationDetails(
// //         android: androidNotificationDetails, iOS: iOSNotificationDetails);
// //   }
// // }

// import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// class NotificationService {
//   final FlutterLocalNotificationsPlugin notificationsPlugin =
//       FlutterLocalNotificationsPlugin();

//   Future<void> initNotification() async {
//     const AndroidInitializationSettings initializationSettingsAndroid =
//         AndroidInitializationSettings('@drawable/ic_stat_work_outline');

//     var initializationSettingsIOS = DarwinInitializationSettings(
//         requestAlertPermission: true,
//         requestBadgePermission: true,
//         requestSoundPermission: true,
//         onDidReceiveLocalNotification:
//             (int id, String? title, String? body, String? payload) async {});

//     var initializationSettings = InitializationSettings(
//         android: initializationSettingsAndroid, iOS: initializationSettingsIOS);

//     await notificationsPlugin.initialize(initializationSettings,
//         onDidReceiveNotificationResponse:
//             (NotificationResponse notificationResponse) async {});
//   }

//   notificationDetails() {
//     return const NotificationDetails(
//         android: AndroidNotificationDetails('channelId', 'channelName',
//             importance: Importance.max),
//         iOS: DarwinNotificationDetails());
//   }

//   Future showNotification(
//       {int id = 0, String? title, String? body, String? payLoad}) async {
//     return notificationsPlugin.show(
//         id, title, body, await notificationDetails());
//   }
// }
