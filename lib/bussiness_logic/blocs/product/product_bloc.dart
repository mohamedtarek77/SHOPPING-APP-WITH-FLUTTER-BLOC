import 'dart:async';

import 'package:bloc/bloc.dart';
import '../../../data_layer/models/Product.dart';
import '../../../data_layer/repostories/product/product_repostery.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductRepostery _productRepostery;
  StreamSubscription? _productSubscription;

  ProductBloc({required ProductRepostery productRepostery})
      : _productRepostery = productRepostery,
        super(ProductLoading());
  @override
  Stream<ProductState> mapEventToState(ProductEvent event) async* {
    if (event is Loadproducts) {
      yield* _mapLoadProductsToState();
    }
    if (event is Updateproducts) {
      yield* _mapUptadeProductsToState(event);
    }
  }

  Stream<ProductState> _mapLoadProductsToState() async* {
    _productSubscription?.cancel();
    _productSubscription = _productRepostery.getAllProducts().listen(
          (products) => add(
            Updateproducts(products),
          ),
        );
  }

  Stream<ProductState> _mapUptadeProductsToState(Updateproducts event) async* {
    yield ProductLoaded(products: event.products);
  }
}
