class DetailsMainServicesModel {
  String? status;
  String? message;
  List<DetailsOfMainService>? data;

  DetailsMainServicesModel({
    this.status,
    this.message,
    this.data,
  });

  factory DetailsMainServicesModel.fromJson(Map<String, dynamic> json) =>
      DetailsMainServicesModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<DetailsOfMainService>.from(
                json["data"]!.map((x) => DetailsOfMainService.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class DetailsOfMainService {
  int? serviceId;
  int? mServiceId;
  String? serviceName;
  String? serviceImage;
  String? createdAt;
  String? updatedAt;
  int? vendorId;
  String? enServiceName;

  DetailsOfMainService({
    this.serviceId,
    this.mServiceId,
    this.serviceName,
    this.serviceImage,
    this.createdAt,
    this.updatedAt,
    this.vendorId,
    this.enServiceName,
  });

  factory DetailsOfMainService.fromJson(Map<String, dynamic> json) =>
      DetailsOfMainService(
        serviceId: json["service_id"],
        mServiceId: json["m_service_id"],
        serviceName: json["service_name"],
        serviceImage: json["service_image"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        vendorId: json["vendor_id"],
        enServiceName: json["en_service_name"],
      );

  Map<String, dynamic> toJson() => {
        "service_id": serviceId,
        "m_service_id": mServiceId,
        "service_name": serviceName,
        "service_image": serviceImage,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "vendor_id": vendorId,
        "en_service_name": enServiceName,
      };
}
