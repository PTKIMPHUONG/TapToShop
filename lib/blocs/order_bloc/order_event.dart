import 'package:equatable/equatable.dart';
import '../../models/order.dart';

abstract class OrderEvent extends Equatable {
  const OrderEvent();

  @override
  List<Object> get props => [];
}

class LoadOrders extends OrderEvent {}

class LoadOrder extends OrderEvent {
  final String orderId;

  const LoadOrder({required this.orderId});

  @override
  List<Object> get props => [orderId];
}

class PlaceOrder extends OrderEvent {
  final Order order;

  const PlaceOrder({required this.order});

  @override
  List<Object> get props => [order];
}
