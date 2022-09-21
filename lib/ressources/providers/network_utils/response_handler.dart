import 'dart:convert';

import '../../../ressources/providers/network_utils/network_exceptions.dart';
import 'package:http/http.dart' as http;

class ResponseHandler {
  static dynamic handle(http.Response response, [String? message]) {
    switch (response.statusCode) {
      case 200:
        if (message == null || message.isEmpty) {
          try {
            return jsonDecode(response.body.toString());
          } on FormatException {
            return response.body.toString();
          }
        } else {
          return message;
        }
      case 403:
        throw ForbiddenException("Forbidden.");
      case 404:
        throw NotFoundException("Ressource not found.");
      case 500:
      default:
        throw InternalServerException("Internal server error.");
    }
  }
}
