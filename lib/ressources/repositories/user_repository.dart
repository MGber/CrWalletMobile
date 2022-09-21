import 'package:crypto_wallet_mobile/models/logged_user_model.dart';

import '../../ressources/providers/login_user_provider.dart';
import '../../ressources/providers/register_user_provider.dart';

class UserRepository {
  final LoginUserProvider _loginProvider = LoginUserProvider();
  final RegisterUserProvider _registerProvider = RegisterUserProvider();

  Future<LoggedUser> loginUser(String login, String password) async =>
      LoggedUser.fromJson(await _loginProvider.login(login, password));

  Future<LoggedUser> registerUser(String login, String mail, String password,
          String nom, String prenom) async =>
      LoggedUser.fromJson(await _registerProvider.registerUser(
          login, mail, password, nom, prenom));
}
x