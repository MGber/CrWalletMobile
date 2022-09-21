import 'package:crypto_wallet_mobile/models/message_model.dart';

import '../../ressources/providers/messages_provider.dart';

class MessageRepository {
  final _messagesProvider = MessageProvider();
  Future<List<MessageModel>> fetch100Messages(String cryptoId) async {
    final response = await _messagesProvider.fetchMessagesFor(cryptoId);
    return response.map((data) => MessageModel.fromMap(data)).toList();
  }
}
