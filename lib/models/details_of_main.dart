class VendorMainSericesModel {
  String? status;
  String? message;
  List<VendorModel>? data;

  VendorMainSericesModel({
    this.status,
    this.message,
    this.data,
  });

  factory VendorMainSericesModel.fromJson(Map<String, dynamic> json) =>
      VendorMainSericesModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<VendorModel>.from(
                json["data"]!.map((x) => VendorModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class VendorModel {
  int? vendorId;
  String? vendorName;
  String? owner;
  String? cityadminId;
  String? vendorEmail;
  String? vendorPhone;
  String? vendorLogo;
  String? vendorLoc;
  dynamic lat;
  dynamic lng;
  String? description;
  dynamic openingTime;
  dynamic closingTime;
  String? vendorPass;
  String? createdAt;
  String? updatedAt;
  dynamic comission;
  int? deliveryRange;
  String? deviceId;
  dynamic otp;
  int? phoneVerified;
  String? onlineStatus;
  int? shopType;
  int? bookingAmount;
  int? adminApproval;
  int? adminShare;
  String? enDescription;

  VendorModel({
    this.vendorId,
    this.vendorName,
    this.owner,
    this.cityadminId,
    this.vendorEmail,
    this.vendorPhone,
    this.vendorLogo,
    this.vendorLoc,
    this.lat,
    this.lng,
    this.description,
    this.openingTime,
    this.closingTime,
    this.vendorPass,
    this.createdAt,
    this.updatedAt,
    this.comission,
    this.deliveryRange,
    this.deviceId,
    this.otp,
    this.phoneVerified,
    this.onlineStatus,
    this.shopType,
    this.bookingAmount,
    this.adminApproval,
    this.adminShare,
    this.enDescription,
  });

  factory VendorModel.fromJson(Map<String, dynamic> json) => VendorModel(
        vendorId: json["vendor_id"],
        vendorName: json["vendor_name"],
        owner: json["owner"],
        cityadminId: json["cityadmin_id"],
        vendorEmail: json["vendor_email"],
        vendorPhone: json["vendor_phone"],
        vendorLogo: json["vendor_logo"],
        vendorLoc: json["vendor_loc"],
        lat: json["lat"],
        lng: json["lng"],
        description: json["description"],
        openingTime: json["opening_time"],
        closingTime: json["closing_time"],
        vendorPass: json["vendor_pass"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        comission: json["comission"],
        deliveryRange: json["delivery_range"],
        deviceId: json["device_id"],
        otp: json["otp"],
        phoneVerified: json["phone_verified"],
        onlineStatus: json["online_status"],
        shopType: json["shop_type"],
        bookingAmount: json["booking_amount"],
        adminApproval: json["admin_approval"],
        adminShare: json["admin_share"],
        enDescription: json["en_description"],
      );

  Map<String, dynamic> toJson() => {
        "vendor_id": vendorId,
        "vendor_name": vendorName,
        "owner": owner,
        "cityadmin_id": cityadminId,
        "vendor_email": vendorEmail,
        "vendor_phone": vendorPhone,
        "vendor_logo": vendorLogo,
        "vendor_loc": vendorLoc,
        "lat": lat,
        "lng": lng,
        "description": description,
        "opening_time": openingTime,
        "closing_time": closingTime,
        "vendor_pass": vendorPass,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "comission": comission,
        "delivery_range": deliveryRange,
        "device_id": deviceId,
        "otp": otp,
        "phone_verified": phoneVerified,
        "online_status": onlineStatus,
        "shop_type": shopType,
        "booking_amount": bookingAmount,
        "admin_approval": adminApproval,
        "admin_share": adminShare,
        "en_description": enDescription,
      };
}
