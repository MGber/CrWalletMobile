import 'dart:io';

import 'package:http/http.dart' as http;

import 'network_utils/http_headers.dart';
import 'network_utils/network_exceptions.dart';
import 'network_utils/response_handler.dart';

class MessageProvider {
  Future<List<dynamic>> fetchMessagesFor(String cryptoId) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/chat?cryptoId=$cryptoId'),
        headers: authorisationHeaders,
      );
      return ResponseHandler.handle(response);
    } on SocketException {
      throw NetworkConnectionError("Network connection error");
    }
  }
}
