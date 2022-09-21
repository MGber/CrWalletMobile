import 'dart:async';

import 'package:crypto_wallet_mobile/blocs/suscription_bloc.dart';

import '../../blocs/navigation_service.dart';
import '../../ressources/providers/network_utils/api_response.dart';
import '../widgets/utils/color_utils.dart';
import 'package:flutter/material.dart';
import '../../models/crypto_data.dart';
import '../../blocs/crypto_coin_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'alert_callback_widget.dart';

class CoinListWidget extends StatelessWidget {
  const CoinListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    coinsBloc.fetchAllCoins();
    /*Timer.periodic(
        const Duration(seconds: 30), (Timer t) => coinsBloc.fetchAllCoins());*/
    suscriptionBloc.connect();
    return StreamBuilder(
      stream: coinsBloc.cryptoData,
      initialData: null,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          switch (snapshot.data.status) {
            case Status.loading:
              return const Center(child: CircularProgressIndicator());
            case Status.completed:
              return Column(
                children: [
                  const CoinListTopBar(),
                  Expanded(
                      child: ListView.separated(
                    padding: EdgeInsets.zero,
                    itemCount: snapshot.data.data.length,
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    physics: const ClampingScrollPhysics(),
                    itemBuilder: (context, index) {
                      return coinDataContainer(snapshot.data.data[index]);
                    },
                    separatorBuilder: (BuildContext context, int index) =>
                        const Divider(
                      color: Colors.transparent,
                    ),
                  )),
                  const AlertCallbackWidget()
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

  InkWell coinDataContainer(CryptoCoin data) {
    return InkWell(
      onTap: () {
        coinsBloc.setCurrentCoin(data);
        navigatorService.mainKey.currentState!.pushNamed("/coin");
      },
      child: Container(
          padding: const EdgeInsets.all(2.0),
          margin: const EdgeInsets.fromLTRB(10.0, 0, 10.0, 0),
          height: 86.5,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: Colors.grey.shade700,
            ),
          ),
          child: Row(
            children: [
              const Padding(padding: EdgeInsets.fromLTRB(10, 0, 10, 0)),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    foregroundImage: CachedNetworkImageProvider(data.imageUrl),
                    backgroundColor: Colors.grey,
                  ),
                ],
              ),
              const Padding(padding: EdgeInsets.fromLTRB(10, 0, 10, 0)),
              CoinPreviewDataWidget(data: data),
              const Spacer(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(data.percentChange24h + "%",
                      style: TextStyle(
                        fontSize: 20,
                        color: ColorUtils.getPercentageColor(
                            data.percentChange24h),
                      ))
                ],
              )
            ],
          )),
    );
  }
}

/*
*/
class CoinListTopBar extends StatefulWidget {
  const CoinListTopBar({Key? key}) : super(key: key);

  @override
  _CoinListTopBarState createState() => _CoinListTopBarState();
}

class _CoinListTopBarState extends State<CoinListTopBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
              child: const Text(
                "Coin list",
                style: TextStyle(fontSize: 20, color: Colors.grey),
              ),
            ),
            Row(
              children: [
                Expanded(
                    child: TextField(
                  onChanged: (text) {
                    coinsBloc.filterData(text);
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    hintText: 'Search a coin',
                  ),
                ))
              ],
            )
          ],
        ));
  }
}

class CoinPreviewDataWidget extends StatelessWidget {
  const CoinPreviewDataWidget({
    Key? key,
    required this.data,
  }) : super(key: key);

  final CryptoCoin data;

  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            data.name,
            style: const TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, color: Colors.grey),
          ),
          const Spacer(),
          Text(
            data.priceUsd + "\$",
            style: const TextStyle(fontSize: 20, color: Colors.orange),
          ),
          const Spacer(),
          Text(
            data.symbol,
            style: const TextStyle(fontSize: 20, color: Colors.grey),
          ),
        ]);
  }
}


//TODO Use this in coin view to change data frame time.
/* 
class TimePeriodButtonBar extends StatelessWidget {
  const TimePeriodButtonBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.blue,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            const Spacer(),
            TextButton(
                onPressed: () => {},
                child: const Text("1h",
                    style: TextStyle(color: Colors.grey, fontSize: 18))),
            TextButton(
                onPressed: () => {},
                child: const Text("24h",
                    style: TextStyle(color: Colors.grey, fontSize: 18))),
            TextButton(
                onPressed: () => {},
                child: const Text("7d",
                    style: TextStyle(color: Colors.grey, fontSize: 18))),
            TextButton(
                onPressed: () => {},
                child: const Text("30d",
                    style: TextStyle(color: Colors.grey, fontSize: 18))),
            TextButton(
                onPressed: () => {},
                child: const Text("60d",
                    style: TextStyle(color: Colors.grey, fontSize: 18))),
            TextButton(
                onPressed: () => {},
                child: const Text("90d",
                    style: TextStyle(color: Colors.grey, fontSize: 18))),
            const Spacer()
          ],
        ));
  }
}*/
