import 'package:equatable/equatable.dart';
import '../../models/order.dart';

abstract class OrderState extends Equatable {
  @override
  List<Object?> get props => [];
}

class OrdersInitial extends OrderState {}

class OrdersLoading extends OrderState {}

class OrdersLoaded extends OrderState {
  final List<Order> orders;

  OrdersLoaded({required this.orders});

  @override
  List<Object?> get props => [orders];
}

class OrderSuccess extends OrderState {}

class OrderFailure extends OrderState {
  final String error;

  OrderFailure({required this.error});

  @override
  List<Object?> get props => [error];
}
