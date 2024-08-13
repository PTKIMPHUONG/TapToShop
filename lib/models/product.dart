import 'package:json_annotation/json_annotation.dart';
import 'product_variant.dart';

part 'product.g.dart';

@JsonSerializable()
class Product {
  final String productId;
  final String productName;
  final String description;
  final double price;
  final String defaultImage;
  final List<ProductVariant> variants;

  Product({
    required this.productId,
    required this.productName,
    required this.description,
    required this.price,
    required this.defaultImage,
    required this.variants,
  });

  factory Product.fromJson(Map<String, dynamic> json) => _$ProductFromJson(json);
  Map<String, dynamic> toJson() => _$ProductToJson(this);
}
