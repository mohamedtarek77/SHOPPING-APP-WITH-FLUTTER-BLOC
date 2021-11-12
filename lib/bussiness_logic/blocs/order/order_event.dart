part of 'order_bloc.dart';

@immutable
abstract class OrderEvent extends Equatable {
  const OrderEvent();
  @override
  List<Object?> get props => [];
}

class UpdataOrder extends OrderEvent {
  final String? fullName;
  final String? email;
  final String? address;
  final String? city;
  final String? country;
  final String? zipcode;
  final Card? card;

  UpdataOrder({
    this.fullName,
    this.email,
    this.address,
    this.city,
    this.country,
    this.zipcode,
    this.card,
  });
  List<Object?> get props => [
        fullName,
        email,
        address,
        city,
        country,
        zipcode,
        card,
      ];
}

class ConfirmedOrder extends OrderEvent {
  final Order order;
  const ConfirmedOrder({required this.order});
  @override
  List<Object?> get props => [order];
}
