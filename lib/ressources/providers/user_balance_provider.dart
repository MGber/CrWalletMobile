import 'dart:io';

import '../../blocs/user_bloc.dart';
import '../../ressources/providers/network_utils/response_handler.dart';
import 'package:http/http.dart' as http;

import 'network_utils/http_headers.dart';
import 'network_utils/network_exceptions.dart';

class BalanceProvider {
  Future<Map<String, dynamic>> getUserBalance() async {
    var url = "$baseUrl/balance";
    try {
      var response = await http.get(
        Uri.parse(url),
        headers: {
          HttpHeaders.authorizationHeader: userLoggedBloc.user.getToken(),
        },
      );
      return ResponseHandler.handle(response);
    } on SocketException {
      throw NetworkConnectionError("Network connection error");
    }
  }
}
