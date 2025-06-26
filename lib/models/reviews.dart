List<Reviews> reviewsFromJson(List<dynamic> reviewsJson) =>
    List<Reviews>.from(
      reviewsJson.map(
        (reviewsListJson) => Reviews.fromJson(reviewsListJson),
      ),
    );
class Reviews {
  int? id;
  Customer? customer;
  Product? product;
  String? rating;
  String? comment;
  List<String>? reviewImages;
  String? createdAt;

  Reviews(
      {this.id,
      this.customer,
      this.product,
      this.rating,
      this.comment,
      this.reviewImages,
      this.createdAt});

  Reviews.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    customer = json['customer'] != null
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

  Product(
      {this.id,
      this.name,
      this.brand,
      this.price,
      this.description,
      this.productImages});

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