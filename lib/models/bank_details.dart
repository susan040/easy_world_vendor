List<BankDetails> bankDetailsFromJson(List<dynamic> bankDetailsJson) =>
    List<BankDetails>.from(
      bankDetailsJson.map(
        (bankDetailsListJson) => BankDetails.fromJson(bankDetailsListJson),
      ),
    );

class BankDetails {
  int? id;
  String? accountHolderName;
  String? accountNumber;
  String? branchName;
  String? bankName;
  Vendor? vendor;
  String? createdAt;
  String? updatedAt;

  BankDetails({
    this.id,
    this.accountHolderName,
    this.accountNumber,
    this.branchName,
    this.bankName,
    this.vendor,
    this.createdAt,
    this.updatedAt,
  });

  BankDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    accountHolderName = json['account_holder_name'];
    accountNumber = json['account_number'];
    branchName = json['branch_name'];
    bankName = json['bank_name'];
    vendor =
        json['vendor'] != null ? new Vendor.fromJson(json['vendor']) : null;
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['account_holder_name'] = this.accountHolderName;
    data['account_number'] = this.accountNumber;
    data['branch_name'] = this.branchName;
    data['bank_name'] = this.bankName;
    if (this.vendor != null) {
      data['vendor'] = this.vendor!.toJson();
    }
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class Vendor {
  int? id;
  String? storeName;
  String? email;

  Vendor({this.id, this.storeName, this.email});

  Vendor.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    storeName = json['store_name'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['store_name'] = this.storeName;
    data['email'] = this.email;
    return data;
  }
}
