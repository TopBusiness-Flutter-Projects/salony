class MainServicesModel {
  String? status;
  String? message;
  List<MainService>? data;

  MainServicesModel({
    this.status,
    this.message,
    this.data,
  });

  factory MainServicesModel.fromJson(Map<String, dynamic> json) =>
      MainServicesModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<MainService>.from(
                json["data"]!.map((x) => MainService.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class MainService {
  int? id;
  String? name;
  String? image;
  DateTime? createdAt;

  MainService({
    this.id,
    this.name,
    this.image,
    this.createdAt,
  });

  factory MainService.fromJson(Map<String, dynamic> json) => MainService(
        id: json["id"],
        name: json["name"],
        image: json["image"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "image": image,
        "created_at": createdAt?.toIso8601String(),
      };
}
