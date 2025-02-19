import 'dart:convert';

List<Product> productListFromJson(String str) =>
    List<Product>.from(json.decode(str).map((x) => Product.fromJson(x)));


String productListToJson(List<Product> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Product {
  final int id;
  final List<dynamic> variations;
  final bool inWishlist;
  final int? avgRating;
  final List<String>? images;
  final bool? variationExists;
  final int? salePrice;
  final List<Addon>? addons;
  final bool? available;
  final String? availableFrom;
  final String? availableTo;
  final String name;
  final String? description;
  final String? caption;
  final String? featuredImage;
  final int? mrp;
  final int? stock;
  final bool isActive;
  final String? discount;
  final String? createdDate;
  final String? productType;
  final int? showingOrder;
  final String? variationName;
  final int? category;
  final int? taxRate;

  Product({
    required this.id,
    this.variations = const [],
    required this.inWishlist,
    this.avgRating,
    this.images = const [],
    this.variationExists,
    this.salePrice,
    this.addons = const [],
    this.available,
    this.availableFrom,
    this.availableTo,
    required this.name,
    this.description,
    this.caption,
    this.featuredImage,
    this.mrp,
    this.stock,
    required this.isActive,
    this.discount,
    this.createdDate,
    this.productType,
    this.showingOrder,
    this.variationName,
    this.category,
    this.taxRate,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    id: json["id"],
    variations: List<dynamic>.from(json["variations"] ?? []),
    inWishlist: json["in_wishlist"],
    avgRating: json["avg_rating"],
    images: List<String>.from(json["images"] ?? []),
    variationExists: json["variation_exists"],
    salePrice: json["sale_price"],
    addons:
        json["addons"] == null
            ? []
            : List<Addon>.from(json["addons"].map((x) => Addon.fromJson(x))),

    available: json["available"],
    availableFrom: json["available_from"],
    availableTo: json["available_to"],
    name: json["name"],
    description: json["description"],
    caption: json["caption"],
    featuredImage: json["featured_image"],
    mrp: json["mrp"],
    stock: json["stock"],
    isActive: json["is_active"],
    discount: json["discount"],
    createdDate: json["created_date"],
    productType: json["product_type"],
    showingOrder: json["showing_order"],
    variationName: json["variation_name"],
    category: json["category"],
    taxRate: json["tax_rate"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "variations": variations,
    "in_wishlist": inWishlist,
    "avg_rating": avgRating,
    "images": images,
    "variation_exists": variationExists,
    "sale_price": salePrice,
    "addons":
        addons != null
            ? List<dynamic>.from(addons!.map((x) => x.toJson()))
            : [],

    "available": available,
    "available_from": availableFrom,
    "available_to": availableTo,
    "name": name,
    "description": description,
    "caption": caption,
    "featured_image": featuredImage,
    "mrp": mrp,
    "stock": stock,
    "is_active": isActive,
    "discount": discount,
    "created_date": createdDate,
    "product_type": productType,
    "showing_order": showingOrder,
    "variation_name": variationName,
    "category": category,
    "tax_rate": taxRate,
  };
}

class Addon {
  final int? id;
  final int? price;
  final String name;
  final String? description;
  final String featuredImage;
  final int? stock;
  final bool? isActive;
  final int? taxRate;

  Addon({
    this.id,
    this.price,
    required this.name,
    this.description,
    required this.featuredImage,
    this.stock,
    this.isActive,
    this.taxRate,
  });

  factory Addon.fromJson(Map<String, dynamic> json) => Addon(
    id: json["id"],
    price: json["price"],
    name: json["name"],
    description: json["description"],
    featuredImage: json["featured_image"],
    stock: json["stock"],
    isActive: json["is_active"],
    taxRate: json["tax_rate"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "price": price,
    "name": name,
    "description": description,
    "featured_image": featuredImage,
    "stock": stock,
    "is_active": isActive,
    "tax_rate": taxRate,
  };
}
