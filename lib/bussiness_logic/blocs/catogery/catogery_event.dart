part of 'catogery_bloc.dart';

@immutable
abstract class CatogeryEvent extends Equatable {
  const CatogeryEvent();

  @override
  List<Object> get props => [];
}

class LoadCategories extends CatogeryEvent {}

class UpdateCategories extends CatogeryEvent {
  final List<Category> categories;

  UpdateCategories(this.categories);
  @override
  List<Object> get props => [categories];
}
