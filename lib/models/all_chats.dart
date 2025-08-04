List<AllChats> allChatDetailsFromJson(List<dynamic> allChatDetailsJson) =>
    List<AllChats>.from(
      allChatDetailsJson.map(
        (allChatDetailsListJson) => AllChats.fromJson(allChatDetailsListJson),
      ),
    );

class AllChats {
  int? chatId;
  Product? product;
  Customer? customer;
  String? vendorMessage;
  String? vendorMessageTime;
  String? customerReply;
  String? customerReplyTime;

  AllChats({
    this.chatId,
    this.product,
    this.customer,
    this.vendorMessage,
    this.vendorMessageTime,
    this.customerReply,
    this.customerReplyTime,
  });

  AllChats.fromJson(Map<String, dynamic> json) {
    chatId = json['chat_id'];
    product =
        json['product'] != null ? new Product.fromJson(json['product']) : null;
    customer =
        json['customer'] != null
            ? new Customer.fromJson(json['customer'])
            : null;
    vendorMessage = json['vendor_message'];
    vendorMessageTime = json['vendor_message_time'];
    customerReply = json['customer_reply'];
    customerReplyTime = json['customer_reply_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['chat_id'] = this.chatId;
    if (this.product != null) {
      data['product'] = this.product!.toJson();
    }
    if (this.customer != null) {
      data['customer'] = this.customer!.toJson();
    }
    data['vendor_message'] = this.vendorMessage;
    data['vendor_message_time'] = this.vendorMessageTime;
    data['customer_reply'] = this.customerReply;
    data['customer_reply_time'] = this.customerReplyTime;
    return data;
  }
}

class Product {
  int? id;
  String? name;

  Product({this.id, this.name});

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}

class Customer {
  int? id;
  String? name;
  String? email;

  Customer({this.id, this.name, this.email});

  Customer.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    return data;
  }
}
