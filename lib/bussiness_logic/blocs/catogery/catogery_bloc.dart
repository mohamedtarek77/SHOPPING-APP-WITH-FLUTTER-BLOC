import 'dart:async';

import 'package:bloc/bloc.dart';
import '../../../data_layer/models/catogery.dart';
import '../../../data_layer/repostories/catogery/catogery_repostery.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

part 'catogery_event.dart';
part 'catogery_state.dart';

class CatogeryBloc extends Bloc<CatogeryEvent, CatogeryState> {
  final CatogeryRepostery _catogeryRepostery;
  StreamSubscription? _catogerySubscription;

  CatogeryBloc({required CatogeryRepostery catogeryRepostery})
      : _catogeryRepostery = catogeryRepostery,
        super(CatogeryLoading());
  @override
  Stream<CatogeryState> mapEventToState(CatogeryEvent event) async* {
    if (event is LoadCategories) {
      yield* _mapLoadCategoriesToState();
    }
    if (event is UpdateCategories) {
      yield* _mapUpdateCategoriesToState(event);
    }
  }

  Stream<CatogeryState> _mapLoadCategoriesToState() async* {
    _catogerySubscription?.cancel();
    _catogerySubscription = _catogeryRepostery.getAllCategories().listen(
          (categories) => add(
            UpdateCategories(categories),
          ),
        );
  }

  Stream<CatogeryState> _mapUpdateCategoriesToState(
      UpdateCategories event) async* {
    yield CatogeryLoaded(catogeries: event.categories);
  }
}
