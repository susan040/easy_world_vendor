class UsersDetails {
  String? message;
  String? token;
  Data? data;

  UsersDetails({this.message, this.token, this.data});

  UsersDetails.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    token = json['token'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['token'] = this.token;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  int? id;
  String? storeName;
  String? storeDescription;
  String? email;
  String? countryCode;
  String? phone;
  bool? approved;
  String? approvedAt;
  String? profileImage;
  String? documentRegistration;
  String? createdAt;

  Data({
    this.id,
    this.storeName,
    this.storeDescription,
    this.email,
    this.countryCode,
    this.phone,
    this.approved,
    this.approvedAt,
    this.profileImage,
    this.documentRegistration,
    this.createdAt,
  });

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    storeName = json['store_name'];
    storeDescription = json['store_description'];
    email = json['email'];
    countryCode = json['country_code'];
    phone = json['phone'];
    approved = json['approved'];
    approvedAt = json['approved_at'];
    profileImage = json['profile_image'];
    documentRegistration = json['document_registration'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['store_name'] = this.storeName;
    data['store_description'] = this.storeDescription;
    data['email'] = this.email;
    data['country_code'] = this.countryCode;
    data['phone'] = this.phone;
    data['approved'] = this.approved;
    data['approved_at'] = this.approvedAt;
    data['profile_image'] = this.profileImage;
    data['document_registration'] = this.documentRegistration;
    data['created_at'] = this.createdAt;
    return data;
  }
}
