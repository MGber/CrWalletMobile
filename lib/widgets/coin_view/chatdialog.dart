import 'package:crypto_wallet_mobile/blocs/chat_bloc.dart';
import 'package:crypto_wallet_mobile/blocs/crypto_coin_bloc.dart';
import 'package:crypto_wallet_mobile/ressources/providers/network_utils/api_response.dart';
import 'package:crypto_wallet_mobile/widgets/coin_view/coin_chat.dart';
import 'package:crypto_wallet_mobile/widgets/coin_view/message_sender.dart';
import 'package:flutter/material.dart';

class ChatDialog extends StatefulWidget {
  const ChatDialog({Key? key}) : super(key: key);

  @override
  _ChatDialogState createState() => _ChatDialogState();
}

class _ChatDialogState extends State<ChatDialog> {
  @override
  void dispose() {
    super.dispose();
    chatBloc.disconnect();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        AlertDialog(
          title: StreamBuilder(
            stream: coinsBloc.currentCoin,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                switch (snapshot.data.status) {
                  case Status.loading:
                    return Text(snapshot.data.message);
                  case Status.completed:
                    return Text(snapshot.data.data.symbol + " chat.");
                  case Status.error:
                    return Text(snapshot.data.message);
                }
              }
              return const Text("Error");
            },
          ),
          backgroundColor: Colors.grey,
          insetPadding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
          content: SizedBox(
            height: MediaQuery.of(context).size.height / 2,
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: const [CoinMessenger(), MessageSenderForm()],
            ),
          ),
        )
      ],
    );
  }
}
