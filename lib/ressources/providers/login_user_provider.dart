import 'dart:io';

import 'package:crypto/crypto.dart';
import '../../ressources/providers/network_utils/response_handler.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'network_utils/http_headers.dart';
import 'network_utils/network_exceptions.dart';

const String loginUrl = "$baseUrl/users/login";
const String loginTomcatUrl = "$baseUrl/users/login";

class LoginUserProvider {
  Future<dynamic> login(String login, String password) async {
    var bytes = utf8.encode(password); // data being hashed
    var digest = sha512.convert(bytes);
    password = digest.toString();

    var body = jsonEncode({'login': login, 'password': password});
    try {
      var response =
          await http.post(Uri.parse(loginUrl), body: body, headers: headers);
      return ResponseHandler.handle(response);
    } on SocketException {
      throw NetworkConnectionError("Network connection error.");
    }
  }
}
