import 'dart:convert';
import 'package:app/core/constants/app_constant.dart';
import 'package:app/core/utils/notification.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

Future<void> initializeBackgroundService() async {
  final service = FlutterBackgroundService();

  await service.configure(
    androidConfiguration: AndroidConfiguration(
      onStart: onStart,
      autoStart: true,
      isForegroundMode: true,
      notificationChannelId: 'soil_channel',
      initialNotificationTitle: 'Monitoring aktif',
      initialNotificationContent: 'Memantau kelembaban tanah...',
    ),
    iosConfiguration: IosConfiguration(),
  );

  service.startService();
}

@pragma('vm:entry-point')
void onStart(ServiceInstance service) async {
  final ws = WebSocketChannel.connect(Uri.parse(AppConstants.wsUrl));

  ws.stream.listen((message) async {
    final data = jsonDecode(message);
    final double value = (data['humidity'] as num).toDouble();

    if (value < AppConstants.moistureThreshold) {
      await NotificationService.showNotification(
        'Notification',
        title: 'Tanah mulai kering!',
        body: 'Kelembaban: ${value.toStringAsFixed(1)}%',
      );
    }
  });
}
