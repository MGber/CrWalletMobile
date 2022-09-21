class LoggedUser {
  late final String _login;
  late final String _token;

  LoggedUser(this._login, this._token);

  getLogin() {
    return _login;
  }

  getToken() {
    return _token;
  }

  factory LoggedUser.fromJson(Map<String, dynamic> json) {
    return LoggedUser(json["login"], json["token"]);
  }
}
