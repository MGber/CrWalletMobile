import 'package:crypto_wallet_mobile/models/crypto_data.dart';

import '../models/order/order.dart';
import '../../blocs/crypto_coin_bloc.dart';
import '../../blocs/user_balance_bloc.dart';
import '../../ressources/providers/network_utils/api_response.dart';
import '../../ressources/repositories/order_repository.dart';
import 'package:rxdart/rxdart.dart';

class OrderBloc {
  final _orderRepository = OrderRepository();
  final _orderFetcher = BehaviorSubject<ApiResponse<String>>();
  final _orderHistoryFetcher = BehaviorSubject<ApiResponse<List<Order>>>();
  final _orderPrice = BehaviorSubject<String>();

  late String mode;
  late String cryptoId;

  Stream<ApiResponse<String>> get orderResult => _orderFetcher.stream;
  Stream<ApiResponse<List<Order>>> get orderHistory =>
      _orderHistoryFetcher.stream;
  Stream<String> get orderPrice => _orderPrice.stream;

  void changeOrderPrice(String newPrice) => _orderPrice.add(newPrice);

  setBeforeOrder(orderMode mode, String cryptoId) {
    if (mode == orderMode.achat) {
      this.mode = "ACHAT";
    } else {
      this.mode = "VENTE";
    }
    this.cryptoId = cryptoId;
  }

  void makeOrder(double quantity) async {
    _orderFetcher.add(ApiResponse.loading("Order in progress."));
    ApiResponse<CryptoCoin> apiResponse = await coinsBloc.currentCoin.first;
    final currentCoin = apiResponse.data;
    try {
      var priceUsd2 = currentCoin!.priceUsd;
      String response = await _orderRepository.postOrder(
          quantity, double.parse(priceUsd2), mode, cryptoId);
      _orderFetcher.add(ApiResponse.completed(response));
    } catch (e) {
      _orderFetcher.add(ApiResponse.error(e.toString()));
    }
    userBalanceBloc.fetchBalance();
    userBalanceBloc.fetchCryptoBalance(currentCoin!.symbol);
  }

  void fetchHistory() async {
    _orderHistoryFetcher.add(ApiResponse.loading("Loading order history."));
    try {
      var response = await _orderRepository.getOrderHistory();
      _orderHistoryFetcher.add(ApiResponse.completed(response));
    } catch (e) {
      _orderHistoryFetcher.add(ApiResponse.error(e.toString()));
    }
  }
}

final orderbloc = OrderBloc();

enum orderMode { achat, vente }
