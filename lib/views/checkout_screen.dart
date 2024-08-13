import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../blocs/order_bloc/order_bloc.dart';
import '../blocs/order_bloc/order_event.dart';
import '../models/order.dart';
import '../models/cart_item.dart';
import '../repositories/order_repository.dart';

class CheckoutScreen extends StatefulWidget {
  @override
  _CheckoutScreenState createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  final _formKey = GlobalKey<FormState>();
  final _recipientNameController = TextEditingController();
  final _contactNumberController = TextEditingController();
  final _addressLineController = TextEditingController();
  final _wardController = TextEditingController();
  final _districtController = TextEditingController();
  final _provinceController = TextEditingController();
  final _countryController = TextEditingController();
  String _paymentMethod = 'Credit Card';
  final double _estimatedDeliveryFee = 30.000; // Example fee

  @override
  void initState() {
    super.initState();
    _loadUserShipmentDetails();
  }

  Future<void> _loadUserShipmentDetails() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final userId = prefs.getString('userId'); 

      if (userId != null) {
        final userShipmentDetails = await RepositoryProvider.of<OrderRepository>(context).getUserShipmentDetails(userId);

        _recipientNameController.text = userShipmentDetails.recipientName;
        _contactNumberController.text = userShipmentDetails.contactNumber;
        _addressLineController.text = userShipmentDetails.addressLine;
        _wardController.text = userShipmentDetails.ward;
        _districtController.text = userShipmentDetails.district;
        _provinceController.text = userShipmentDetails.province;
        _countryController.text = userShipmentDetails.country;
      } else {
        // Handle case where user ID is not found
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('User not found')));
      }
    } catch (e) {
      // Handle errors
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to load shipment details')));
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<CartItem> selectedCartItems = ModalRoute.of(context)!.settings.arguments as List<CartItem>;

    // Calculate total amount including delivery fee
    final double subtotal = selectedCartItems.fold(
      0.0,
      (sum, item) => sum + item.totalPrice,
    );
    final double totalAmount = subtotal + _estimatedDeliveryFee;

    return Scaffold(
      appBar: AppBar(title: Text('Checkout')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _recipientNameController,
                decoration: InputDecoration(labelText: 'Recipient Name'),
                validator: (value) => value!.isEmpty ? 'Please enter recipient name' : null,
              ),
              TextFormField(
                controller: _contactNumberController,
                decoration: InputDecoration(labelText: 'Contact Number'),
                validator: (value) => value!.isEmpty ? 'Please enter contact number' : null,
              ),
              TextFormField(
                controller: _addressLineController,
                decoration: InputDecoration(labelText: 'Address Line'),
                validator: (value) => value!.isEmpty ? 'Please enter address line' : null,
              ),
              TextFormField(
                controller: _wardController,
                decoration: InputDecoration(labelText: 'Ward'),
              ),
              TextFormField(
                controller: _districtController,
                decoration: InputDecoration(labelText: 'District'),
              ),
              TextFormField(
                controller: _provinceController,
                decoration: InputDecoration(labelText: 'Province'),
              ),
              TextFormField(
                controller: _countryController,
                decoration: InputDecoration(labelText: 'Country'),
              ),
              SizedBox(height: 20),
              DropdownButton<String>(
                value: _paymentMethod,
                onChanged: (value) => setState(() => _paymentMethod = value!),
                items: <String>['Credit Card', 'PayPal', 'Bank Transfer']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                hint: Text('Select Payment Method'),
              ),
              SizedBox(height: 20),
              Text(
                'Subtotal: \$${subtotal.toStringAsFixed(2)}',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              Text(
                'Estimated Delivery Fee: \$${_estimatedDeliveryFee.toStringAsFixed(2)}',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              Text(
                'Total Amount: \$${totalAmount.toStringAsFixed(2)}',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    final order = Order(
                      orderId: DateTime.now().millisecondsSinceEpoch.toString(),
                      paymentMethod: _paymentMethod,
                      estimatedDeliveryFee: _estimatedDeliveryFee,
                      totalAmount: totalAmount,
                      paymentStatus: 'Pending',
                      recipientName: _recipientNameController.text,
                      contactNumber: _contactNumberController.text,
                      addressLine: _addressLineController.text,
                      ward: _wardController.text,
                      district: _districtController.text,
                      province: _provinceController.text,
                      country: _countryController.text,
                      createdAt: DateTime.now(),
                    );

                    BlocProvider.of<OrderBloc>(context).add(PlaceOrder(order: order));
                    Navigator.popUntil(context, ModalRoute.withName('/home')); // Navigate back to home or any desired screen
                  }
                },
                child: Text('Confirm Order'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
