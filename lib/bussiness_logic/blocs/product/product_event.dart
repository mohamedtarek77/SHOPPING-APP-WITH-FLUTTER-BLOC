part of 'product_bloc.dart';

@immutable
abstract class ProductEvent extends Equatable {
  const ProductEvent();
  @override
  List<Object> get props => [];
}

class Loadproducts extends ProductEvent {}

class Updateproducts extends ProductEvent {
  final List<Product> products;
  Updateproducts(this.products);
  @override
  List<Object> get props => [products];
}
