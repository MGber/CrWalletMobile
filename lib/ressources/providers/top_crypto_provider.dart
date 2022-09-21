import 'dart:io';
import 'package:crypto_wallet_mobile/ressources/providers/network_utils/http_headers.dart';
import 'package:http/http.dart' as http;

import 'network_utils/network_exceptions.dart';
import 'network_utils/response_handler.dart';

class CrypoApiProvider {
  Future<List<dynamic>> fetchData() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/coinList'),
        headers: authorisationHeaders,
      );
      return ResponseHandler.handle(response);
    } on SocketException {
      throw NetworkConnectionError("Network connection error");
    }
  }
}
