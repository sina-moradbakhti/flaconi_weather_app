class WindModel {
  final double speed;
  final int deg;

  const WindModel({
    required this.speed,
    required this.deg,
  });

  factory WindModel.fromJson(Map<String, dynamic> json) {
    return WindModel(
      speed: json['speed'] is int ? json['speed'].toDouble() : json['speed'],
      deg: json['deg'],
    );
  }

  factory WindModel.empty() {
    return const WindModel(speed: 0, deg: 0);
  }
}
