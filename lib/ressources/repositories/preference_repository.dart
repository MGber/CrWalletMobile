import 'package:crypto_wallet_mobile/models/subscription/get_subscription_vm.dart';
import 'package:crypto_wallet_mobile/models/subscription/suscription_change_view_model.dart';

import '../../models/subscription/subscription_view_model.dart';
import '../../ressources/providers/suscription_provider.dart';

class PreferenceRepository {
  final _suscriptionProvider = SuscriptionProvider();

  Future<List<GetSubscriptionVm>> getSuscriptions() async {
    final response = await _suscriptionProvider.getSuscriptions();
    return response.map((data) => GetSubscriptionVm.fromMap(data)).toList();
  }

  Future<String> deleteSuscription(String cryptoId) async {
    final response = await _suscriptionProvider.deleteSuscription(cryptoId);
    return response.toString();
  }

  Future<String> modifySuscription(
      double newPercent, bool isActive, String cryptoId) async {
    final response = await _suscriptionProvider.modifySuscription(
        SuscriptionChangevm(
            newPercent: newPercent, isActive: isActive, cryptoId: cryptoId));
    return response['message'];
  }

  Future<String> addSuscription(double price, String cryptoId) async {
    final response = await _suscriptionProvider
        .addSuscription(SuscriptionVM(price: price, cryptoId: cryptoId));
    return response['message'];
  }
}
