part of 'card_bloc.dart';

@immutable
abstract class CardState extends Equatable {
  const CardState();
  @override
  List<Object> get props => [];
}

class CardLoading extends CardState {
  @override
  List<Object> get props => [];
}

class CardLoaded extends CardState {
  final Card card;
  CardLoaded({this.card = const Card()});
  @override
  List<Object> get props => [card];
}

class CardError extends CardState {
  @override
  List<Object> get props => [];
}
