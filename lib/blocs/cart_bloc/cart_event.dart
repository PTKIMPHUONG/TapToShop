import 'package:equatable/equatable.dart';
import '../../models/product.dart';
import '../../models/product_variant.dart';

abstract class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object> get props => [];
}

class AddToCart extends CartEvent {
  final Product product;
  final ProductVariant? variant;

  AddToCart({required this.product, this.variant});

  @override
  List<Object> get props => [product, variant ?? ''];
}

class RemoveFromCart extends CartEvent {
  final Product product;

  RemoveFromCart({required this.product});

  @override
  List<Object> get props => [product];
}

class LoadCartItems extends CartEvent {}
