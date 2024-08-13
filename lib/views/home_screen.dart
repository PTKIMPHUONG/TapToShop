import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../models/category.dart';
import '../../blocs/product_bloc/product_bloc.dart';
import '../../blocs/product_bloc/product_event.dart';
import '../../blocs/product_bloc/product_state.dart';
import '../repositories/product_repository.dart';
import 'product_detail_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  bool _isAscending = true;
  String _selectedCategory = 'all';
  List<Category> _categories = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ProductBloc>().add(LoadProducts(
          query: _searchQuery,
          sortAscending: _isAscending,
          category: _selectedCategory));
    });
    _loadCategories();
  }

  Future<void> _loadCategories() async {
    try {
      final categoriesStream =
          context.read<ProductRepository>().getCategories();
      categoriesStream.listen((categories) {
        setState(() {
          _categories = categories;
        });
      });
    } catch (e) {
      // Handle the error properly
      print('Failed to load categories: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product List'),
        actions: [
          IconButton(
            icon: Icon(Icons.sort),
            onPressed: () {
              setState(() {
                _isAscending = !_isAscending;
                context.read<ProductBloc>().add(LoadProducts(
                    query: _searchQuery,
                    sortAscending: _isAscending,
                    category: _selectedCategory));
              });
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Search Products',
                border: OutlineInputBorder(),
                suffixIcon: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    setState(() {
                      _searchQuery = _searchController.text;
                      context.read<ProductBloc>().add(LoadProducts(
                          query: _searchQuery,
                          sortAscending: _isAscending,
                          category: _selectedCategory));
                    });
                  },
                ),
              ),
            ),
          ),
          Container(
            height: 50,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _categories.length + 1, // +1 for "All" category
              itemBuilder: (context, index) {
                final category = index == 0 ? null : _categories[index - 1];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: TextButton(
                    onPressed: () {
                      setState(() {
                        _selectedCategory = category?.categoryId ?? 'all';
                        context.read<ProductBloc>().add(LoadProducts(
                            query: _searchQuery,
                            sortAscending: _isAscending,
                            category: _selectedCategory));
                      });
                    },
                    child: Text(category?.categoryName ?? 'All'),
                  ),
                );
              },
            ),
          ),
          Expanded(
            child: BlocBuilder<ProductBloc, ProductState>(
              builder: (context, state) {
                if (state is ProductLoading) {
                  return Center(child: CircularProgressIndicator());
                } else if (state is ProductLoaded) {
                  final products = state.products;
                  return ListView.builder(
                    itemCount: products.length,
                    itemBuilder: (context, index) {
                      final product = products[index];
                      return ListTile(
                        leading: Image.network(product.defaultImage),
                        title: Text(product.productName),
                        subtitle: Text('\$${product.price.toStringAsFixed(2)}'),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  ProductDetailScreen(product: product),
                            ),
                          );
                        },
                      );
                    },
                  );
                } else if (state is ProductError) {
                  return Center(child: Text('Error: ${state.message}'));
                }
                return Center(child: Text('No Products Found'));
              },
            ),
          ),
        ],
      ),
    );
  }
}
