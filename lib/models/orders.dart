List<Orders> ordersFromJson(List<dynamic> ordersJson) => List<Orders>.from(
  ordersJson.map((ordersListJson) => Orders.fromJson(ordersListJson)),
);

class Orders {
  int? id;
  String? orderNo;
  Customer? customer;
  ShippingAddress? shippingAddress;
  ShippingAddress? billingAddress;
  Voucher? voucher;
  String? status;
  List<Items>? items;
  String? totalAmount;
  String? createdAt;
  List<Payments>? payments;

  Orders({
    this.id,
    this.orderNo,
    this.customer,
    this.shippingAddress,
    this.billingAddress,
    this.voucher,
    this.status,
    this.items,
    this.totalAmount,
    this.createdAt,
    this.payments,
  });

  Orders.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderNo = json['order_no'];
    customer =
        json['customer'] != null
            ? new Customer.fromJson(json['customer'])
            : null;
    shippingAddress =
        json['shipping_address'] != null
            ? new ShippingAddress.fromJson(json['shipping_address'])
            : null;
    billingAddress =
        json['billing_address'] != null
            ? new ShippingAddress.fromJson(json['billing_address'])
            : null;
    voucher =
        json['voucher'] != null ? new Voucher.fromJson(json['voucher']) : null;
    status = json['status'];
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items!.add(new Items.fromJson(v));
      });
    }
    totalAmount = json['total_amount'];
    createdAt = json['created_at'];
    if (json['payments'] != null) {
      payments = <Payments>[];
      json['payments'].forEach((v) {
        payments!.add(new Payments.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['order_no'] = this.orderNo;
    if (this.customer != null) {
      data['customer'] = this.customer!.toJson();
    }
    if (this.shippingAddress != null) {
      data['shipping_address'] = this.shippingAddress!.toJson();
    }
    if (this.billingAddress != null) {
      data['billing_address'] = this.billingAddress!.toJson();
    }
    if (this.voucher != null) {
      data['voucher'] = this.voucher!.toJson();
    }
    data['status'] = this.status;
    if (this.items != null) {
      data['items'] = this.items!.map((v) => v.toJson()).toList();
    }
    data['total_amount'] = this.totalAmount;
    data['created_at'] = this.createdAt;
    if (this.payments != null) {
      data['payments'] = this.payments!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Customer {
  int? id;
  int? userId;
  String? fullName;
  String? email;
  String? country;
  String? countryCode;
  String? phone;
  String? currencyPreference;
  String? gender;
  String? birthdate;
  String? profileImage;
  bool? otpVerified;
  String? createdAt;
  String? updatedAt;

  Customer({
    this.id,
    this.userId,
    this.fullName,
    this.email,
    this.country,
    this.countryCode,
    this.phone,
    this.currencyPreference,
    this.gender,
    this.birthdate,
    this.profileImage,
    this.otpVerified,
    this.createdAt,
    this.updatedAt,
  });

  Customer.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    fullName = json['full_name'];
    email = json['email'];
    country = json['country'];
    countryCode = json['country_code'];
    phone = json['phone'];
    currencyPreference = json['currency_preference'];
    gender = json['gender'];
    birthdate = json['birthdate'];
    profileImage = json['profile_image'];
    otpVerified = json['otp_verified'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['full_name'] = this.fullName;
    data['email'] = this.email;
    data['country'] = this.country;
    data['country_code'] = this.countryCode;
    data['phone'] = this.phone;
    data['currency_preference'] = this.currencyPreference;
    data['gender'] = this.gender;
    data['birthdate'] = this.birthdate;
    data['profile_image'] = this.profileImage;
    data['otp_verified'] = this.otpVerified;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class ShippingAddress {
  int? id;
  String? customerId;
  String? type;
  String? addressLine1;
  String? addressLine2;
  String? country;
  String? province;
  String? district;
  String? city;
  String? street;
  String? zipCode;
  String? createdAt;
  String? updatedAt;

  ShippingAddress({
    this.id,
    this.customerId,
    this.type,
    this.addressLine1,
    this.addressLine2,
    this.country,
    this.province,
    this.district,
    this.city,
    this.street,
    this.zipCode,
    this.createdAt,
    this.updatedAt,
  });

  ShippingAddress.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    customerId = json['customer_id'];
    type = json['type'];
    addressLine1 = json['address_line1'];
    addressLine2 = json['address_line2'];
    country = json['country'];
    province = json['province'];
    district = json['district'];
    city = json['city'];
    street = json['street'];
    zipCode = json['zip_code'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['customer_id'] = this.customerId;
    data['type'] = this.type;
    data['address_line1'] = this.addressLine1;
    data['address_line2'] = this.addressLine2;
    data['country'] = this.country;
    data['province'] = this.province;
    data['district'] = this.district;
    data['city'] = this.city;
    data['street'] = this.street;
    data['zip_code'] = this.zipCode;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class Voucher {
  int? id;
  String? code;
  String? type;
  String? value;
  String? minPurchase;
  String? validFrom;
  String? validUntil;
  String? usageLimit;
  String? usedCount;
  bool? isActive;
  String? applyType;
  String? createdAt;
  String? updatedAt;
  String? pivot;

  Voucher({
    this.id,
    this.code,
    this.type,
    this.value,
    this.minPurchase,
    this.validFrom,
    this.validUntil,
    this.usageLimit,
    this.usedCount,
    this.isActive,
    this.applyType,
    this.createdAt,
    this.updatedAt,
    this.pivot,
  });

  Voucher.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
    type = json['type'];
    value = json['value'];
    minPurchase = json['min_purchase'];
    validFrom = json['valid_from'];
    validUntil = json['valid_until'];
    usageLimit = json['usage_limit'];
    usedCount = json['used_count'];
    isActive = json['is_active'];
    applyType = json['apply_type'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    pivot = json['pivot'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['code'] = this.code;
    data['type'] = this.type;
    data['value'] = this.value;
    data['min_purchase'] = this.minPurchase;
    data['valid_from'] = this.validFrom;
    data['valid_until'] = this.validUntil;
    data['usage_limit'] = this.usageLimit;
    data['used_count'] = this.usedCount;
    data['is_active'] = this.isActive;
    data['apply_type'] = this.applyType;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['pivot'] = this.pivot;
    return data;
  }
}

class Items {
  int? id;
  String? productId;
  Product? product;
  String? quantity;
  String? size;
  String? color;
  String? price;

  Items({
    this.id,
    this.productId,
    this.product,
    this.quantity,
    this.size,
    this.color,
    this.price,
  });

  Items.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productId = json['product_id'];
    product =
        json['product'] != null ? new Product.fromJson(json['product']) : null;
    quantity = json['quantity'];
    size = json['size'];
    color = json['color'];
    price = json['price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['product_id'] = this.productId;
    if (this.product != null) {
      data['product'] = this.product!.toJson();
    }
    data['quantity'] = this.quantity;
    data['size'] = this.size;
    data['color'] = this.color;
    data['price'] = this.price;
    return data;
  }
}

class Product {
  String? name;
  String? brand;
  String? sku;
  String? priceSymbol;
  List<String>? productImages;

  Product({
    this.name,
    this.brand,
    this.sku,
    this.priceSymbol,
    this.productImages,
  });

  Product.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    brand = json['brand'];
    sku = json['sku'];
    priceSymbol = json['price_symbol'];
    productImages = json['product_images'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['brand'] = this.brand;
    data['sku'] = this.sku;
    data['price_symbol'] = this.priceSymbol;
    data['product_images'] = this.productImages;
    return data;
  }
}

class Payments {
  int? id;
  String? paymentMethod;
  String? transactionId;
  String? status;
  String? amount;
  String? createdAt;

  Payments({
    this.id,
    this.paymentMethod,
    this.transactionId,
    this.status,
    this.amount,
    this.createdAt,
  });

  Payments.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    paymentMethod = json['payment_method'];
    transactionId = json['transaction_id'];
    status = json['status'];
    amount = json['amount'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['payment_method'] = this.paymentMethod;
    data['transaction_id'] = this.transactionId;
    data['status'] = this.status;
    data['amount'] = this.amount;
    data['created_at'] = this.createdAt;
    return data;
  }
}
