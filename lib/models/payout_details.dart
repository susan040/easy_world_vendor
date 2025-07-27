List<PayoutDetails> payoutFromJson(List<dynamic> payoutJson) =>
    List<PayoutDetails>.from(
      payoutJson.map(
        (payoutListJson) => PayoutDetails.fromJson(payoutListJson),
      ),
    );

class PayoutDetails {
  int? id;
  String? vendorId;
  String? amount;
  String? status;
  String? paidAt;
  String? createdAt;
  String? updatedAt;

  PayoutDetails({
    this.id,
    this.vendorId,
    this.amount,
    this.status,
    this.paidAt,
    this.createdAt,
    this.updatedAt,
  });

  PayoutDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    vendorId = json['vendor_id'];
    amount = json['amount'];
    status = json['status'];
    paidAt = json['paid_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['vendor_id'] = this.vendorId;
    data['amount'] = this.amount;
    data['status'] = this.status;
    data['paid_at'] = this.paidAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
