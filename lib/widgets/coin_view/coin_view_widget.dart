// Bug with source file name on my computer
// ignore_for_file: file_names

import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:crypto_wallet_mobile/widgets/alert_callback_widget.dart';
import 'package:crypto_wallet_mobile/widgets/utils/snackbar.dart';
import '../../../blocs/suscription_bloc.dart';
import '../../../models/crypto_data.dart';
import '../../../widgets/coin_view/chatdialog.dart';
import '../../widgets/utils/dialog_utils.dart';
import '../../ressources/providers/network_utils/api_response.dart';
import '../../../blocs/crypto_coin_bloc.dart';
import '../../../blocs/navigation_service.dart';
import '../../../blocs/order_bloc.dart';
import 'order_maker_widget.dart';
import '../utils/color_utils.dart';
import 'package:flutter/material.dart';

class CoinViewWidget extends StatefulWidget {
  const CoinViewWidget({Key? key}) : super(key: key);

  @override
  _CoinViewWidgetState createState() => _CoinViewWidgetState();
}

class _CoinViewWidgetState extends State<CoinViewWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CoinViewAppBar(),
      body: const CoinView(),
    );
  }
}

class CoinView extends StatefulWidget {
  const CoinView({Key? key}) : super(key: key);

  @override
  _CoinViewState createState() => _CoinViewState();
}

class _CoinViewState extends State<CoinView> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: const <Widget>[
        Price(),
        TimePeriodButtonBar(),
        Coininfo(),
        BuyAndSellButtons(),
        InfoMessage(),
        AlertCallbackWidget(),
      ],
    );
  }
}

class InfoMessage extends StatelessWidget {
  const InfoMessage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: suscriptionBloc.message,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          switch (snapshot.data.status) {
            case Status.loading:
              WidgetsBinding.instance!.addPostFrameCallback((_) =>
                  SnackBarUtil.showSnackBar(
                      context, snapshot.data.message, Colors.orange));
              break;
            case Status.completed:
              WidgetsBinding.instance!.addPostFrameCallback((_) =>
                  SnackBarUtil.showSnackBar(
                      context, snapshot.data.data, Colors.green));
              break;
            case Status.error:
              WidgetsBinding.instance!.addPostFrameCallback((_) =>
                  SnackBarUtil.showSnackBar(
                      context, snapshot.data.message, Colors.red));
              break;
          }
        }
        return Container();
      },
    );
  }
}

class TimePeriodButtonBar extends StatefulWidget {
  const TimePeriodButtonBar({Key? key}) : super(key: key);

  @override
  _TimePeriodButtonBarState createState() => _TimePeriodButtonBarState();
}

class _TimePeriodButtonBarState extends State<TimePeriodButtonBar> {
  @override
  Widget build(BuildContext context) {
    const double fontSize = 18;
    return StreamBuilder(
      stream: coinsBloc.currentCoin,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          switch (snapshot.data.status) {
            case Status.loading:
              break;
            case Status.completed:
              return Container(
                  color: Colors.grey[700],
                  child: Row(
                    children: [
                      ButtonBar(
                        buttonPadding: const EdgeInsets.all(0),
                        children: [
                          TextButton(
                              onPressed: () => {
                                    coinsBloc.changeSelectedPercentage(
                                        snapshot.data.data.percentChange1h),
                                  },
                              child: const Text("1h",
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: fontSize))),
                          TextButton(
                              onPressed: () =>
                                  coinsBloc.changeSelectedPercentage(
                                      snapshot.data.data.percentChange24h),
                              child: const Text("24h",
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: fontSize))),
                          TextButton(
                              onPressed: () =>
                                  coinsBloc.changeSelectedPercentage(
                                      snapshot.data.data.percentChange7d),
                              child: const Text("7d",
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: fontSize))),
                          TextButton(
                              onPressed: () =>
                                  coinsBloc.changeSelectedPercentage(
                                      snapshot.data.data.percentChange30d),
                              child: const Text("30d",
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: fontSize))),
                          TextButton(
                              onPressed: () =>
                                  coinsBloc.changeSelectedPercentage(
                                      snapshot.data.data.percentChange60d),
                              child: const Text("60d",
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: fontSize))),
                          TextButton(
                              onPressed: () =>
                                  coinsBloc.changeSelectedPercentage(
                                      snapshot.data.data.percentChange90d),
                              child: const Text("90d",
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: fontSize))),
                        ],
                      )
                    ],
                  ));
            case Status.error:
              return Text(snapshot.data.message);
          }
        }
        return Container();
      },
    );
  }
}

