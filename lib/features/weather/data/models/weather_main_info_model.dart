class WeatherMainInfo {
  final int id;
  final String main;
  final String description;
  final String icon;

  const WeatherMainInfo({
    required this.id,
    required this.main,
    required this.description,
    required this.icon,
  });

  factory WeatherMainInfo.fromJson(Map<String, dynamic> json) {
    return WeatherMainInfo(
      id: json['id'],
      main: json['main'],
      description: json['description'],
      icon: json['icon'],
    );
  }
}