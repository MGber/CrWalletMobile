import 'package:crypto_wallet_mobile/blocs/user_bloc.dart';
import 'package:crypto_wallet_mobile/models/subscription/get_subscription_vm.dart';
import 'package:stomp_dart_client/stomp.dart';
import 'package:stomp_dart_client/stomp_config.dart';
import 'package:stomp_dart_client/stomp_frame.dart';
import '../../ressources/providers/network_utils/api_response.dart';
import '../../ressources/repositories/preference_repository.dart';
import 'package:rxdart/rxdart.dart';

class SuscriptionBloc {
  late StompClient _client;

  void connect() {
    _client = StompClient(
      config: StompConfig(
          url: 'ws://studapps.cg.helmo.be:5005/REST_LAMY_GABER/ws',
          onConnect: onConnect,
          beforeConnect: () async {
            await Future.delayed(const Duration(milliseconds: 200));
          },
          onWebSocketError: (dynamic error) {},
          stompConnectHeaders: {
            'Authorization': userLoggedBloc.user.getToken()
          },
          webSocketConnectHeaders: {
            'Authorization': userLoggedBloc.user.getToken()
          },
          onStompError: (error) {}),
    );
    _client.activate();
  }

  void onConnect(StompFrame frame) async {
    _client.subscribe(
      destination: '/transfer/notification',
      callback: (frame) {
        _notificationFetcher.add(frame.body!);
      },
    );
  }

  final _suscriptionRepository = PreferenceRepository();
  final _suscriptionFetcher =
      BehaviorSubject<ApiResponse<List<GetSubscriptionVm>>>();
  final _suscriptionMessageFetcher = BehaviorSubject<ApiResponse<String>>();

  final _notificationFetcher = BehaviorSubject<String>();

  Stream<String> get alerts => _notificationFetcher.stream;

  Stream<ApiResponse<List<GetSubscriptionVm>>> get suscriptions =>
      _suscriptionFetcher.stream;
  Stream<ApiResponse<String>> get message => _suscriptionMessageFetcher.stream;

  void fetchSuscriptions() async {
    _suscriptionFetcher.add(ApiResponse.loading("Loading suscriptions."));
    try {
      _suscriptionFetcher.add(ApiResponse.completed(
          await _suscriptionRepository.getSuscriptions()));
    } catch (e) {
      _suscriptionFetcher.add(ApiResponse.error(e.toString()));
    }
  }

  void addSuscriptions(double price, String cryptoId) async {
    _suscriptionMessageFetcher
        .add(ApiResponse.loading("Adding suscription..."));
    try {
      _suscriptionMessageFetcher.add(ApiResponse.completed(
          await _suscriptionRepository.addSuscription(price, cryptoId)));
    } catch (e) {
      _suscriptionMessageFetcher.add(ApiResponse.error(e.toString()));
    }
  }

  void modifySuscription(
      double newPercent, bool isActive, String cryptoId) async {
    _suscriptionMessageFetcher
        .add(ApiResponse.loading("Modifying suscription..."));
    try {
      _suscriptionMessageFetcher.add(ApiResponse.completed(
          await _suscriptionRepository.modifySuscription(
              newPercent, isActive, cryptoId)));
      fetchSuscriptions();
    } catch (e) {
      _suscriptionMessageFetcher.add(ApiResponse.error(e.toString()));
    }
  }

  void deleteSuscription(String cryptoId) async {
    try {
      _suscriptionMessageFetcher.add(ApiResponse.completed(
          await _suscriptionRepository.deleteSuscription(cryptoId)));
      fetchSuscriptions();
    } catch (e) {
      _suscriptionMessageFetcher.add(ApiResponse.error(e.toString()));
    }
  }
}

final suscriptionBloc = SuscriptionBloc();
