List<EarningDetails> earningDetailsFromJson(List<dynamic> earningDetailsJson) => List<EarningDetails>.from(
  earningDetailsJson.map((earningDetailsListJson) => EarningDetails.fromJson(earningDetailsListJson)),
);

class EarningDetails {
  int? id;
  String? vendorId;
  String? totalSales;
  String? totalCommission;
  String? netEarnings;
  String? createdAt;
  String? updatedAt;

  EarningDetails(
      {this.id,
      this.vendorId,
      this.totalSales,
      this.totalCommission,
      this.netEarnings,
      this.createdAt,
      this.updatedAt});

  EarningDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    vendorId = json['vendor_id'];
    totalSales = json['total_sales'];
    totalCommission = json['total_commission'];
    netEarnings = json['net_earnings'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['vendor_id'] = this.vendorId;
    data['total_sales'] = this.totalSales;
    data['total_commission'] = this.totalCommission;
    data['net_earnings'] = this.netEarnings;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}