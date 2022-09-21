import 'dart:convert';

class GetSubscriptionVm {
  bool? isActive;
  double? percent;
  String? cryptoId;
  GetSubscriptionVm({
    this.isActive,
    this.percent,
    this.cryptoId,
  });

  GetSubscriptionVm copyWith({
    bool? isActive,
    double? percent,
    String? cryptoId,
  }) {
    return GetSubscriptionVm(
      isActive: isActive ?? this.isActive,
      percent: percent ?? this.percent,
      cryptoId: cryptoId ?? this.cryptoId,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'isActive': isActive,
      'percent': percent,
      'cryptoId': cryptoId,
    };
  }

  factory GetSubscriptionVm.fromMap(Map<String, dynamic> map) {
    return GetSubscriptionVm(
      isActive: map['is_active'],
      percent: map['percent']?.toDouble(),
      cryptoId: map['cryptoId'],
    );
  }

  String toJson() => json.encode(toMap());

  factory GetSubscriptionVm.fromJson(String source) =>
      GetSubscriptionVm.fromMap(json.decode(source));

  @override
  String toString() =>
      'GetSubscriptionVm(isActive: $isActive, percent: $percent, cryptoId: $cryptoId)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is GetSubscriptionVm &&
        other.isActive == isActive &&
        other.percent == percent &&
        other.cryptoId == cryptoId;
  }

  @override
  int get hashCode => isActive.hashCode ^ percent.hashCode ^ cryptoId.hashCode;
}
