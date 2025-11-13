import 'package:app/core/constants/app_constant.dart';
import 'package:app/data/websocket.dart';
import 'package:flutter/material.dart';

class SoilProvider extends ChangeNotifier {
  final _service = WebSocketService(AppConstants.wsUrl);
  double _currentValue = 0;

  double get currentValue => _currentValue;

  void startListening() {
    _service.channelStream().listen((data) {
      _currentValue = data.humidity;
      notifyListeners();
    });
  }

  void stopListening() => _service.disconnect();
}
