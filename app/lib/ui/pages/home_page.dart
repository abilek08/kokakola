import 'package:app/core/constants/app_constant.dart';
import 'package:app/core/utils/notification.dart';
import 'package:app/data/websocket.dart';
import 'package:flutter/material.dart';
import '../../../models/soil_data.dart';
import '../widgets/soil_display.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late WebSocketService wsService;
  double soilValue = 0;
  bool alarmEnabled = true;
  bool showWarning = false;
  bool hasNotified = false;

  @override
  void initState() {
    super.initState();
    wsService = WebSocketService(AppConstants.wsUrl);
    _listenWebSocket();
  }

  void _listenWebSocket() {
    wsService.dataStream.listen((SoilData data) {
      setState(() {
        soilValue = data.humidity;
        showWarning =
            alarmEnabled && soilValue < AppConstants.moistureThreshold;
      });

      if (showWarning && !hasNotified) {
        NotificationService.showNotification(
          'Notification',
          title: 'Tanah mulai kering!',
          body: 'Kelembaban: ${soilValue.toStringAsFixed(1)}%',
        );
        hasNotified = true;
      } else if (!showWarning) {
        hasNotified = false;
      }
    });
  }

  @override
  void dispose() {
    wsService.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Soil Moisture Monitor'),
        actions: [
          Row(
            children: [
              const Text("Alarm"),
              Switch(
                value: alarmEnabled,
                onChanged: (v) {
                  setState(() {
                    alarmEnabled = v;
                    showWarning =
                        alarmEnabled && soilValue < AppConstants.moistureThreshold;
                    if (!alarmEnabled) hasNotified = false;
                  });
                },
              ),
            ],
          ),
        ],
      ),
      body: Center(
        child: SoilDisplay(
          value: soilValue,
          showWarning: showWarning,
          onReconnect: wsService.reconnect,
        ),
      ),
    );
  }
}
