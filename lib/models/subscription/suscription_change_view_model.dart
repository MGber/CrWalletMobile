import 'dart:convert';

class SuscriptionChangevm {
  double newPercent;
  bool isActive;
  String cryptoId;
  SuscriptionChangevm({
    required this.newPercent,
    required this.isActive,
    required this.cryptoId,
  });

  SuscriptionChangevm copyWith({
    double? newPercent,
    bool? isActive,
    String? cryptoId,
  }) {
    return SuscriptionChangevm(
      newPercent: newPercent ?? this.newPercent,
      isActive: isActive ?? this.isActive,
      cryptoId: cryptoId ?? this.cryptoId,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'newPercent': newPercent,
      'isActive': isActive,
      'cryptoId': cryptoId,
    };
  }

  factory SuscriptionChangevm.fromMap(Map<String, dynamic> map) {
    return SuscriptionChangevm(
      newPercent: map['newPercent']?.toDouble() ?? 0.0,
      isActive: map['isActive'] ?? false,
      cryptoId: map['cryptoId'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory SuscriptionChangevm.fromJson(String source) =>
      SuscriptionChangevm.fromMap(json.decode(source));

  @override
  String toString() =>
      'SuscriptionChangevm(newPercent: $newPercent, isActive: $isActive, cryptoId: $cryptoId)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SuscriptionChangevm &&
        other.newPercent == newPercent &&
        other.isActive == isActive &&
        other.cryptoId == cryptoId;
  }

  @override
  int get hashCode =>
      newPercent.hashCode ^ isActive.hashCode ^ cryptoId.hashCode;
}
