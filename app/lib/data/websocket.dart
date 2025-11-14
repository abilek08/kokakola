import 'dart:convert';
import 'package:web_socket_channel/web_socket_channel.dart';
import '../models/soil_data.dart';

class WebSocketService {
  final String url;
  late WebSocketChannel _channel;
  bool isCOnnected = false;

  WebSocketService(this.url) {
    _connect();
    _sendPing();
  }

  void _sendPing() {
    Future.delayed(const Duration(seconds: 10), () {
      _channel.sink.add("ping");
      _sendPing();
    });
  }

  void _connect() {
    _channel = WebSocketChannel.connect(Uri.parse(url));
    isCOnnected = true;
  }

  bool isConencted() {
    return isCOnnected;
  }

  Stream<SoilData> channelStream() {
    return _channel.stream.map((event) {
      final jsonData = jsonDecode(event);
      return SoilData.fromJson(jsonData);
    });
  }

  Stream<SoilData> get dataStream async* {
    await for (var message in _channel.stream) {
      try {
        final data = jsonDecode(message);

        if (data is Map<String, dynamic>) {
          if (data['type'] == 'pong' || data['type'] == 'ping') continue;
          if (data.containsKey('humidity')) {
            yield SoilData.fromJson(data);
          }
        }
      } catch (e) {
        print("Error parsing message: $message");
      }
    }
  }

  void reconnect() {
    _channel.sink.close();
    isCOnnected = false;
    _connect();
  }

  void disconnect() {
    _channel.sink.close();
    isCOnnected = false;
  }

  void dispose() {
    _channel.sink.close();
    isCOnnected = false;
  }
}
