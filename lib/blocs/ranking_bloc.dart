import '../ressources/providers/network_utils/api_response.dart';

import '../../models/player_model.dart';
import '../../ressources/repositories/ranking_repository.dart';
import 'package:rxdart/rxdart.dart';

class RankingBloc {
  final _rankingRepository = RankingRepository();
  final _rankingFetcher = BehaviorSubject<ApiResponse<List<Player>>>();

  Stream<ApiResponse<List<Player>>> get ranking => _rankingFetcher.stream;

  generateRanking() async {
    _rankingFetcher.add(ApiResponse.loading("Loading ranking"));
    try {
      List<Player> ranking = await _rankingRepository.fetchRanking();
      _rankingFetcher.add(ApiResponse.completed(ranking));
    } catch (e) {
      _rankingFetcher.add(ApiResponse.error(e.toString()));
    }
  }
}

final rankingBloc = RankingBloc();
