import 'package:equatable/equatable.dart';

abstract class ProductEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadProducts extends ProductEvent {
  final String query;
  final bool sortAscending;
  final String category;

  LoadProducts({
    required this.query,
    required this.sortAscending,
    required this.category,
  });

  @override
  List<Object> get props => [query, sortAscending, category];
}

class FilterProductsByCategory extends ProductEvent {
  final String categoryId;

  FilterProductsByCategory(this.categoryId);

  @override
  List<Object> get props => [categoryId];
}

class SortProductsByPrice extends ProductEvent {
  final String sortOrder;

  SortProductsByPrice(this.sortOrder);

  @override
  List<Object> get props => [sortOrder];
}
