// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Product _$ProductFromJson(Map<String, dynamic> json) => Product(
      productId: json['productId'] as String,
      productName: json['productName'] as String,
      description: json['description'] as String,
      price: (json['price'] as num).toDouble(),
      defaultImage: json['defaultImage'] as String,
      variants: (json['variants'] as List<dynamic>)
          .map((e) => ProductVariant.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ProductToJson(Product instance) => <String, dynamic>{
      'productId': instance.productId,
      'productName': instance.productName,
      'description': instance.description,
      'price': instance.price,
      'defaultImage': instance.defaultImage,
      'variants': instance.variants,
    };
