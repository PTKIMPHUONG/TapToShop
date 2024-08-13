import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../models/product.dart';
import '../../repositories/product_repository.dart';
import 'product_event.dart';
import 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductRepository _productRepository;
  StreamSubscription<List<Product>>? _productSubscription;

  ProductBloc(this._productRepository) : super(ProductInitial()) {
    on<LoadProducts>(_onLoadProducts);
    on<FilterProductsByCategory>(_onFilterProductsByCategory);
    on<SortProductsByPrice>(_onSortProductsByPrice);
  }

  // Handle load products event
  Future<void> _onLoadProducts(
    LoadProducts event, Emitter<ProductState> emit) async {
  emit(ProductLoading());
  try {
    _productSubscription?.cancel();
    _productSubscription = _productRepository.getProducts(
      query: event.query,
      sortAscending: event.sortAscending,
      category: event.category,
    ).listen((products) {
      emit(ProductLoaded(products));
    });
  } catch (e) {
    emit(ProductError(e.toString()));
  }
}

  // Handle filter products by category event
  Future<void> _onFilterProductsByCategory(
    FilterProductsByCategory event, Emitter<ProductState> emit) async {
  emit(ProductLoading());
  try {
    _productSubscription?.cancel();
    _productSubscription = _productRepository.getProductsByCategory(event.categoryId).listen((products) {
      emit(ProductLoaded(products));
    });
  } catch (e) {
    emit(ProductError(e.toString()));
  }
}


  // Handle sort products by price event
Future<void> _onSortProductsByPrice(
    SortProductsByPrice event, Emitter<ProductState> emit) async {
  emit(ProductLoading());
  try {
    _productSubscription?.cancel();
    _productSubscription = _productRepository.getProductsSortedByPrice(event.sortOrder).listen((products) {
      emit(ProductLoaded(products));
    });
  } catch (e) {
    emit(ProductError(e.toString()));
  }
}


  @override
  Future<void> close() {
    _productSubscription?.cancel();
    return super.close();
  }
}
