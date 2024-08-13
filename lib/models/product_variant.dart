import 'package:json_annotation/json_annotation.dart';
import 'product_variant_image.dart';

part 'product_variant.g.dart';

@JsonSerializable()
class ProductVariant {
  final String variantId;
  final String variantItemName;
  final String defaultImage;
  final int stockQuantity;
  final String color;
  final String size;
  final double price;
  final List<ProductVariantImage> images;

  ProductVariant({
    required this.variantId,
    required this.variantItemName,
    required this.defaultImage,
    required this.stockQuantity,
    required this.color,
    required this.size,
    required this.price,
    required this.images,
  });

  factory ProductVariant.fromJson(Map<String, dynamic> json) => _$ProductVariantFromJson(json);
  Map<String, dynamic> toJson() => _$ProductVariantToJson(this);
}
