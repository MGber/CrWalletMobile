import 'dart:convert';

import 'package:flutter/foundation.dart';

@immutable
class CryptoMoney {
  final String symbol;
  final String cryptoName;
  final String slug;

  const CryptoMoney(
      {required this.symbol, required this.cryptoName, required this.slug});

  factory CryptoMoney.fromMap(Map<String, dynamic> data) {
    return CryptoMoney(
      symbol: data['symbol'] as String,
      cryptoName: data['cryptoName'] as String,
      slug: data['slug'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'symbol': symbol,
      'cryptoName': cryptoName,
      'slug': slug,
    };
  }

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [CryptoMoney].
  factory CryptoMoney.fromJson(String data) {
    return CryptoMoney.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [CryptoMoney] to a JSON string.
  String toJson() => json.encode(toMap());

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! CryptoMoney) return false;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode => symbol.hashCode ^ cryptoName.hashCode ^ slug.hashCode;
}
