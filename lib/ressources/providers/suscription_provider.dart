import 'dart:io';

import '../../models/subscription/suscription_change_view_model.dart';
import '../../ressources/providers/network_utils/http_headers.dart';
import '../../ressources/providers/network_utils/network_exceptions.dart';
import '../../ressources/providers/network_utils/response_handler.dart';
import '../../models/subscription/subscription_view_model.dart';
import 'package:http/http.dart' as http;

class SuscriptionProvider {
  Future<dynamic> addSuscription(SuscriptionVM vm) async {
    try {
      final response = await http.post(Uri.parse("$baseUrl/preference"),
          body: vm.toJson(), headers: authorisationHeaders);
      return ResponseHandler.handle(response);
    } on SocketException {
      throw NetworkConnectionError("Network connection error.");
    }
  }

  Future<dynamic> deleteSuscription(String cryptoId) async {
    try {
      final response = await http.delete(
          Uri.parse("$baseUrl/preference?cryptoId=$cryptoId"),
          headers: authorisationHeaders);
      return ResponseHandler.handle(response);
    } on SocketException {
      throw NetworkConnectionError("Network connection error.");
    }
  }

  Future<List<dynamic>> getSuscriptions() async {
    try {
      final response = await http.get(Uri.parse("$baseUrl/preference"),
          headers: authorisationHeaders);
      return ResponseHandler.handle(response);
    } on SocketException {
      throw NetworkConnectionError("Network connection error.");
    }
  }

  Future<dynamic> modifySuscription(SuscriptionChangevm vm) async {
    try {
      final response = await http.put(Uri.parse("$baseUrl/preference"),
          headers: authorisationHeaders, body: vm.toJson());
      return ResponseHandler.handle(response);
    } on SocketException {
      throw NetworkConnectionError("Network connection error.");
    }
  }
}
