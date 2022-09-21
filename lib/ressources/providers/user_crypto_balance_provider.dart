import 'dart:io';

import 'package:crypto_wallet_mobile/ressources/providers/network_utils/http_headers.dart';

import '../../ressources/providers/network_utils/network_exceptions.dart';
import '../../ressources/providers/network_utils/response_handler.dart';
import 'package:http/http.dart' as http;

class CryptoBalanceProvider {
  Future<dynamic> getUserCryptoBalance(String cryptoId) async {
    var url = "$baseUrl/balance?id=$cryptoId";
    try {
      var response =
          await http.get(Uri.parse(url), headers: authorisationHeaders);
      return ResponseHandler.handle(response);
    } on SocketException {
      throw NetworkConnectionError("Network connection error");
    }
  }
}
