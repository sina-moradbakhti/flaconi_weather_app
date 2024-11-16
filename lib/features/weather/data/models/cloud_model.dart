class CloudsModel {
  final int all;

  const CloudsModel({
    required this.all,
  });

  factory CloudsModel.fromJson(Map<String, dynamic> json) {
    return CloudsModel(
      all: json['all'],
    );
  }

  factory CloudsModel.empty() {
    return const CloudsModel(
      all: 0,
    );
  }
}
