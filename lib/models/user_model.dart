class User {
  final String login;
  final String mail;
  final String password;
  final String nom;
  final String prenom;

  User({
    required this.login,
    required this.mail,
    required this.password,
    required this.nom,
    required this.prenom,
  });
}

/*
factory User.fromJson(Map<String, dynamic> json) {
    return User(
      login: json["login"],
      mail: json["mail"],
      hash: json["hash"],
      nom: json["nom"],
      prenom: json["prenom"],
    );
  }
*/
