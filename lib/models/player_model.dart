class Player implements Comparable<Player> {
  String login;
  String totalValue;

  Player({
    required this.login,
    required this.totalValue,
  });

  factory Player.fromJson(Map<String, dynamic> json) => Player(
      login: json["currentLogin"],
      totalValue: (json["total"]).toStringAsFixed(2));

  @override
  int compareTo(Player other) {
    return (double.parse(totalValue) - double.parse(other.totalValue)).round();
  }
}
