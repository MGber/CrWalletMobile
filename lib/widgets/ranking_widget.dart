import 'package:crypto_wallet_mobile/ressources/providers/network_utils/api_response.dart';

import '../../blocs/ranking_bloc.dart';
import '../../models/player_model.dart';
import 'package:flutter/material.dart';

import 'alert_callback_widget.dart';

class RankingWidget extends StatelessWidget {
  const RankingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    rankingBloc.generateRanking();
    return Center(
      child: StreamBuilder(
        stream: rankingBloc.ranking,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            switch (snapshot.data.status) {
              case Status.loading:
                return const CircularProgressIndicator();
              case Status.completed:
                return Column(
                  children: [
                    const AlertCallbackWidget(),
                    rankingTopBar(context),
                    Expanded(
                        child: ListView.separated(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      physics: const ClampingScrollPhysics(),
                      itemBuilder: (context, index) =>
                          playerRankContainer(snapshot.data.data[index], index),
                      itemCount: snapshot.data.data.length,
                      separatorBuilder: (BuildContext context, int index) {
                        return const Divider(
                          color: Colors.transparent,
                        );
                      },
                    ))
                  ],
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

  playerRankContainer(Player data, int index) {
    return Container(
        margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          border: Border.all(
            color: (Colors.grey[700])!,
            width: 1,
          ),
        ),
        child: ListTile(
          leading: Text(("${index + 1}.")),
          title: Text(data.login),
          trailing: Text(data.totalValue + "\$"),
        ));
  }

  Widget rankingTopBar(BuildContext context) {
    return Container(
        margin: const EdgeInsets.all(1),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                child: const Text(
                  "Ranking",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 20,
                  ),
                ),
              )
            ]));
  }
}
