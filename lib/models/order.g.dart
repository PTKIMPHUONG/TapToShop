// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Order _$OrderFromJson(Map<String, dynamic> json) => Order(
      orderId: json['orderId'] as String,
      paymentMethod: json['paymentMethod'] as String,
      estimatedDeliveryFee: (json['estimatedDeliveryFee'] as num).toDouble(),
      totalAmount: (json['totalAmount'] as num).toDouble(),
      paymentStatus: json['paymentStatus'] as String,
      recipientName: json['recipientName'] as String,
      contactNumber: json['contactNumber'] as String,
      addressLine: json['addressLine'] as String,
      ward: json['ward'] as String,
      district: json['district'] as String,
      province: json['province'] as String,
      country: json['country'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$OrderToJson(Order instance) => <String, dynamic>{
      'orderId': instance.orderId,
      'paymentMethod': instance.paymentMethod,
      'estimatedDeliveryFee': instance.estimatedDeliveryFee,
      'totalAmount': instance.totalAmount,
      'paymentStatus': instance.paymentStatus,
      'recipientName': instance.recipientName,
      'contactNumber': instance.contactNumber,
      'addressLine': instance.addressLine,
      'ward': instance.ward,
      'district': instance.district,
      'province': instance.province,
      'country': instance.country,
      'createdAt': instance.createdAt.toIso8601String(),
    };
