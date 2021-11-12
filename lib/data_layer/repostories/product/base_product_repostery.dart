import '../../models/Product.dart';

abstract class BaseProductRepostery {
  Stream<List<Product>> getAllProducts();
}
