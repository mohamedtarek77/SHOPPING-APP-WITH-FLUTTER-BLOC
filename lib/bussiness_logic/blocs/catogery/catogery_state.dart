part of 'catogery_bloc.dart';

@immutable
abstract class CatogeryState extends Equatable {
  const CatogeryState();
  @override
  List<Object> get props => [];
}

class CatogeryLoading extends CatogeryState {}

class CatogeryLoaded extends CatogeryState {
  final List<Category> catogeries;
  CatogeryLoaded({this.catogeries = const <Category>[]});
  @override
  List<Object> get props => [catogeries];
}
