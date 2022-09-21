class CryptoCoin {
  final String name;
  final String symbol;
  final String slug;
  final String priceUsd;
  final String volume24h;
  final String volumeChange24h;
  final String percentChange1h;
  final String percentChange24h;
  final String percentChange7d;
  final String percentChange30d;
  final String percentChange60d;
  final String percentChange90d;
  final String marketCap;
  final String imageUrl;

  CryptoCoin(
      {required this.name,
      required this.slug,
      required this.symbol,
      required this.priceUsd,
      required this.volume24h,
      required this.volumeChange24h,
      required this.percentChange1h,
      required this.percentChange24h,
      required this.percentChange7d,
      required this.percentChange30d,
      required this.percentChange60d,
      required this.percentChange90d,
      required this.marketCap,
      required this.imageUrl});

  factory CryptoCoin.fromMap(Map<String, dynamic> json) {
    return CryptoCoin(
        name: json["name"],
        slug: json["slug"],
        symbol: json["symbol"],
        priceUsd: double.parse(json["priceUsd"]).toStringAsFixed(4),
        volume24h: json["volume24h"].toString(),
        volumeChange24h:
            double.parse(json["volumeChange24h"]).toStringAsFixed(2),
        percentChange1h:
            double.parse(json["percentChange1h"]).toStringAsFixed(2),
        percentChange24h:
            double.parse(json["percentChange24h"]).toStringAsFixed(2),
        percentChange7d:
            double.parse(json["percentChange7d"]).toStringAsFixed(2),
        percentChange30d:
            double.parse(json["percentChange30d"]).toStringAsFixed(2),
        percentChange60d:
            double.parse(json["percentChange60d"]).toStringAsFixed(2),
        percentChange90d:
            double.parse(json["percentChange90d"]).toStringAsFixed(2),
        marketCap: json["marketCap"],
        imageUrl: json['imageUrl']);
  }

  // Credit : https://stackoverflow.com/questions/62177479/how-to-format-a-number-into-thousands-millions-and-billions-with-dart-flutter
  static String kmbGenerator(String num) {
    double parsed = double.parse(num);
    if (parsed > 999999 && parsed < 999999999) {
      return "${(parsed / 1000000).toStringAsFixed(1)} M";
    } else if (parsed > 999999999) {
      return "${(parsed / 1000000000).toStringAsFixed(1)} B";
    } else {
      return parsed.toString();
    }
  }

  match(String matcher) {
    matcher = matcher.toLowerCase();
    return slug.toLowerCase().contains(matcher) ||
        name.toLowerCase().contains(matcher) ||
        symbol.toLowerCase().contains(matcher);
  }
}
