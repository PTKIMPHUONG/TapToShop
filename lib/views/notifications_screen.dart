import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/notification_bloc/notification_bloc.dart';
import '../blocs/notification_bloc/notification_state.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
      ),
      body: BlocBuilder<NotificationBloc, NotificationState>(
        builder: (context, state) {
          if (state is NotificationsLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is NotificationsLoaded) {
            if (state.notifications.isEmpty) {
              return Center(child: Text('No notifications'));
            }
            return ListView.builder(
              itemCount: state.notifications.length,
              itemBuilder: (context, index) {
                final orderId = state.notifications[index]; // Assuming notifications are just order IDs
                return ListTile(
                  title: Text('Notificaton: Order $orderId has been placed successfully.'),
                  subtitle: Text('Click to read details!'),
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      '/orderDetails',
                      arguments: orderId,
                    );
                  },
                );
              },
            );
          } else if (state is NotificationsError) {
            return Center(child: Text('Error: ${state.error}'));
          }
          return Center(child: Text('Loading notifications...'));
        },
      ),
    );
  }
}
