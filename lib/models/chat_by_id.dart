List<ChatWithID> chatWithIdFromJson(List<dynamic> chatWithIdJson) =>
    List<ChatWithID>.from(
      chatWithIdJson.map(
        (chatWithIdListJson) => ChatWithID.fromJson(chatWithIdListJson),
      ),
    );

class ChatWithID {
  int? chatId;
  Product? product;
  Customer? customer;
  List<Messages>? messages;

  ChatWithID({this.chatId, this.product, this.customer, this.messages});

  ChatWithID.fromJson(Map<String, dynamic> json) {
    chatId = json['chat_id'];
    product =
        json['product'] != null ? new Product.fromJson(json['product']) : null;
    customer =
        json['customer'] != null
            ? new Customer.fromJson(json['customer'])
            : null;
    if (json['messages'] != null) {
      messages = <Messages>[];
      json['messages'].forEach((v) {
        messages!.add(new Messages.fromJson(v));
      });
    }
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
    if (this.messages != null) {
      data['messages'] = this.messages!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Product {
  int? id;
  String? name;
  String? price;

  Product({this.id, this.name, this.price});

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price = json['price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['price'] = this.price;
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

class Messages {
  int? id;
  String? chatId;
  String? senderType;
  Customer? sender;
  String? message;
  String? readAt;
  String? createdAt;

  Messages({
    this.id,
    this.chatId,
    this.senderType,
    this.sender,
    this.message,
    this.readAt,
    this.createdAt,
  });

  Messages.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    chatId = json['chat_id'];
    senderType = json['sender_type'];
    sender =
        json['sender'] != null ? new Customer.fromJson(json['sender']) : null;
    message = json['message'];
    readAt = json['read_at'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['chat_id'] = this.chatId;
    data['sender_type'] = this.senderType;
    if (this.sender != null) {
      data['sender'] = this.sender!.toJson();
    }
    data['message'] = this.message;
    data['read_at'] = this.readAt;
    data['created_at'] = this.createdAt;
    return data;
  }
}
