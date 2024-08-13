// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_shipment_details.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserShipmentDetails _$UserShipmentDetailsFromJson(Map<String, dynamic> json) =>
    UserShipmentDetails(
      recipientName: json['recipientName'] as String,
      contactNumber: json['contactNumber'] as String,
      addressLine: json['addressLine'] as String,
      ward: json['ward'] as String,
      district: json['district'] as String,
      province: json['province'] as String,
      country: json['country'] as String,
    );

Map<String, dynamic> _$UserShipmentDetailsToJson(
        UserShipmentDetails instance) =>
    <String, dynamic>{
      'recipientName': instance.recipientName,
      'contactNumber': instance.contactNumber,
      'addressLine': instance.addressLine,
      'ward': instance.ward,
      'district': instance.district,
      'province': instance.province,
      'country': instance.country,
    };
