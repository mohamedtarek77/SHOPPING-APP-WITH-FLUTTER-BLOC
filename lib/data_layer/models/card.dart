import 'Product.dart';
import 'package:equatable/equatable.dart';

class Card extends Equatable {
  final List<Product> products;
  const Card({this.products = const <Product>[]});

  Map productQuantity(products) {
    var quantity = Map();
    products.forEach((product) {
      if (!quantity.containsKey(product)) {
        quantity[product] = 1;
      } else {
        quantity[product] += 1;
      }
    });
    return quantity;
  }

  double get subtotal =>
      products.fold(0, (total, current) => total + current.price);

  double deliveryFee(subtotal) {
    if (subtotal >= 100) {
      return 0.0;
    } else {
      return 10.0;
    }
  }

  double total(subtotal, deliveryFee) {
    return subtotal + deliveryFee(subtotal);
  }

  String freeDelivery(subtotal) {
    if (subtotal >= 100) {
      return 'you have Free Delivery';
    } else {
      double missing = 100.0 - subtotal;
      return 'Add \$${missing.toStringAsFixed(2)} for free Delivery';
    }
  }

  String get subtotalString => subtotal.toStringAsFixed(2);
  String get deliveryFeeString => deliveryFee(subtotal).toStringAsFixed(2);
  String get totalFeeString => total(subtotal, deliveryFee).toStringAsFixed(2);
  String get freeDeliveryString => freeDelivery(subtotal);

  @override
  List<Object?> get props => [products];
}
