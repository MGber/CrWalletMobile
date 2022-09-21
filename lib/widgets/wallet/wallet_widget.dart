import 'package:crypto_wallet_mobile/blocs/user_balance_bloc.dart';

import '../../ressources/providers/network_utils/api_response.dart';

import '../../blocs/order_bloc.dart';
import 'package:flutter/material.dart';

import '../alert_callback_widget.dart';
import 'order_history_widget.dart';

class WalletWidget extends StatelessWidget {
  const WalletWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Column(
          children: [
            const AlertCallbackWidget(),
            const TabBar(
              tabs: [
                Tab(
                  text: "My wallet",
                ),
                Tab(text: "Order history"),
              ],
              indicatorColor: Colors.grey,
            ),
            SizedBox(
                height: MediaQuery.of(context).size.height - 134,
                child: const TabBarView(
                    children: [MyCoinsWidget(), CoinHistoryWidget()]))
          ],
        ));
  }
}

class MyCoinsWidget extends StatefulWidget {
  const MyCoinsWidget({Key? key}) : super(key: key);

  @override
  _MyCoinsWidgetState createState() => _MyCoinsWidgetState();
}

class _MyCoinsWidgetState extends State<MyCoinsWidget> {
  final textStyle = const TextStyle(color: Colors.grey, fontSize: 18);
  @override
  Widget build(BuildContext context) {
    userBalanceBloc.fetchWallet();
    return StreamBuilder(
        stream: userBalanceBloc.wallet,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            switch (snapshot.data.status) {
              case Status.loading:
                return Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                      child: Text(
                        snapshot.data.message,
                        style:
                            const TextStyle(color: Colors.grey, fontSize: 18),
                      ),
                    ),
                    const Spacer(),
                    const CircularProgressIndicator(),
                    const Spacer(),
                  ],
                );
              case Status.completed:
                return Container(
                  padding: const EdgeInsets.fromLTRB(10, 10, 20, 10),
                  child: ListView.separated(
                      itemBuilder: (context, index) {
                        return Row(
                          children: [
                            Text(
                              snapshot.data.data[index].idCrypto,
                              style: textStyle,
                            ),
                            const Spacer(),
                            Text(snapshot.data.data[index].total.toString(),
                                style: textStyle)
                          ],
                        );
                      },
                      separatorBuilder: (context, index) {
                        return const Divider();
                      },
                      itemCount: snapshot.data.data.length),
                );
              case Status.error:
                return Text(snapshot.data.message);
            }
          }
          return Container();
        });
  }
}

class CoinHistoryWidget extends StatefulWidget {
  const CoinHistoryWidget({Key? key}) : super(key: key);

  @override
  _CoinHistoryWidgetState createState() => _CoinHistoryWidgetState();
}

class _CoinHistoryWidgetState extends State<CoinHistoryWidget> {
  @override
  Widget build(BuildContext context) {
    orderbloc.fetchHistory();
    return StreamBuilder(
      stream: orderbloc.orderHistory,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          switch (snapshot.data.status) {
            case Status.loading:
              return const Center(
                  child: Center(child: CircularProgressIndicator()));
            case Status.completed:
              return ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: snapshot.data.data.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return HistoryItem(snapshot.data.data[index]);
                },
              );
            case Status.error:
              return Text(snapshot.data.message);
          }
        }
        return Container();
      },
    );
  }
}
