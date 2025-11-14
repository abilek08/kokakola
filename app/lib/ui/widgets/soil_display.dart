import 'package:app/data/websocket.dart';
import 'package:flutter/material.dart';

class SoilDisplay extends StatelessWidget {
  final double value;
  final bool showWarning;
  final VoidCallback onReconnect;
  final WebSocketService wsService;

  const SoilDisplay({
    super.key,
    required this.value,
    required this.showWarning,
    required this.onReconnect,
    required this.wsService,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.grass, size: 80, color: Colors.green),
          const SizedBox(height: 24),
          Text(
            '${value.toStringAsFixed(1)}%',
            style: Theme.of(context).textTheme.displayMedium?.copyWith(
              color: showWarning ? Colors.red : Colors.green,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            !wsService.isCOnnected
                ? 'Menghubungkan ke server!'
                : value < 1
                ? 'Tanah kering!'
                : showWarning
                ? '⚠️ Tanah mulai kering!'
                : value > 80
                ? 'Kelembaban bagus👍'
                : 'Kelembaban normal 👍',
            style: TextStyle(
              color: showWarning ? Colors.red : Colors.black54,
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 40),
          ElevatedButton.icon(
            icon: const Icon(Icons.refresh),
            label: const Text('Reconnect'),
            onPressed: onReconnect,
          ),
        ],
      ),
    );
  }
}
