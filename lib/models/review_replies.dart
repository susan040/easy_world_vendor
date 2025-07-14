List<ReviewReplies> reviewRepliesFromJson(List<dynamic> reviewRepliesJson) =>
    List<ReviewReplies>.from(
      reviewRepliesJson.map(
        (reviewRepliesListJson) => ReviewReplies.fromJson(reviewRepliesListJson),
      ),
    );
class ReviewReplies {
  int? id;
  Review? review;
  Vendor? vendor;
  String? reply;
  String? createdAt;
  String? updatedAt;

  ReviewReplies({
    this.id,
    this.review,
    this.vendor,
    this.reply,
    this.createdAt,
    this.updatedAt,
  });

  ReviewReplies.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    review =
        json['review'] != null ? new Review.fromJson(json['review']) : null;
    vendor =
        json['vendor'] != null ? new Vendor.fromJson(json['vendor']) : null;
    reply = json['reply'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.review != null) {
      data['review'] = this.review!.toJson();
    }
    if (this.vendor != null) {
      data['vendor'] = this.vendor!.toJson();
    }
    data['reply'] = this.reply;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class Review {
  int? id;
  Customer? customer;
  Product? product;
  String? rating;
  String? comment;
  List<String>? reviewImages;
  String? createdAt;

  Review({
    this.id,
    this.customer,
    this.product,
    this.rating,
    this.comment,
    this.reviewImages,
    this.createdAt,
  });

  Review.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    customer =
        json['customer'] != null
            ? new Customer.fromJson(json['customer'])
            : null;
    product =
        json['product'] != null ? new Product.fromJson(json['product']) : null;
    rating = json['rating'];
    comment = json['comment'];
    reviewImages = json['review_images'].cast<String>();
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.customer != null) {
      data['customer'] = this.customer!.toJson();
    }
    if (this.product != null) {
      data['product'] = this.product!.toJson();
    }
    data['rating'] = this.rating;
    data['comment'] = this.comment;
    data['review_images'] = this.reviewImages;
    data['created_at'] = this.createdAt;
    return data;
  }
}

class Customer {
  int? id;
  String? name;

  Customer({this.id, this.name});

  Customer.fromJson(Map<String, dynamic> json) {
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

class Product {
  int? id;
  String? name;
  String? brand;
  String? price;
  String? description;
  List<String>? productImages;

  Product({
    this.id,
    this.name,
    this.brand,
    this.price,
    this.description,
    this.productImages,
  });

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    brand = json['brand'];
    price = json['price'];
    description = json['description'];
    productImages = json['product_images'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['brand'] = this.brand;
    data['price'] = this.price;
    data['description'] = this.description;
    data['product_images'] = this.productImages;
    return data;
  }
}

class Vendor {
  int? id;
  String? storeName;
  String? email;
  String? profileImage;

  Vendor({this.id, this.storeName, this.email, this.profileImage});

  Vendor.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    storeName = json['store_name'];
    email = json['email'];
    profileImage = json['profile_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['store_name'] = this.storeName;
    data['email'] = this.email;
    data['profile_image'] = this.profileImage;
    return data;
  }
}
