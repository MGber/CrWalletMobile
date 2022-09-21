import '../models/owned_cryptos/owned_cryptos.dart';

import '../../ressources/providers/network_utils/api_response.dart';
import '../../ressources/repositories/balance_repository.dart';

import 'package:rxdart/rxdart.dart';

class UserBalanceBloc {
  final _balanceRepository = BalanceRepository();
  final _balanceFetcher = BehaviorSubject<ApiResponse<double>>();
  final _cryptoBalanceFetcher = BehaviorSubject<ApiResponse<double>>();
  final _walletFetcher = BehaviorSubject<ApiResponse<List<OwnedCrypto>>>();

  Stream<ApiResponse<double>> get userBalance => _balanceFetcher.stream;
  Stream<ApiResponse<double>> get userCryptoBalance =>
      _cryptoBalanceFetcher.stream;
  Stream<ApiResponse<List<OwnedCrypto>>> get wallet => _walletFetcher.stream;

  void fetchWallet() async {
    _walletFetcher.add(ApiResponse.loading("Loading wallet"));
    try {
      final response = await _balanceRepository.getOwnedCrptos();
      response.removeWhere((element) => element.total == 0.0);
      _walletFetcher.add(ApiResponse.completed(response));
    } catch (e) {
      _walletFetcher.add(ApiResponse.error(e.toString()));
    }
  }

  void fetchBalance() async {
    _balanceFetcher.add(ApiResponse.loading("Loading balance."));
    try {
      double response = await _balanceRepository.getBalance();
      _balanceFetcher.add(ApiResponse.completed(response));
    } catch (e) {
      _balanceFetcher.add(ApiResponse.error(e.toString()));
    }
  }

  void fetchCryptoBalance(String cryptoId) async {
    _cryptoBalanceFetcher.add(ApiResponse.loading("Loading crypto balance."));
    try {
      double response = await _balanceRepository.getCryptoBalance(cryptoId);
      _cryptoBalanceFetcher.add(ApiResponse.completed(response));
    } catch (e) {
      _cryptoBalanceFetcher.add(ApiResponse.error(e.toString()));
    }
  }
}

final userBalanceBloc = UserBalanceBloc();
