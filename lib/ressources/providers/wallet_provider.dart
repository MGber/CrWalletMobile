import 'dart:io';
import 'package:crypto_wallet_mobile/ressources/providers/network_utils/http_headers.dart';

import 'package:http/http.dart' as http;

import 'network_utils/network_exceptions.dart';
import 'network_utils/response_handler.dart';

class WalletProvider {
  Future<List<dynamic>> fetchWallet() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/wallet'),
          headers: authorisationHeaders);
      return ResponseHandler.handle(response)["ownedCryptos"];
    } on SocketException {
      throw NetworkConnectionError("Network connection error");
    }
  }
}
