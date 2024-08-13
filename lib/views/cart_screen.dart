import 'package:flutter/material.dart';
import '../../blocs/cart_bloc/cart_bloc.dart';
import '../../blocs/cart_bloc/cart_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/cart_bloc/cart_event.dart';

class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final Set<int> _selectedItems = Set<int>(); // Store selected items

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart'),
      ),
      body: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          if (state is CartLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is CartUpdated) {
            if (state.cartItems.isEmpty) {
              return Center(child: Text('No items in cart'));
            }
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: state.cartItems.length,
                    itemBuilder: (context, index) {
                      final item = state.cartItems[index];
                      return ListTile(
                        leading: Image.network(item.product.defaultImage),
                        title: Text(item.product.productName),
                        subtitle: Text('\$${item.product.price}'),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(item.variant?.size ?? 'No variant selected'),
                            Checkbox(
                              value: _selectedItems.contains(index),
                              onChanged: (bool? checked) {
                                setState(() {
                                  if (checked == true) {
                                    _selectedItems.add(index);
                                  } else {
                                    _selectedItems.remove(index);
                                  }
                                });
                              },
                            ),
                            IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: () {
                                context.read<CartBloc>().add(RemoveFromCart(product: item.product));
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ElevatedButton(
                    onPressed: () {
                      if (_selectedItems.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('No items selected for checkout')));
                      } else {
                        // Convert selected items to a list of cart items to pass to checkout
                        final selectedCartItems = _selectedItems.map((index) => state.cartItems[index]).toList();
                        Navigator.pushNamed(context, '/checkout', arguments: selectedCartItems); // Navigate to checkout
                      }
                    },
                    child: Text('Proceed to Checkout'),
                  ),
                ),
              ],
            );
          } else if (state is CartError) {
            return Center(child: Text('Error: ${state.error}'));
          }
          return Center(child: Text('Loading cart...'));
        },
      ),
    );
  }
}
