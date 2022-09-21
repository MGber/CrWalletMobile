import 'dart:io';

import 'package:crypto_wallet_mobile/ressources/providers/network_utils/http_headers.dart';

import '../../ressources/providers/network_utils/network_exceptions.dart';
import '../../ressources/providers/network_utils/response_handler.dart';
import 'package:http/http.dart' as http;

class OrderProvider {
  Future<String> postOrder(String jsonOrder) async {
    var url = "$baseUrl/order";
    try {
      var reponse = await http.post(Uri.parse(url),
          body: jsonOrder, headers: authorisationHeaders);
      return ResponseHandler.handle(reponse);
    } on SocketException {
      throw NetworkConnectionError("Network connection error.");
    }
  }
}
