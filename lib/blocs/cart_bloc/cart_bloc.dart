import 'package:flutter_bloc/flutter_bloc.dart';
import 'cart_event.dart';
import 'cart_state.dart';
import '../../models/cart_item.dart'; 

class CartBloc extends Bloc<CartEvent, CartState> {
  final List<CartItem> _cartItems = [];

  CartBloc() : super(CartInitial()) {
    on<AddToCart>(_onAddToCart);
    on<RemoveFromCart>(_onRemoveFromCart);
    on<LoadCartItems>(_onLoadCartItems);
  }

  Future<void> _onAddToCart(AddToCart event, Emitter<CartState> emit) async {
    final existingItemIndex = _cartItems.indexWhere(
        (item) => item.product.productId == event.product.productId && item.variant == event.variant);

    if (existingItemIndex != -1) {
      _cartItems[existingItemIndex] = _cartItems[existingItemIndex].copyWith(quantity: _cartItems[existingItemIndex].quantity + 1);
    } else {
      _cartItems.add(CartItem(product: event.product, variant: event.variant, quantity: 1));
    }

    emit(CartUpdated(cartItems: List.from(_cartItems)));
  }

  Future<void> _onRemoveFromCart(RemoveFromCart event, Emitter<CartState> emit) async {
    _cartItems.removeWhere((item) => item.product.productId == event.product.productId);
    emit(CartUpdated(cartItems: List.from(_cartItems)));
  }

  Future<void> _onLoadCartItems(LoadCartItems event, Emitter<CartState> emit) async {
    emit(CartUpdated(cartItems: List.from(_cartItems)));
  }
}
