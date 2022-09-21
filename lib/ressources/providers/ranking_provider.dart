import 'dart:io';

import 'package:crypto_wallet_mobile/ressources/providers/network_utils/http_headers.dart';
import 'package:crypto_wallet_mobile/ressources/providers/network_utils/response_handler.dart';

import 'package:http/http.dart' as http;

import 'network_utils/network_exceptions.dart';

class RankingProvider {
  final rankingUrl = "$baseUrl/players";

  Future<List<dynamic>> fetchRanking() async {
    try {
      final response = await http.get(
        Uri.parse(rankingUrl),
        headers: authorisationHeaders,
      );
      return ResponseHandler.handle(response);
    } on SocketException {
      throw NetworkConnectionError("Network connection error.");
    }
  }
}
