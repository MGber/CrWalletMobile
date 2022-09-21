import 'dart:convert';

import 'package:crypto_wallet_mobile/blocs/crypto_coin_bloc.dart';
import 'package:crypto_wallet_mobile/blocs/user_bloc.dart';
import 'package:crypto_wallet_mobile/models/message_model.dart';
import 'package:crypto_wallet_mobile/ressources/providers/network_utils/api_response.dart';
import 'package:crypto_wallet_mobile/ressources/repositories/message_repository.dart';
import 'package:stomp_dart_client/stomp.dart';
import 'package:stomp_dart_client/stomp_config.dart';
import 'package:stomp_dart_client/stomp_frame.dart';
import 'package:rxdart/rxdart.dart';

class ChatBloc {
  late StompClient _client;
  final _messagesFetcher = BehaviorSubject<ApiResponse<List<MessageModel>>>();
  final _messageRepository = MessageRepository();
  List<MessageModel> lastMessages = [];

  Stream<ApiResponse<List<MessageModel>>> get messages =>
      _messagesFetcher.stream;

  void fetchMessages() async {
    final crypto = await coinsBloc.currentCoin.first;
    String cryptoId = crypto.data!.symbol;
    _messagesFetcher.add(ApiResponse.loading("Loading messages for $cryptoId"));
    try {
      lastMessages = await _messageRepository.fetch100Messages(cryptoId);
      _messagesFetcher.add(ApiResponse.completed(lastMessages));
    } catch (e) {
      _messagesFetcher.add(ApiResponse.error(e.toString()));
    }
  }

  // Stream get messages => _client.;

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
    final crypto = await coinsBloc.currentCoin.first;
    String cryptoId = crypto.data!.symbol;
    _client.subscribe(
      destination: '/transfer/$cryptoId',
      callback: (frame) {
        final result = MessageModel.fromJson(frame.body!);
        lastMessages.add(result);
        if (lastMessages.length > 100) {
          while (lastMessages.length > 100) {
            lastMessages.removeAt(0);
          }
        }
        _messagesFetcher.add(ApiResponse.completed(lastMessages));
      },
    );
  }

  void sendMessage(String message) async {
    final crypto = await coinsBloc.currentCoin.first;
    String cryptoId = crypto.data!.symbol;
    _client.send(
        destination: '/app/send/$cryptoId',
        body: jsonEncode({"message": message}),
        headers: {});
  }

  void disconnect() {
    _client.deactivate();
  }
}

final chatBloc = ChatBloc();
