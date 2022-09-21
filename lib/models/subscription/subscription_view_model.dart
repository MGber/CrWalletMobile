import 'dart:convert';

class SuscriptionVM {
  double price;
  String cryptoId;

  SuscriptionVM({
    required this.price,
    required this.cryptoId,
  });

  SuscriptionVM copyWith({
    double? price,
    String? cryptoId,
  }) {
    return SuscriptionVM(
      price: price ?? this.price,
      cryptoId: cryptoId ?? this.cryptoId,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'price': price,
      'cryptoId': cryptoId,
    };
  }

  factory SuscriptionVM.fromMap(Map<String, dynamic> map) {
    return SuscriptionVM(
      price: map['price']?.toDouble() ?? 0.0,
      cryptoId: map['cryptoId'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory SuscriptionVM.fromJson(String source) =>
      SuscriptionVM.fromMap(json.decode(source));

  @override
  String toString() => 'SuscriptionVM(price: $price, cryptoId: $cryptoId)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SuscriptionVM &&
        other.price == price &&
        other.cryptoId == cryptoId;
  }

  @override
  int get hashCode => price.hashCode ^ cryptoId.hashCode;
}
