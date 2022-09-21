import 'dart:io';

import 'package:crypto_wallet_mobile/ressources/providers/network_utils/http_headers.dart';
import 'package:crypto_wallet_mobile/ressources/providers/network_utils/network_exceptions.dart';
import 'package:crypto_wallet_mobile/ressources/providers/network_utils/response_handler.dart';
import 'package:http/http.dart' as http;

class NotificationListProvider {
  Future<List<dynamic>> fetchNotifications() async {
    try {
      final response = await http.get(Uri.parse("$baseUrl/notification"),
          headers: authorisationHeaders);
      return ResponseHandler.handle(response);
    } on SocketException {
      throw NetworkConnectionError("Network connection error.");
    }
  }
}
