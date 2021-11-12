part of 'order_bloc.dart';

@immutable
abstract class OrderState extends Equatable {
  const OrderState();

  @override
  List<Object?> get props => [];
}

class OrderLoading extends OrderState {}

class OrderLoaded extends OrderState {
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
  final Order order;
  OrderLoaded({
    this.fullName,
    this.email,
    this.address,
    this.city,
    this.country,
    this.zipcode,
    this.products,
    this.subtotal,
    this.deliveryFee,
    this.total,
  }) : order = Order(
          fullName: fullName,
          email: email,
          address: address,
          city: city,
          country: country,
          zipcode: zipcode,
          products: products,
          subtotal: subtotal,
          deliveryFee: deliveryFee,
          total: total,
        );

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
}
