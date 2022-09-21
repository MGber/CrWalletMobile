import 'package:crypto_wallet_mobile/models/crypto_data.dart';

import '../../../blocs/crypto_coin_bloc.dart';
import '../../../blocs/order_bloc.dart';
import '../../../blocs/user_balance_bloc.dart';
import '../../../ressources/providers/network_utils/api_response.dart';
import 'package:flutter/material.dart';

class OrderMakerDialog extends StatefulWidget {
  const OrderMakerDialog({Key? key}) : super(key: key);

  @override
  _OrderMakerDialogState createState() => _OrderMakerDialogState();
}

class _OrderMakerDialogState extends State<OrderMakerDialog> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String message = "";
  final amountController = TextEditingController();
  double value = 0;
  TextStyle textStyle = const TextStyle(
    fontSize: 18,
  );

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        AlertDialog(
          title: geTitle(),
          backgroundColor: Colors.grey,
          insetPadding: const EdgeInsets.fromLTRB(0, 50, 0, 0),
          content: Builder(
            builder: (context) {
              var height = MediaQuery.of(context).size.height * 0.40;
              var width = MediaQuery.of(context).size.width;
              return SizedBox(
                height: height,
                width: width,
                child: makeOrderForm(),
              );
            },
          ),
        )
      ],
    );
  }

  Widget makeOrderForm() {
    userBalanceBloc.fetchBalance();
    coinsBloc.currentCoin.first.then(
        (value) => userBalanceBloc.fetchCryptoBalance(value.data!.symbol));
    return Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            userBalance(textStyle),
            const Spacer(),
            cryptoQuantity(textStyle),
            const Spacer(),
            Row(
              children: [
                Container(
                  margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width / 3.5,
                    child: TextField(
                        controller: amountController,
                        keyboardType: TextInputType.number,
                        onChanged: (text) {
                          if (amountController.value.text.isNotEmpty) {
                            try {
                              var value =
                                  double.parse(amountController.value.text);
                              setCurrentPrice(value);
                            } catch (e) {
                              setCurrentPrice(0);
                            }
                            //Format exception

                          } else {
                            setCurrentPrice(0);
                          }
                        }),
                  ),
                ),
                Text(orderbloc.cryptoId)
              ],
            ),
            const Spacer(),
            //Streambuilder
            StreamBuilder(
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  return Text(
                    ("\$ " + snapshot.data.toString()),
                    style: const TextStyle(
                      fontSize: 20,
                    ),
                  );
                }

                return const Text("Enter amount...");
              },
              stream: orderbloc.orderPrice,
            ),
            const Spacer(),
            TextButton(
                onPressed: () => confirmOrder(),
                child: const Text("Confirm order"),
                style: TextButton.styleFrom(
                    backgroundColor: Colors.blue,
                    primary: Colors.white,
                    textStyle: const TextStyle(fontSize: 18))),
            const Spacer(),
            StreamBuilder(
              stream: orderbloc.orderResult,
              builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  switch (snapshot.data.status) {
                    case Status.loading:
                      return Row(
                        children: const [
                          CircularProgressIndicator(),
                        ],
                      );
                    case Status.completed:
                      return Text(snapshot.data.data);
                    case Status.error:
                      return Text(snapshot.data.message);
                  }
                }
                return Container();
              },
            )
          ],
        ));
  }

  StreamBuilder<ApiResponse<double>> userBalance(TextStyle textStyle) {
    return StreamBuilder(
      stream: userBalanceBloc.userBalance,
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          switch (snapshot.data.status) {
            case Status.loading:
              return Row(
                children: [
                  Text(
                    "Balance : ",
                    style: textStyle,
                  ),
                  const CircularProgressIndicator(),
                ],
              );
            case Status.completed:
              return Text(
                "Balance : ${snapshot.data.data}",
                style: textStyle,
              );
            case Status.error:
              return Text(
                "Balance : Error",
                style: textStyle,
              );
          }
        }
        return Container();
      },
    );
  }

  StreamBuilder<ApiResponse<double>> cryptoQuantity(TextStyle textStyle) {
    return StreamBuilder(
      stream: userBalanceBloc.userCryptoBalance,
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          switch (snapshot.data.status) {
            case Status.loading:
              return Row(
                children: [
                  Text(
                    "Possessed : ",
                    style: textStyle,
                  ),
                  const CircularProgressIndicator(),
                ],
              );
            case Status.completed:
              return Text(
                "Possessed : ${snapshot.data.data}",
                style: textStyle,
              );
            case Status.error:
              return Text(
                "Possessed : 0",
                style: textStyle,
              );
          }
        }
        return Container();
      },
    );
  }

  Text geTitle() {
    if (orderbloc.mode == "ACHAT") {
      return Text("Buy  ${orderbloc.cryptoId}");
    }
    return Text("Sell ${orderbloc.cryptoId}");
  }

  validateAmount() {
    return null;
  }

  confirmOrder() async {
    if (amountController.value.text.isNotEmpty) {
      try {
        var parse = double.parse(amountController.value.text);
        if (parse > 0) {
          orderbloc.makeOrder(parse);
        }
      } on FormatException {}
    }

    userBalanceBloc.fetchBalance();
    ApiResponse<CryptoCoin> currentCoin = await coinsBloc.currentCoin.first;
    userBalanceBloc.fetchCryptoBalance(currentCoin.data!.symbol);
  }

  setCurrentPrice(double quantity) async {
    ApiResponse<CryptoCoin> currentCoin = await coinsBloc.currentCoin.first;
    orderbloc.changeOrderPrice(
        (quantity * double.parse(currentCoin.data!.priceUsd)).toString());
  }
}
