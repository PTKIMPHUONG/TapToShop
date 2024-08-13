import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/product_bloc/product_bloc.dart';
import '../blocs/product_bloc/product_event.dart';
import '../blocs/product_bloc/product_state.dart';

class ProductListView extends StatelessWidget {
  final String searchQuery;
  final bool sortAscending;
  final String selectedCategory;

  ProductListView({
    this.searchQuery = '',
    this.sortAscending = true,
    this.selectedCategory = 'all',
  });

  @override
  Widget build(BuildContext context) {
    context.read<ProductBloc>().add(
      LoadProducts(
        query: searchQuery,
        sortAscending: sortAscending,
        category: selectedCategory,
      ),
    );

    return Scaffold(
      appBar: AppBar(title: Text('Products')),
      body: BlocBuilder<ProductBloc, ProductState>(
        builder: (context, state) {
          if (state is ProductLoading) {
            return Center(child: CircularProgressIndicator());
          }
          if (state is ProductLoaded) {
            final products = state.products;
            return ListView.builder(
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];
                return Card(
                  child: ListTile(
                    leading: Image.network(product.defaultImage),
                    title: Text(product.productName),
                    subtitle: Text('\$${product.price.toStringAsFixed(2)}'),
                    onTap: () {
                      // Xử lý khi nhấn vào sản phẩm
                    },
                  ),
                );
              },
            );
          }
          if (state is ProductError) {
            return Center(child: Text('Error: ${state.message}'));
          }
          return Center(child: Text('No products available'));
        },
      ),
    );
  }
}
