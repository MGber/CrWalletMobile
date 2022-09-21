import 'package:crypto_wallet_mobile/ressources/providers/coin_provider.dart';

import '../../models/crypto_data.dart';
import '../../ressources/providers/top_crypto_provider.dart';

/*This Repository class is the central point from 
where the data will flow to the BLOC.*/

class CryptoCoinsRepository {
  final CrypoApiProvider _apiProvider = CrypoApiProvider();
  final CoinProvider _coinProvider = CoinProvider();
  Future<List<CryptoCoin>> fetchAllCrypto() async {
    final response = await _apiProvider.fetchData();
    return response.map((data) => CryptoCoin.fromMap(data)).toList();
  }

  Future<CryptoCoin> getCrypto(String cryptoId) async {
    final response = await _coinProvider.getCoin(cryptoId);
    return CryptoCoin.fromMap(response);
  }
}
