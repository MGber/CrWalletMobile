import 'package:crypto_wallet_mobile/blocs/chat_bloc.dart';
import 'package:flutter/material.dart';

class MessageSenderForm extends StatefulWidget {
  const MessageSenderForm({Key? key}) : super(key: key);

  @override
  _MessageSenderFormState createState() => _MessageSenderFormState();
}

class _MessageSenderFormState extends State<MessageSenderForm> {
  final _messageController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 100,
        width: MediaQuery.of(context).size.width,
        child: Form(
            child: Row(
          children: [
            Container(
              margin: const EdgeInsets.fromLTRB(5, 0, 5, 5),
              height: 40,
              width: MediaQuery.of(context).size.width * 0.8,
              child: TextFormField(
                controller: _messageController,
                decoration: const InputDecoration(
                    focusColor: Colors.blueAccent,
                    border: OutlineInputBorder()),
              ),
            ),
            Expanded(
                child: IconButton(
              highlightColor: Colors.blue,
              icon: const Icon(Icons.message),
              onPressed: () {
                chatBloc.sendMessage(_messageController.text);
                _messageController.text = "";
              },
            ))
          ],
        )));
  }
}
