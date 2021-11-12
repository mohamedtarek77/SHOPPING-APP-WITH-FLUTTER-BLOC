part of 'card_bloc.dart';

@immutable
abstract class CardEvent extends Equatable {
  const CardEvent();

  @override
  List<Object> get props => [];
}

class CardStarted extends CardEvent {
  @override
  List<Object> get props => [];
}

class CardProductAdded extends CardEvent {
  final Product product;
  const CardProductAdded(this.product);
  @override
  List<Object> get props => [product];
}

class CardProductRemoved extends CardEvent {
  final Product product;
  const CardProductRemoved(this.product);
  @override
  List<Object> get props => [product];
}
