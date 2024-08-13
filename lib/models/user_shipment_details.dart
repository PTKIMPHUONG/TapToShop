import 'package:json_annotation/json_annotation.dart';

part 'user_shipment_details.g.dart';

@JsonSerializable()
class UserShipmentDetails {
  final String recipientName;
  final String contactNumber;
  final String addressLine;
  final String ward;
  final String district;
  final String province;
  final String country;

  UserShipmentDetails({
    required this.recipientName,
    required this.contactNumber,
    required this.addressLine,
    required this.ward,
    required this.district,
    required this.province,
    required this.country,
  });

  factory UserShipmentDetails.fromJson(Map<String, dynamic> json) => _$UserShipmentDetailsFromJson(json);
  Map<String, dynamic> toJson() => _$UserShipmentDetailsToJson(this);
}
