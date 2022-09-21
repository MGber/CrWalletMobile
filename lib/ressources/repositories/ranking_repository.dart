import '../../models/player_model.dart';
import '../../ressources/providers/ranking_provider.dart';

class RankingRepository {
  final RankingProvider _rankingProvider = RankingProvider();
  Future<List<Player>> fetchRanking() async {
    final response = await _rankingProvider.fetchRanking();
    return response.map((data) => Player.fromJson(data)).toList();
  }
}
