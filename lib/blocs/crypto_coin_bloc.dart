import '../../models/crypto_data.dart';
import '../../ressources/providers/network_utils/api_response.dart';
import '../../ressources/repositories/crypto_repository.dart';

import 'package:rxdart/rxdart.dart';

class CryptoCoinsBloc {
  final _repository = CryptoCoinsRepository();
  final _cryptoCoinsFetcher = BehaviorSubject<ApiResponse<List<CryptoCoin>>>();
  final _currentCrypto = BehaviorSubject<ApiResponse<CryptoCoin>>();
  final _selectedPercentage = BehaviorSubject<String>();

  late List<CryptoCoin> baseList;
  late String cryptoId;

  Stream<ApiResponse<List<CryptoCoin>>> get cryptoData =>
      _cryptoCoinsFetcher.stream;

  Stream<ApiResponse<CryptoCoin>> get currentCoin => _currentCrypto.stream;

  Stream<String> get percentageChange => _selectedPercentage.stream;

  void changeSelectedPercentage(String newPercentage) {
    _selectedPercentage.add(newPercentage);
  }

  void filterData(String matcher) {
    _cryptoCoinsFetcher.add(ApiResponse.error("Loading coin list"));
    try {
      var list = baseList.where((coin) => coin.match(matcher)).toList();
      _cryptoCoinsFetcher.add(ApiResponse.completed(list));
    } catch (e) {
      _cryptoCoinsFetcher.add(ApiResponse.error("Error while filtering data."));
    }
  }

  void fetchAllCoins() async {
    _cryptoCoinsFetcher.add(ApiResponse.loading("Loading coin list"));
    try {
      baseList = await _repository.fetchAllCrypto();
      baseList.sort((a, b) {
        return double.parse(b.marketCap).compareTo(double.parse(a.marketCap));
      });
      _cryptoCoinsFetcher.add(ApiResponse.completed(baseList));
    } catch (e) {
      _cryptoCoinsFetcher.add(ApiResponse.error(e.toString()));
    }
  }

  void setCurrentCoin(CryptoCoin selected) {
    cryptoId = selected.symbol;
    _currentCrypto.add(ApiResponse.loading("Loading current coin."));
    try {
      _currentCrypto.add(ApiResponse.completed(selected));
    } catch (e) {
      _currentCrypto.add(ApiResponse.error(e.toString()));
    }
  }

  void refreshCurrentCoin() async {
    _currentCrypto.add(ApiResponse.loading("Loading current coin."));
    try {
      _currentCrypto
          .add(ApiResponse.completed(await _repository.getCrypto(cryptoId)));
    } catch (e) {
      _currentCrypto.add(ApiResponse.error(e.toString()));
    }
  }

  dispose() {
    _cryptoCoinsFetcher.close();
  }
}

final coinsBloc = CryptoCoinsBloc();
