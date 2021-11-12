import '../../models/order.dart';

abstract class BaseOrderRepostory {
  Future<void> orderNow(Order order);
}
