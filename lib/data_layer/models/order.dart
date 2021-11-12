import 'package:equatable/equatable.dart';

import 'Product.dart';

class Order extends Equatable {
  final String? fullName;
  final String? email;
  final String? address;
  final String? city;
  final String? country;
  final String? zipcode;
  final List<Product>? products;
  final String? subtotal;
  final String? deliveryFee;
  final String? total;
  const Order({
    required this.fullName,
    required this.email,
    required this.address,
    required this.city,
    required this.country,
    required this.zipcode,
    required this.products,
    required this.subtotal,
    required this.deliveryFee,
    required this.total,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [
        fullName,
        email,
        address,
        city,
        country,
        zipcode,
        products,
        subtotal,
        deliveryFee,
        total,
      ];
  Map<String, Object> toDocument() {
    Map customerAddress = Map();

    customerAddress['adress'] = address;
    customerAddress['city'] = city;
    customerAddress['country'] = country;
    customerAddress['zipcode'] = zipcode;

    return {
      'customerAddress': customerAddress,
      'customerName': fullName!,
      'customerEmail': email!,
      'products': products!.map((Product) => Product.name).toList(),
      'subtotal': subtotal!,
      'deliveryFee': deliveryFee!,
      'total': total!,
    };
  }
}
