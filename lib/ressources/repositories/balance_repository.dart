import 'package:crypto_wallet_mobile/models/owned_cryptos/owned_cryptos.dart';
import 'package:crypto_wallet_mobile/ressources/providers/wallet_provider.dart';

import '../../ressources/providers/user_balance_provider.dart';
import '../../ressources/providers/user_crypto_balance_provider.dart';

class BalanceRepository {
  final _balanceProvider = BalanceProvider();
  final _cryptoBalanceProvider = CryptoBalanceProvider();
  final _walletProvider = WalletProvider();
  Future<double> getBalance() async {
    final response = await _balanceProvider.getUserBalance();
    return response["quantity"];
  }

  Future<double> getCryptoBalance(String cryptoId) async {
    final response =
        await _cryptoBalanceProvider.getUserCryptoBalance(cryptoId);
    return response["quantity"];
  }

  Future<List<OwnedCrypto>> getOwnedCrptos() async {
    final response = await _walletProvider.fetchWallet();
    return response.map((ownedCrypto) {
      return OwnedCrypto.fromMap(ownedCrypto);
    }).toList();
  }
}
