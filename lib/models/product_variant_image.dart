import 'package:json_annotation/json_annotation.dart';

part 'product_variant_image.g.dart';

@JsonSerializable()
class ProductVariantImage {
  final String imageId;
  final String url;

  ProductVariantImage({
    required this.imageId,
    required this.url,
  });

  factory ProductVariantImage.fromJson(Map<String, dynamic> json) => _$ProductVariantImageFromJson(json);
  Map<String, dynamic> toJson() => _$ProductVariantImageToJson(this);
}
