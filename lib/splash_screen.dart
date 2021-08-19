// import 'dart:convert';
// import 'dart:io';
//
// import 'package:claveto/common/constant.dart';
// import 'package:claveto/home.dart';
// import 'package:claveto/main.dart';
// import 'package:claveto/rest/api_services.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:intl/intl.dart';
//
// import 'common/keys.dart';
// import 'common/loading.dart';
// import 'common/pref.dart';
// import 'notification_example.dart';
//
// class SplashScreen extends StatefulWidget {
//
//   const SplashScreen(
//       this.notificationAppLaunchDetails, {
//         Key key,
//       }) : super(key: key);
//
//   final NotificationAppLaunchDetails notificationAppLaunchDetails;
//   bool get didNotificationLaunchApp =>
//       notificationAppLaunchDetails?.didNotificationLaunchApp ?? false;
//
//   @override
//   _SplashScreenState createState() => _SplashScreenState();
// }
//
// class _SplashScreenState extends State<SplashScreen> {
//   FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
//
//
//
//
//
//   void _requestPermissions() {
//     flutterLocalNotificationsPlugin
//         .resolvePlatformSpecificImplementation<
//         IOSFlutterLocalNotificationsPlugin>()
//         ?.requestPermissions(
//       alert: true,
//       badge: true,
//       sound: true,
//     );
//     flutterLocalNotificationsPlugin
//         .resolvePlatformSpecificImplementation<
//         MacOSFlutterLocalNotificationsPlugin>()
//         ?.requestPermissions(
//       alert: true,
//       badge: true,
//       sound: true,
//     );
//   }
//
//   void _configureDidReceiveLocalNotificationSubject() {
//     didReceiveLocalNotificationSubject.stream
//         .listen((ReceivedNotification receivedNotification) async {
//       await showDialog(
//         context: context,
//         builder: (BuildContext context) => CupertinoAlertDialog(
//           title: receivedNotification.title != null
//               ? Text(receivedNotification.title)
//               : null,
//           content: receivedNotification.body != null
//               ? Text(receivedNotification.body)
//               : null,
//           actions: <Widget>[
//             CupertinoDialogAction(
//               isDefaultAction: true,
//               onPressed: () async {
//                 Navigator.of(context, rootNavigator: true).pop();
//                 await Navigator.push(
//                   context,
//                   MaterialPageRoute<void>(
//                     builder: (BuildContext context) =>
//                         SecondScreen(receivedNotification.payload),
//                   ),
//                 );
//               },
//               child: const Text('Ok'),
//             )
//           ],
//         ),
//       );
//     });
//   }
//
//   void _configureSelectNotificationSubject() {
//
//     didReceiveLocalNotificationSubject.stream
//         .listen((ReceivedNotification receivedNotification) async {
//       await Navigator.push(
//         context,
//         MaterialPageRoute<void>(
//             builder: (BuildContext context) => SecondScreen(receivedNotification.payload)),
//       );
//     });
//     selectNotificationSubject.stream.listen((String payload) async {
//
//       await Navigator.push(
//         context,
//         MaterialPageRoute<void>(
//             builder: (BuildContext context) => SecondScreen(payload)),
//       );
//     });
//   }
//
//   // @override
//   // void dispose() {
//   //   didReceiveLocalNotificationSubject.close();
//   //   selectNotificationSubject.close();
//   //   super.dispose();
//   // }
//
//
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     Pref.init();
//     _requestPermissions();
//     _configureDidReceiveLocalNotificationSubject();
//     _configureSelectNotificationSubject();
//     Future.delayed(Duration(milliseconds: 300), () {
//       print('Token $token Splash Screen');
//       if (token == null || token == '' || token.isEmpty) {
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(builder: (context) => MyHomePage()),
//         );
//       } else {
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(builder: (context) => Home()),
//         );
//       }
//     });
//
//
//   }
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: Container(
//       height: double.infinity,
//       width: double.infinity,
//       child: Image.asset("assets/splash_screen/splash.png"),
//     ));
//   }
// }
