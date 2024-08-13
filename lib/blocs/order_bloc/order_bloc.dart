import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../models/order.dart';
import '../../repositories/order_repository.dart';
import 'order_event.dart';
import 'order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  final OrderRepository _orderRepository;
  StreamSubscription<List<Order>>? _orderSubscription;

  OrderBloc(this._orderRepository) : super(OrdersInitial()) {
    on<LoadOrders>(_onLoadOrders);
    on<PlaceOrder>(_onPlaceOrder);
    on<LoadOrder>(_onLoadOrder); 
  }

  Future<void> _onLoadOrders(LoadOrders event, Emitter<OrderState> emit) async {
    emit(OrdersLoading());
    try {
      _orderSubscription?.cancel();
      _orderSubscription = _orderRepository.getOrders().asStream().listen((orders) {
        emit(OrdersLoaded(orders: orders));
      });
    } catch (e) {
      emit(OrderFailure(error: e.toString()));
    }
  }

  Future<void> _onPlaceOrder(PlaceOrder event, Emitter<OrderState> emit) async {
    emit(OrdersLoading());
    try {
      await _orderRepository.createOrder(event.order);
      emit(OrderSuccess());
    } catch (e) {
      emit(OrderFailure(error: e.toString()));
    }
  }

  Future<void> _onLoadOrder(LoadOrder event, Emitter<OrderState> emit) async {
    emit(OrdersLoading());
    try {
      final order = await _orderRepository.getOrder(event.orderId);
      if (order != null) {
        emit(OrdersLoaded(orders: [order])); 
      } else {
        emit(OrderFailure(error: 'Order not found'));
      }
    } catch (e) {
      emit(OrderFailure(error: e.toString()));
    }
  }

  @override
  Future<void> close() {
    _orderSubscription?.cancel();
    return super.close();
  }
}
