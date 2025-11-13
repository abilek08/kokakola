class SoilData {
  final double humidity;

  SoilData({required this.humidity});

  factory SoilData.fromJson(Map<String, dynamic> json) {
    return SoilData(humidity: (json['humidity'] as num).toDouble());
  }
}
