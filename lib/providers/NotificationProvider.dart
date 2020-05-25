import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationProvider with ChangeNotifier{
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  BuildContext context;
  NotificationProvider(this.context){
    // initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project
    // If you have skipped STEP 3 then change app_icon to @mipmap/ic_launcher
    var initializationSettingsAndroid =
    new AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializationSettingsIOS = new IOSInitializationSettings();
    var initializationSettings = new InitializationSettings(
        initializationSettingsAndroid, initializationSettingsIOS);
    flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();
    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: onSelectNotification);
  }
  // Show Notification wit sound
  Future showNotificationWithDefaultSound({String payload}) async {
    var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
        'your channel id', 'your channel name', 'your channel description',
        importance: Importance.Max, priority: Priority.High);
    var iOSPlatformChannelSpecifics = new IOSNotificationDetails();
    var platformChannelSpecifics = new NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
      0,
      'Afro Shirt',
      'How to Show Notification in Flutter',
      platformChannelSpecifics,
      payload: payload,
    );
  }

  Future scheduleNotificationWithSound({String payload, DateTime scheduledNotificationDateTime, String title, String body}) async {

    var androidPlatformChannelSpecifics =
    AndroidNotificationDetails('your other channel id',
        'Measur', 'Reminding you of the projects you have ahead.',
        importance: Importance.Max, priority: Priority.High);
    var iOSPlatformChannelSpecifics =
    IOSNotificationDetails();
    NotificationDetails platformChannelSpecifics = NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.schedule(
        DateTime.now().millisecond,
        title,
        body,
        scheduledNotificationDateTime,
        platformChannelSpecifics,
        payload: payload,
        androidAllowWhileIdle: true
    );
  }

  Future onSelectNotification(String payload) async {
    Navigator.pushReplacementNamed(context, "/home");
  }

}