class Price extends StatefulWidget {
  const Price({Key? key}) : super(key: key);

  @override
  _PriceState createState() => _PriceState();
}

class _PriceState extends State<Price> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: coinsBloc.currentCoin,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          switch (snapshot.data.status) {
            case Status.loading:
              break;
            case Status.completed:
              coinsBloc
                  .changeSelectedPercentage(snapshot.data.data.percentChange1h);
              return Container(
                  margin: const EdgeInsets.fromLTRB(22, 10, 10, 10),
                  child: Row(
                    children: [
                      Text(
                        snapshot.data.data.priceUsd,
                        style: const TextStyle(fontSize: 20),
                      ),
                      const Text(
                        " \$",
                        style: TextStyle(fontSize: 20, color: Colors.grey),
                      ),
                      const Spacer(),
                      const PercentChange(),
                    ],
                  ));
            case Status.error:
              return Text(snapshot.data.message);
          }
        }
        return Container();
      },
    );
  }
}

class CoinViewAppBar extends AppBar {
  CoinViewAppBar({Key? key}) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(60.0);

  @override
  _CoinViewAppBarState createState() => _CoinViewAppBarState();
}

class _CoinViewAppBarState extends State<CoinViewAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      leading: IconButton(
          onPressed: () {
            navigatorService.mainKey.currentState!.pop();
          },
          icon: const Icon(Icons.arrow_back_ios_new_rounded)),
      title: const ImageAndTitle(),
      actions: [
        IconButton(
            onPressed: () =>
                {DialogUtils.showCustomDialog(context, const ChatDialog())},
            icon: const Icon(Icons.message_outlined)),
        IconButton(
            onPressed: () async {
              final coin = await coinsBloc.currentCoin.first;
              suscriptionBloc.addSuscriptions(
                  double.parse(coin.data!.priceUsd), coin.data!.symbol);
            },
            icon: const Icon(Icons.notification_add_outlined))
      ],
      elevation: 0,
    );
  }
}

class ImageAndTitle extends StatelessWidget {
  const ImageAndTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: coinsBloc.currentCoin,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          switch (snapshot.data.status) {
            case Status.loading:
              break;
            case Status.completed:
              return Container(
                  margin: const EdgeInsets.fromLTRB(22, 10, 10, 10),
                  child: Row(
                    children: [
                      Container(
                        margin: const EdgeInsets.fromLTRB(0, 0, 15, 0),
                        child: CircleAvatar(
                          maxRadius: 15,
                          foregroundImage: CachedNetworkImageProvider(
                              snapshot.data.data.imageUrl),
                          backgroundColor: Colors.grey,
                        ),
                      ),
                      Text(
                        snapshot.data.data.name,
                        style: const TextStyle(
                          fontSize: 20,
                        ),
                      )
                    ],
                  ));
            case Status.error:
              return Text(snapshot.data.message);
          }
        }
        return Container();
      },
    );
  }
}

class Coininfo extends StatefulWidget {
  const Coininfo({Key? key}) : super(key: key);

  @override
  _CoininfoState createState() => _CoininfoState();
}

