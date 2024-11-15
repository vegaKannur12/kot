import 'dart:typed_data';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';

class InAppNotif extends StatefulWidget 
{
  const InAppNotif({super.key, required this.title});
  final String title;
  @override
  State<InAppNotif> createState() => _InAppNotifState();
}

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

final assetsAudioPlayer = AssetsAudioPlayer();

Future<void> showAlertNotification() async {
  AndroidNotificationDetails androidPlatformChannelSpecifics =
      AndroidNotificationDetails(
    'alert_channel',
    'Alert Notifications',
    importance: Importance.high,
    priority: Priority.high,
    enableVibration: true,
    vibrationPattern: Int64List.fromList([0, 1000, 500, 1000]),   //  Int64List(8),
    sound: const RawResourceAndroidNotificationSound('notif2'),
  );

  NotificationDetails platformChannelSpecifics =
      NotificationDetails(android: androidPlatformChannelSpecifics);

  await flutterLocalNotificationsPlugin.show(
    0,
    'Order Alert',
    'You have a prepared order!',
    platformChannelSpecifics,
  );
  playAlertSound(); // Play custom sound
}

void playAlertSound() {
  assetsAudioPlayer.open(
    Audio("assets/notif2.mp3"),
    autoStart: true,
  );
}

class _InAppNotifState extends State<InAppNotif> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.yellow),
                onPressed: () 
                {
                  showAlertNotification();
                },
                child: Text(
                  "ALERT",
                  style: TextStyle(fontSize: 24),
                ))
          ],
        ),
      ),    // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
