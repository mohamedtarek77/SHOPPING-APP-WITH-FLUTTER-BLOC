import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../data_layer/models/Product.dart';
import '../../../data_layer/models/card.dart';

part 'card_event.dart';
part 'card_state.dart';

class CardBloc extends Bloc<CardEvent, CardState> {
  CardBloc() : super(CardLoading());
  @override
  Stream<CardState> mapEventToState(CardEvent event) async* {
    if (event is CardStarted) {
      yield* _mapCartStartedToMap();
    } else if (event is CardProductAdded) {
      yield* _mapCartProductAddedToState(event, state);
    }
    if (event is CardProductRemoved) {
      yield* _mapCartProductRemovedToState(event, state);
    }
  }

  @override
  // TODO: implement stream
  Stream<CardState> _mapCartStartedToMap() async* {
    yield CardLoading();
    try {
      await Future<void>.delayed(Duration(seconds: 1));
      yield CardLoaded();
    } catch (_) {}
  }

  @override
  // TODO: implement stream
  Stream<CardState> _mapCartProductAddedToState(
      CardProductAdded event, CardState state) async* {
    if (state is CardLoaded) {
      try {
        yield CardLoaded(
            card: Card(
                products: List.from(state.card.products)..add(event.product)));
      } catch (_) {}
    }
    return;
  }

  @override
  // TODO: implement stream
  Stream<CardState> _mapCartProductRemovedToState(
      CardProductRemoved event, CardState state) async* {
    if (state is CardLoaded) {
      try {
        yield CardLoaded(
            card: Card(
                products: List.from(state.card.products)
                  ..remove(event.product)));
      } catch (_) {}
    }
    return;
  }
}
