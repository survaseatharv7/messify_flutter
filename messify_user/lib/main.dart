import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:messify/pages/SplashScreen.dart'; // Assuming you have this screen
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz_data;
import 'package:permission_handler/permission_handler.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyCseZOQg7tDdizV6Pv51Z4dU2c041QXTL8",
      appId: "1:579643748294:android:01bdbc48426f9975df0cc7",
      messagingSenderId: "579643748294",
      projectId: "messify-flutter",
    ),
  );

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  static bool isLoggedIn = false;
  static String messsname = "";
  static String name = "";

  static String username = "";
  static int token = 0;

  static String userMapName = "";
  static String nameMapName = '';
  static String passwordMapName = '';
  static String emailMapName = '';

  static void userDetailsGetter(Map<String, dynamic> map) {
    userMapName = map['username'];
    emailMapName = map['Email'];
    passwordMapName = map['Password'];
    nameMapName = map['name'];
  }

  static double screenWidth = 0;
  static double screenHeight = 0;

  static const double referenceWidth = 411.42;
  static const double referenceHeight = 890.28;

  static double widthCal(double width) {
    return (width / referenceWidth) * screenWidth;
  }

  static double heightCal(double height) {
    return (height / referenceHeight) * screenHeight;
  }

  @override
  Widget build(BuildContext context) {
    // Initialize screen dimensions
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;

    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Notification(),
    );
  }
}

class Notification extends StatefulWidget {
  const Notification({super.key});

  @override
  State<Notification> createState() => _NotificationState();
}

class _NotificationState extends State<Notification> {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  @override
  void initState() {
    super.initState();
    _requestExactAlarmPermission();
    _requestNotificationPermissions();

    _initializeTimezone();
    _initializeNotifications();
    _scheduleDailyNotification();
  }

  void _requestExactAlarmPermission() async {
    try {
      if (await Permission.scheduleExactAlarm.isDenied) {
        await Permission.scheduleExactAlarm.request();
        print('Exact alarm permission requested');
      }
      // Check if the permission is still not granted
      if (await Permission.scheduleExactAlarm.isDenied) {
        throw PlatformException(
          code: 'exact_alarms_not_permitted',
          message: 'Exact alarms are not permitted by the user.',
        );
      }
      print('Exact alarm permission granted');
    } catch (e) {
      print('Error requesting exact alarm permission: $e');
    }
  }

  void _requestNotificationPermissions() async {
    if (await Permission.notification.isDenied) {
      await Permission.notification.request();
      print('Notification permission requested');
    }

    if (await Permission.scheduleExactAlarm.isDenied) {
      await Permission.scheduleExactAlarm.request();
      print('Exact alarm permission requested');
    }

    print(
        'Notification permission granted: ${await Permission.notification.isGranted}');
    print(
        'Exact alarm permission granted: ${await Permission.scheduleExactAlarm.isGranted}');
  }

  /// Initialize timezone data
  void _initializeTimezone() {
    try {
      tz_data.initializeTimeZones();
      tz.setLocalLocation(tz.getLocation('Asia/Kolkata'));
      print('Timezone initialized to Asia/Kolkata');
    } catch (e) {
      print('Error initializing timezone: $e');
    }
  }

  /// Initialize notification plugin
  void _initializeNotifications() async {
    try {
      const AndroidInitializationSettings initializationSettingsAndroid =
          AndroidInitializationSettings('@mipmap/ic_launcher');
      const InitializationSettings initializationSettings =
          InitializationSettings(android: initializationSettingsAndroid);

      final bool? result = await flutterLocalNotificationsPlugin.initialize(
        initializationSettings,
        onDidReceiveNotificationResponse: (NotificationResponse response) {
          print('Notification clicked: ${response.payload}');
        },
      );

      print('Notification initialization successful: $result');
    } catch (e) {
      print('Error initializing notifications: $e');
    }
  }

  /// Schedule daily notification
  void _scheduleDailyNotification() async {
    try {
      final targetTime = _nextInstanceOfTime(3, 02); // Target time (2:49 AM)
      print('Target time for notification: $targetTime'); // Debugging statement

      const AndroidNotificationDetails androidPlatformChannelSpecifics =
          AndroidNotificationDetails(
        'daily_notification_channel', // Channel ID
        'Daily Notifications', // Channel name
        channelDescription: 'This channel is used for daily notifications.',
        importance: Importance.high,
        priority: Priority.high,
        ticker: 'Daily Reminder',
      );

      const NotificationDetails platformChannelSpecifics =
          NotificationDetails(android: androidPlatformChannelSpecifics);

      await flutterLocalNotificationsPlugin.zonedSchedule(
        0, // Notification ID
        'Reminder', // Notification title
        'Hurry Up come to mess!!!', // Notification body
        targetTime, // Schedule for the target time
        platformChannelSpecifics,
        matchDateTimeComponents: DateTimeComponents.time,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.wallClockTime,
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      );

      print('Notification scheduled successfully.');
    } catch (e) {
      print('Error scheduling notification: $e');
    }
  }

  /// Calculate the next instance of the target time
  tz.TZDateTime _nextInstanceOfTime(int hour, int minute) {
    final now = tz.TZDateTime.now(tz.local);
    final targetTime =
        tz.TZDateTime(tz.local, now.year, now.month, now.day, hour, minute);

    print('Current Time: $now'); // Debugging statement
    print('Target Time: $targetTime'); // Debugging statement

    if (now.isAfter(targetTime)) {
      return targetTime.add(const Duration(days: 1)); // Schedule for tomorrow
    }
    return targetTime; // Schedule for today
  }

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Splashscreen(), // Assuming you have a SplashScreen widget
    );
  }
}
