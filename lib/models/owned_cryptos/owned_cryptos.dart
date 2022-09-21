import 'dart:convert';

import 'package:collection/collection.dart';

class OwnedCrypto {
  String idCrypto;
  double total;
  double value;

  OwnedCrypto(
      {required this.idCrypto, required this.total, required this.value});

  factory OwnedCrypto.fromMap(Map<String, dynamic> data) {
    return OwnedCrypto(
      idCrypto: data['id_crypto'] as String,
      total: data['total'] as double,
      value: data['value'] as double,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id_crypto': idCrypto,
      'total': total,
      'value': value,
    };
  }

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [OwnedCrypto].
  factory OwnedCrypto.fromJson(String data) {
    return OwnedCrypto.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [OwnedCrypto] to a JSON string.
  String toJson() => json.encode(toMap());

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! OwnedCrypto) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode => idCrypto.hashCode ^ total.hashCode ^ value.hashCode;
}
