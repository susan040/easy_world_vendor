List<Products> productsFromJson(List<dynamic> productsJson) =>
    List<Products>.from(
      productsJson.map(
        (productsListJson) => Products.fromJson(productsListJson),
      ),
    );

class Products {
  String? message;
  int? totalCount;
  List<Data>? data;

  Products({this.message, this.totalCount, this.data});

  Products.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    totalCount = json['total_count'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['total_count'] = this.totalCount;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? id;
  String? name;
  String? slug;
  String? sku;
  String? barcode;
  String? brand;
  String? price;
  String? costPrice;
  String? discount;
  String? discountType;
  String? quantity;
  Category? category;
  List<String>? tags;
  List<String>? color;
  List<String>? size;
  String? status;
  bool? isActive;
  String? description;
  List<String>? productImages;
  String? createdAt;

  Data(
      {this.id,
      this.name,
      this.slug,
      this.sku,
      this.barcode,
      this.brand,
      this.price,
      this.costPrice,
      this.discount,
      this.discountType,
      this.quantity,
      this.category,
      this.tags,
      this.color,
      this.size,
      this.status,
      this.isActive,
      this.description,
      this.productImages,
      this.createdAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    slug = json['slug'];
    sku = json['sku'];
    barcode = json['barcode'];
    brand = json['brand'];
    price = json['price'];
    costPrice = json['cost_price'];
    discount = json['discount'];
    discountType = json['discount_type'];
    quantity = json['quantity'];
    category = json['category'] != null
        ? new Category.fromJson(json['category'])
        : null;
    tags = json['tags'].cast<String>();
    color = json['color'].cast<String>();
    size = json['size'].cast<String>();
    status = json['status'];
    isActive = json['is_active'];
    description = json['description'];
    productImages = json['product_images'].cast<String>();
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['slug'] = this.slug;
    data['sku'] = this.sku;
    data['barcode'] = this.barcode;
    data['brand'] = this.brand;
    data['price'] = this.price;
    data['cost_price'] = this.costPrice;
    data['discount'] = this.discount;
    data['discount_type'] = this.discountType;
    data['quantity'] = this.quantity;
    if (this.category != null) {
      data['category'] = this.category!.toJson();
    }
    data['tags'] = this.tags;
    data['color'] = this.color;
    data['size'] = this.size;
    data['status'] = this.status;
    data['is_active'] = this.isActive;
    data['description'] = this.description;
    data['product_images'] = this.productImages;
    data['created_at'] = this.createdAt;
    return data;
  }
}

class Category {
  int? id;
  String? categoryName;
  String? categoryImage;
  String? createdAt;

  Category({this.id, this.categoryName, this.categoryImage, this.createdAt});

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryName = json['category_name'];
    categoryImage = json['category_image'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['category_name'] = this.categoryName;
    data['category_image'] = this.categoryImage;
    data['created_at'] = this.createdAt;
    return data;
  }
}