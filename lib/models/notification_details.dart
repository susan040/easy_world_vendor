List<GetNotificationDetails> notificationDetailsFromJson(
  List<dynamic> notificationDetailsJson,
) => List<GetNotificationDetails>.from(
  notificationDetailsJson.map(
    (notificationDetailsListJson) =>
        GetNotificationDetails.fromJson(notificationDetailsListJson),
  ),
);

class GetNotificationDetails {
  String? id;
  String? type;
  String? notifiableType;
  String? notifiableId;
  Data? data;
  String? readAt;
  String? createdAt;
  String? updatedAt;

  GetNotificationDetails({
    this.id,
    this.type,
    this.notifiableType,
    this.notifiableId,
    this.data,
    this.readAt,
    this.createdAt,
    this.updatedAt,
  });

  GetNotificationDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    notifiableType = json['notifiable_type'];
    notifiableId = json['notifiable_id'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    readAt = json['read_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['type'] = this.type;
    data['notifiable_type'] = this.notifiableType;
    data['notifiable_id'] = this.notifiableId;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['read_at'] = this.readAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class Data {
  int? orderId;
  String? status;
  String? message;

  Data({this.orderId, this.status, this.message});

  Data.fromJson(Map<String, dynamic> json) {
    orderId = json['order_id'];
    status = json['status'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['order_id'] = this.orderId;
    data['status'] = this.status;
    data['message'] = this.message;
    return data;
  }
}
