import 'package:json_annotation/json_annotation.dart';
import '../../models/product.dart';
import '../../models/product_variant.dart';

part 'cart_item.g.dart';

@JsonSerializable()
class CartItem {
  final Product product;
  final ProductVariant? variant;
  final int quantity;

  CartItem({
    required this.product,
    this.variant,
    this.quantity = 1,
  });

  CartItem copyWith({
    Product? product,
    ProductVariant? variant,
    int? quantity,
  }) {
    return CartItem(
      product: product ?? this.product,
      variant: variant ?? this.variant,
      quantity: quantity ?? this.quantity,
    );
  }

  double get totalPrice => product.price * quantity;

  factory CartItem.fromJson(Map<String, dynamic> json) => _$CartItemFromJson(json);
  Map<String, dynamic> toJson() => _$CartItemToJson(this);
}
