import '../ressources/providers/network_utils/api_response.dart';

import '../../models/logged_user_model.dart';
import '../../ressources/repositories/user_repository.dart';
import 'package:rxdart/rxdart.dart';

class UserBloc {
  final _userRepository = UserRepository();
  final _userFetcher = BehaviorSubject<ApiResponse<LoggedUser>>();
  late LoggedUser user;
  var isLogged = false;

  UserBloc() {
    _userFetcher.listen((value) {
      if (value.data != null) {
        user = value.data!;
      }
    });
  }

  Stream<ApiResponse<LoggedUser>> get getUser => _userFetcher.stream;

  Stream<ApiResponse<LoggedUser>> get loggedUser => _userFetcher.stream;

  logUser(String login, String password) async {
    _userFetcher.add(ApiResponse.loading("Attempting to connect..."));
    try {
      LoggedUser user = await _userRepository.loginUser(login, password);
      isLogged = true;
      _userFetcher.add(ApiResponse.loading("Successfully connected."));
      _userFetcher.add(ApiResponse.completed(user));
      this.user = user;
    } catch (e) {
      _userFetcher.add(ApiResponse.error(e.toString()));
    }
  }

  registerUser(String login, String mail, String password, String nom,
      String prenom) async {
    _userFetcher.add(ApiResponse.loading("Attempting to connect..."));
    try {
      LoggedUser user = await _userRepository.registerUser(
          login, mail, password, nom, prenom);
      isLogged = true;
      _userFetcher.add(ApiResponse.loading("Successfully connected."));
      _userFetcher.add(ApiResponse.completed(user));
      this.user = user;
    } catch (e) {
      _userFetcher.add(ApiResponse.error(e.toString()));
    }
  }
}

UserBloc userLoggedBloc = UserBloc();