class _CoininfoState extends State<Coininfo> {
  @override
  Widget build(BuildContext context) {
    const headerStyle = TextStyle(
      fontSize: 20,
      color: Colors.grey,
    );
    const textStyle = TextStyle(fontSize: 20);
    const rowSpacer = SizedBox(
      height: 8,
    );
    return StreamBuilder(
      stream: coinsBloc.currentCoin,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          switch (snapshot.data.status) {
            case Status.loading:
              break;
            case Status.completed:
              return Container(
                  margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                  child: Table(
                    children: [
                      const TableRow(children: [
                        Center(
                            child: Text(
                          'Market cap',
                          style: headerStyle,
                        )),
                        Center(child: Text('Volume/24h', style: headerStyle))
                      ]),
                      const TableRow(children: [
                        rowSpacer,
                        rowSpacer,
                      ]),
                      TableRow(children: [
                        Center(
                          child: Text(
                            CryptoCoin.kmbGenerator(
                                snapshot.data.data.marketCap),
                            style: textStyle,
                          ),
                        ),
                        Center(
                            child: RichText(
                                text: TextSpan(children: <TextSpan>[
                          TextSpan(
                              text: CryptoCoin.kmbGenerator(
                                      snapshot.data.data.volume24h) +
                                  " ",
                              style: textStyle),
                          TextSpan(
                              text: snapshot.data.data.volumeChange24h + "%",
                              style: TextStyle(
                                  fontSize: 20,
                                  color: ColorUtils.getPercentageColor(
                                      snapshot.data.data.volumeChange24h))),
                        ]))),
                      ])
                    ],
                  ));
            case Status.error:
              return Text(snapshot.data.message);
          }
        }
        return Container();
      },
    );
  }
}

class PercentChange extends StatelessWidget {
  const PercentChange({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: coinsBloc.percentageChange,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Text(
            snapshot.data.toString() + "%",
            style: TextStyle(
                fontSize: 20,
                color: ColorUtils.getPercentageColor(snapshot.data.toString())),
          );
        }
        return const Text("Error loading percentage");
      },
    );
  }
}

class CoinText extends StatelessWidget {
  const CoinText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: coinsBloc.currentCoin,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          switch (snapshot.data.status) {
            case Status.loading:
              break;
            case Status.completed:
              return Column(
                children: [
                  Row(
                    children: [Text("About " + snapshot.data.data.name)],
                  ),
                  Row(
                    children: const [Text("not implemented yet...")],
                  ),
                ],
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

class BuyAndSellButtons extends StatefulWidget {
  const BuyAndSellButtons({Key? key}) : super(key: key);

  @override
  _BuyAndSellButtonsState createState() => _BuyAndSellButtonsState();
}

class _BuyAndSellButtonsState extends State<BuyAndSellButtons> {
  @override
  Widget build(BuildContext context) {
    /*Timer.periodic(const Duration(seconds: 15),
        (Timer t) => coinsBloc.refreshCurrentCoin());*/
    return StreamBuilder(
      stream: coinsBloc.currentCoin,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          switch (snapshot.data.status) {
            case Status.loading:
              break;
            case Status.completed:
              return Container(
                  margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                  child: Row(
                    children: [
                      const Spacer(),
                      SizedBox(
                        height: 50,
                        width: MediaQuery.of(context).size.width / 4.5,
                        child: TextButton(
                          onPressed: () => {
                            orderbloc.setBeforeOrder(
                                orderMode.achat, snapshot.data.data.symbol),
                            DialogUtils.showCustomDialog(
                                context, const OrderMakerDialog())
                          },
                          child: const Text("Buy"),
                          style: TextButton.styleFrom(
                              backgroundColor: Colors.green[600],
                              primary: Colors.white,
                              textStyle: const TextStyle(fontSize: 30)),
                        ),
                      ),
                      const Spacer(),
                      SizedBox(
                        height: 50,
                        width: MediaQuery.of(context).size.width / 4.5,
                        child: TextButton(
                          onPressed: () => {
                            orderbloc.setBeforeOrder(
                                orderMode.vente, snapshot.data.data.symbol),
                            DialogUtils.showCustomDialog(
                                context, const OrderMakerDialog())
                          },
                          child: const Text("Sell"),
                          style: TextButton.styleFrom(
                              backgroundColor: Colors.red[600],
                              primary: Colors.white,
                              textStyle: const TextStyle(fontSize: 30)),
                        ),
                      ),
                      const Spacer(),
                    ],
                  ));
            case Status.error:
              return Text(snapshot.data.message);
          }
        }
        return Container();
      },
    );
  }
}
