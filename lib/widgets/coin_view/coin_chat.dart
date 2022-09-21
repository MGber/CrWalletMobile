import 'dart:async';

import 'package:crypto_wallet_mobile/blocs/user_bloc.dart';
import 'package:crypto_wallet_mobile/ressources/providers/network_utils/api_response.dart';

import '../../blocs/chat_bloc.dart';
import 'package:flutter/material.dart';

class CoinMessenger extends StatefulWidget {
  const CoinMessenger({Key? key}) : super(key: key);

  @override
  _CoinMessengerState createState() => _CoinMessengerState();
}

class _CoinMessengerState extends State<CoinMessenger> {
  @override
  Widget build(BuildContext context) {
    chatBloc.fetchMessages();
    chatBloc.connect();
    final _scrollController = ScrollController();

    return Expanded(
      child: StreamBuilder(
        stream: chatBloc.messages,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            switch (snapshot.data.status) {
              case Status.loading:
                return Column(
                  children: [
                    Text(snapshot.data.message),
                    const Center(child: CircularProgressIndicator())
                  ],
                );
              case Status.completed:
                Timer(
                    const Duration(seconds: 1),
                    () => _scrollController.animateTo(
                        _scrollController.position.maxScrollExtent,
                        duration: const Duration(seconds: 1),
                        curve: Curves.fastOutSlowIn));
                return ListView.separated(
                  separatorBuilder: (context, index) {
                    return const Divider(
                      height: 7,
                      color: Colors.transparent,
                    );
                  },
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  controller: _scrollController,
                  itemCount: (null == snapshot.data.data)
                      ? 0
                      : snapshot.data.data.length,
                  itemBuilder: (context, index) {
                    if (snapshot.data.data[index].sendName ==
                        userLoggedBloc.user.getLogin()) {
                      return Row(
                        children: [
                          const Spacer(),
                          Container(
                              margin: const EdgeInsets.all(10),
                              padding: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                  color: Colors.blue[200],
                                  borderRadius: const BorderRadius.only(
                                      bottomLeft: Radius.circular(5),
                                      bottomRight: Radius.circular(5),
                                      topLeft: Radius.circular(5),
                                      topRight: Radius.circular(0))),
                              child: Text(snapshot.data.data[index].sendName +
                                  " : \r\n" +
                                  snapshot.data.data[index].message))
                        ],
                      );
                    } else {
                      return Row(
                        children: [
                          Container(
                              margin: const EdgeInsets.all(10),
                              padding: const EdgeInsets.all(5),
                              decoration: const BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(5),
                                      bottomRight: Radius.circular(5),
                                      topLeft: Radius.circular(0),
                                      topRight: Radius.circular(5))),
                              child: Text(
                                snapshot.data.data[index].sendName +
                                    " : \r\n" +
                                    snapshot.data.data[index].message,
                                style: const TextStyle(color: Colors.black),
                              ))
                        ],
                      );
                    }
                  },
                );
              case Status.error:
                return Text(snapshot.data.message);
            }
          }
          return Container();
        },
      ),
    );
  }
}

/*Form(
                child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(),
                    ),
                    Expanded(
                      child: TextButton(
                          onPressed: () {}, child: const Text("Send")),
                    )
                  ],
                )
              ],
            ))*/
