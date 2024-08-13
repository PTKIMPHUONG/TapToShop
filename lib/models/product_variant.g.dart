// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_variant.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductVariant _$ProductVariantFromJson(Map<String, dynamic> json) =>
    ProductVariant(
      variantId: json['variantId'] as String,
      variantItemName: json['variantItemName'] as String,
      defaultImage: json['defaultImage'] as String,
      stockQuantity: (json['stockQuantity'] as num).toInt(),
      color: json['color'] as String,
      size: json['size'] as String,
      price: (json['price'] as num).toDouble(),
      images: (json['images'] as List<dynamic>)
          .map((e) => ProductVariantImage.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ProductVariantToJson(ProductVariant instance) =>
    <String, dynamic>{
      'variantId': instance.variantId,
      'variantItemName': instance.variantItemName,
      'defaultImage': instance.defaultImage,
      'stockQuantity': instance.stockQuantity,
      'color': instance.color,
      'size': instance.size,
      'price': instance.price,
      'images': instance.images,
    };
