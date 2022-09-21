import 'dart:io';

import '../../models/crypto/ciphers.dart';
import '../../ressources/providers/network_utils/response_handler.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'network_utils/http_headers.dart';
import 'network_utils/network_exceptions.dart';

const String registerUrl = "$baseUrl/users/register";
const String registerTomcatUrl = "$baseUrl/users/register";

class RegisterUserProvider {
  Future<dynamic> registerUser(String login, String mail, String password,
      String nom, String prenom) async {
    password = Ciphers.hashPassword(password);
    var body = jsonEncode({
      'login': login,
      'mail': mail,
      'hash': password,
      'nom': nom,
      'prenom': prenom
    });
    try {
      var response =
          await http.post(Uri.parse(registerUrl), body: body, headers: headers);
      return ResponseHandler.handle(response);
    } on SocketException {
      throw NetworkConnectionError("Network connection error");
    }
  }
}
