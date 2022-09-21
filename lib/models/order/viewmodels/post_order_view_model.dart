import 'dart:convert';

class PostOrderViewModel {
  double quantity;
  double unitPrice;
  String mode;
  String idCrypto;

  PostOrderViewModel(
      {required this.quantity,
      required this.unitPrice,
      required this.mode,
      required this.idCrypto});

  Map<String, String> toMap() {
    return {
      'quantity': quantity.toString(),
      'unitPrice': unitPrice.toString(),
      'mode': mode,
      'idCrypto': idCrypto,
    };
  }

  String toJson() {
    return jsonEncode(toMap());
  }
}
