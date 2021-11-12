import '../../models/catogery.dart';

abstract class BaseCategoryRepostery {
  Stream<List<Category>> getAllCategories();
}
