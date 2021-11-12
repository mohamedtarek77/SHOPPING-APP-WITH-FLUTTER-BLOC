import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

import '../../../data_layer/models/Product.dart';
import '../../../data_layer/models/card.dart';
import '../../../data_layer/models/order.dart';
import '../../../data_layer/repostories/order/order_repostory.dart';
import '../card/card_bloc.dart';

part 'order_event.dart';
part 'order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  final CardBloc _cardBloc;
  final OrderRepostory _orderRepostory;
  StreamSubscription? _cartSubscription;
  StreamSubscription? _orderSubscription;
  OrderBloc(
      {required CardBloc cardBloc, required OrderRepostory orderRepostory})
      : _cardBloc = cardBloc,
        _orderRepostory = orderRepostory,
        super(cardBloc.state is CardLoaded
            ? OrderLoaded(
                products: (cardBloc.state as CardLoaded).card.products,
                subtotal: (cardBloc.state as CardLoaded).card.subtotalString,
                deliveryFee:
                    (cardBloc.state as CardLoaded).card.deliveryFeeString,
                total: (cardBloc.state as CardLoaded).card.totalFeeString,
              )
            : OrderLoading()) {
    _cartSubscription = cardBloc.stream.listen((state) {
      if (state is CardLoaded) {
        add(UpdataOrder(card: state.card));
      }
    });
  }

  @override
  Stream<OrderState> mapEventToState(OrderEvent event) async* {
    if (event is UpdataOrder) {
      yield* _mapUptadeCheckOutToState(event, state);
    }
    if (event is ConfirmedOrder) {
      yield* _mapConfirmetCheckOutToState(event, state);
    }
  }

  Stream<OrderState> _mapUptadeCheckOutToState(
      UpdataOrder event, OrderState state) async* {
    if (state is OrderLoaded) {
      yield OrderLoaded(
        email: event.email ?? state.email,
        fullName: event.fullName ?? state.fullName,
        //
        products: event.card?.products ?? state.products,
        deliveryFee: event.card?.deliveryFeeString ?? state.deliveryFee,
        subtotal: event.card?.subtotalString ?? state.subtotal,
        total: event.card?.totalFeeString ?? state.total,
        //
        address: event.address ?? state.address,
        city: event.city ?? state.city,
        country: event.country ?? state.country,
        zipcode: event.zipcode ?? state.zipcode,
      );
    }
  }

  Stream<OrderState> _mapConfirmetCheckOutToState(
      ConfirmedOrder event, OrderState state) async* {
    _orderSubscription?.cancel();

    if (state is OrderLoaded) {
      try {
        await _orderRepostory.orderNow(event.order);
        print(' finally done thanks God');
      } catch (_) {}
    }
  }
}
