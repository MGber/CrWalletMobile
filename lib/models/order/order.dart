import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'crypto_money.dart';

@immutable
class Order {
  final int idOrder;
  final String dateTransaction;
  final double quantity;
  final double unitPrice;
  final String mode;
  final CryptoMoney? cryptoMoney;

  const Order({
    required this.idOrder,
    required this.dateTransaction,
    required this.quantity,
    required this.unitPrice,
    required this.mode,
    required this.cryptoMoney,
  });

  factory Order.fromMap(Map<String, dynamic> data) {
    return Order(
      idOrder: data['idOrder'] as int,
      dateTransaction: data['dateTransaction'] as String,
      quantity: data['quantity'] as double,
      unitPrice: data['unitPrice'] as double,
      mode: data['mode'] as String,
      cryptoMoney: data['cryptoMoney'] == null
          ? null
          : CryptoMoney.fromMap(data['cryptoMoney'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'idOrder': idOrder,
      'dateTransaction': dateTransaction,
      'quantity': quantity,
      'unitPrice': unitPrice,
      'mode': mode,
      'cryptoMoney': cryptoMoney?.toMap(),
    };
  }

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Order].
  factory Order.fromJson(String data) {
    return Order.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Order] to a JSON string.
  String toJson() => json.encode(toMap());

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! Order) return false;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode =>
      idOrder.hashCode ^
      dateTransaction.hashCode ^
      quantity.hashCode ^
      unitPrice.hashCode ^
      mode.hashCode ^
      cryptoMoney.hashCode;

  String removeDecimalZeroFormat(double n) {
    return n.toStringAsFixed(n.truncateToDouble() == n ? 0 : 1);
  }
}
