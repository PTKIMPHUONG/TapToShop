import 'package:flutter/material.dart';
import '../../models/product.dart';
import '../../models/product_variant.dart';
import '../../blocs/cart_bloc/cart_bloc.dart';
import '../../blocs/cart_bloc/cart_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductDetailScreen extends StatefulWidget {
  final Product product;

  ProductDetailScreen({required this.product});

  @override
  _ProductDetailScreenState createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  ProductVariant? _selectedVariant;
  String _selectedSize = '';
  String _selectedColor = '';

  @override
  Widget build(BuildContext context) {
    final sizes = widget.product.variants.map((v) => v.size).toSet().toList();
    final colors = widget.product.variants.map((v) => v.color).toSet().toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.product.productName),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(widget.product.defaultImage, fit: BoxFit.cover),
            SizedBox(height: 8),
            Text(
              widget.product.productName,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            Text(
              '\$${widget.product.price.toStringAsFixed(2)}',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: DropdownButton<String>(
                    value: _selectedSize.isEmpty ? null : _selectedSize,
                    hint: Text('Select Size'),
                    items: sizes
                        .map((size) => DropdownMenuItem(value: size, child: Text(size)))
                        .toList(),
                    onChanged: (size) {
                      setState(() {
                        _selectedSize = size ?? '';
                        _updateSelectedVariant();
                      });
                    },
                  ),
                ),
                SizedBox(width: 8),
                Expanded(
                  child: DropdownButton<String>(
                    value: _selectedColor.isEmpty ? null : _selectedColor,
                    hint: Text('Select Color'),
                    items: colors
                        .map((color) => DropdownMenuItem(value: color, child: Text(color)))
                        .toList(),
                    onChanged: (color) {
                      setState(() {
                        _selectedColor = color ?? '';
                        _updateSelectedVariant();
                      });
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            // Product Images
            if (_selectedVariant != null)
              Expanded(
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: _selectedVariant!.images.length,
                  itemBuilder: (context, index) {
                    final image = _selectedVariant!.images[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4.0),
                      child: Image.network(image.url, fit: BoxFit.cover), 
                    );
                  },
                ),
              ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                if (_selectedVariant != null) {
                  context.read<CartBloc>().add(AddToCart(product: widget.product, variant: _selectedVariant));
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Added to cart')));
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Please select size and color')));
                }
              },
              child: Text('Add to Cart'),
            ),
          ],
        ),
      ),
    );
  }

  void _updateSelectedVariant() {
    _selectedVariant = widget.product.variants.firstWhere(
      (v) => v.size == _selectedSize && v.color == _selectedColor,
      orElse: () => widget.product.variants.firstWhere(
        (v) => v.size == _selectedSize || v.color == _selectedColor,
        orElse: () => widget.product.variants.first,
      ),
    );
  }
}
