import 'package:json_annotation/json_annotation.dart';

part 'order.g.dart';

@JsonSerializable()
class Order {
  final String orderId;
  final String paymentMethod;
  final double estimatedDeliveryFee;
  final double totalAmount;
  final String paymentStatus;
  final String recipientName;
  final String contactNumber;
  final String addressLine;
  final String ward;
  final String district;
  final String province;
  final String country;
  final DateTime createdAt;

  Order({
    required this.orderId,
    required this.paymentMethod,
    required this.estimatedDeliveryFee,
    required this.totalAmount,
    required this.paymentStatus,
    required this.recipientName,
    required this.contactNumber,
    required this.addressLine,
    required this.ward,
    required this.district,
    required this.province,
    required this.country,
    required this.createdAt,
  });

  factory Order.fromJson(Map<String, dynamic> json) => _$OrderFromJson(json);
  Map<String, dynamic> toJson() => _$OrderToJson(this);
}
