import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gwc_cet/screens/splash_screen.dart';
import 'package:gwc_cet/utils/app_config.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

import 'controller/auth_controller/auth_controller.dart';
import 'controller/cet_team_data/cet_team_controller.dart';
import 'controller/notification_service.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  AppConfig().preferences = await SharedPreferences.getInstance();

  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [SystemUiOverlay.bottom]);
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(statusBarColor: Colors.white10),
  );
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  //***** firebase notification ******
  await Firebase.initializeApp().then((value) {
    print("firebase initialized");
  }).onError((error, stackTrace) {
    print("firebase initialize error: ${error}");
  });

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  //
  LocalNotificationService.initialize();

  // ********  end of notification

  runApp(const MyApp());
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print('Handling a background message ${message.messageId}');
  // await Firebase.initializeApp();

  print("message bg: ${message.data.toString()}");

  if (message.notification != null) {
    print(message.notification!.title);
    print(message.notification!.body);
    print("message.data bg ${message.data}");
    //message.data11 {notification_type: shopping, tag_id: ,
    // body: Your shopping list has been uploaded. Enjoy!, title: Shopping List, user: user}
    // W/dy.gwc_custome(31771): Reducing the number of considered missed Gc histogram windows from 150 to 100
    // I/flutter (31771): message recieved: {senderId: null, category: null, collapseKey: com.fembuddy.gwc_customer, contentAvailable: false, data: {notification_type: shopping, tag_id: , body: Your shopping list has been uploaded. Enjoy!, title: Shopping List, user: user}, from: 223001521272, messageId: 0:1677744200702793%021842b3021842b3, messageType: null, mutableContent: false, notification: {title: Shopping List, titleLocArgs: [], titleLocKey: null, body: Your shopping list has been uploaded. Enjoy!, bodyLocArgs: [], bodyLocKey: null, android: {channelId: null, clickAction: null, color: null, count: null, imageUrl: null, link: null, priority: 0, smallIcon: null, sound: default, ticker: null, tag: null, visibility: 0}, apple: null, web: null}, sentTime: 1677744200683, threadId: null, ttl: 2419200}
    // I/flutter (31771): Notification Message: {senderId: null, category: null, collapseKey: com.fembuddy.gwc_customer, contentAvailable: false, data: {notification_type: shopping, tag_id: , body: Your shopping list has been uploaded. Enjoy!, title: Shopping List, user: user}, from: 223001521272, messageId: 0:1677744200702793%021842b3021842b3, messageType: null, mutableContent: false, notification: {title: Shopping List, titleLocArgs: [], titleLocKey: null, body: Your shopping list has been uploaded. Enjoy!, bodyLocArgs: [], bodyLocKey: null, android: {channelId: null, clickAction: null, color: null, count: null, imageUrl: null, link: null, priority: 0, smallIcon: null, sound: default, ticker: null, tag: null, visibility: 0}, apple: null, web: null}, sentTime: 1677744200683, threadId: null, ttl: 2419200}

    LocalNotificationService.createanddisplaynotification(message);
  }
  else{
    LocalNotificationService().showQBNotification(message);
  }
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (BuildContext context, Orientation orientation, DeviceType deviceType){
        return MultiProvider(
            providers: [
              ChangeNotifierProvider(create: (_)=> AuthController()),
              ChangeNotifierProvider(create: (_)=> CetTeamDataController())
            ],
          child: MaterialApp(
            title: 'GWC CET',
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            builder: (BuildContext context, Widget? child) => MediaQuery(
              data: MediaQuery.of(context).copyWith(textScaleFactor: 0.9),
              child: child ?? const SizedBox.shrink(),
            ),
            debugShowCheckedModeBanner: false,
            home: const SplashScreen(),
          ),
        );
      },
    );
  }
}

