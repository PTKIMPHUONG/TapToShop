import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/order_bloc/order_bloc.dart';
import '../blocs/order_bloc/order_state.dart';
import '../blocs/order_bloc/order_event.dart';
import '../repositories/order_repository.dart';

class OrderDetailsScreen extends StatelessWidget {
  final String orderId;

  OrderDetailsScreen({required this.orderId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Order Details'),
      ),
      body: BlocProvider(
        create: (context) => OrderBloc(
          RepositoryProvider.of<OrderRepository>(context),
        )..add(LoadOrder(orderId: orderId)),  
        child: OrderDetails(),
      ),
    );
  }
}

class OrderDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrderBloc, OrderState>(
      builder: (context, state) {
        if (state is OrdersLoading) {
          return Center(child: CircularProgressIndicator());
        } else if (state is OrdersLoaded) {
          final order = state.orders.isNotEmpty
              ? state.orders.first
              : null;
          if (order == null) {
            return Center(child: Text('Order not found'));
          }
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Order ID: ${order.orderId}', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                Text('Payment Method: ${order.paymentMethod}'),
                Text('Estimated Delivery Fee: \$${order.estimatedDeliveryFee}'),
                Text('Total Amount: \$${order.totalAmount}'),
                Text('Payment Status: ${order.paymentStatus}'),
                Text('Recipient Name: ${order.recipientName}'),
                Text('Contact Number: ${order.contactNumber}'),
                Text('Address: ${order.addressLine}, ${order.ward}, ${order.district}, ${order.province}, ${order.country}'),
                Text('Created At: ${order.createdAt.toLocal()}'),
              ],
            ),
          );
        } else if (state is OrderFailure) {
          return Center(child: Text('Error: ${state.error}'));
        }
        return Center(child: Text('Loading order details...'));
      },
    );
  }
}
