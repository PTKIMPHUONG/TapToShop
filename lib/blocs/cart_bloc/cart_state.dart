import 'package:equatable/equatable.dart';
import '../../models/cart_item.dart'; 

abstract class CartState extends Equatable {
  const CartState();

  @override
  List<Object> get props => [];
}

class CartInitial extends CartState {}

class CartLoading extends CartState {}

class CartUpdated extends CartState {
  final List<CartItem> cartItems;

  const CartUpdated({required this.cartItems});

  @override
  List<Object> get props => [cartItems];
}

class CartError extends CartState {
  final String error;

  const CartError({required this.error});

  @override
  List<Object> get props => [error];
}
