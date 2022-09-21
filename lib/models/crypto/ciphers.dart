import 'dart:convert';

import 'package:crypto/crypto.dart';

class Ciphers {
  static String hashPassword(String password) {
    var bytes = utf8.encode(password); // data being hashed
    var digest = sha512.convert(bytes);
    password = digest.toString();
    return password;
  }
}
