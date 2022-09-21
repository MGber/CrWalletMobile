import 'dart:io';

import '../../ressources/providers/network_utils/network_exceptions.dart';
import '../../ressources/providers/network_utils/response_handler.dart';
import 'package:http/http.dart' as http;

import 'network_utils/http_headers.dart';

class OrderHistoryProvider {
  Future<List<dynamic>> fetchOrders() async {
    const url = "$baseUrl/order";
    try {
      final response =
          await http.get(Uri.parse(url), headers: authorisationHeaders);
      return ResponseHandler.handle(response);
    } on SocketException {
      throw NetworkConnectionError("Network connection error");
    }
  }
}
