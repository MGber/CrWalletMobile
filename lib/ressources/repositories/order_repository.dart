import 'package:crypto_wallet_mobile/ressources/providers/order_history_provider.dart';

import '../../models/order/order.dart';

import '../../models/order/viewmodels/post_order_view_model.dart';
import '../../ressources/providers/order_provider.dart';

class OrderRepository {
  final _orderProvider = OrderProvider();
  final _orderHistoryProvider = OrderHistoryProvider();

  Future<String> postOrder(
      double quantity, double unitPrice, String mode, String cryptoId) {
    PostOrderViewModel postOrderViewModel = PostOrderViewModel(
        unitPrice: unitPrice,
        idCrypto: cryptoId,
        mode: mode,
        quantity: quantity);
    String json = postOrderViewModel.toJson();
    return _orderProvider.postOrder(json);
  }

  Future<List<Order>> getOrderHistory() async {
    Future<List> response = _orderHistoryProvider.fetchOrders();
    return response.then((value) {
      return value.map((order) {
        return Order.fromMap(order);
      }).toList();
    });
  }
}
