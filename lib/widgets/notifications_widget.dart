import 'package:cached_network_image/cached_network_image.dart';
import 'package:crypto_wallet_mobile/blocs/notification_bloc.dart';
import 'package:crypto_wallet_mobile/blocs/suscription_bloc.dart';
import 'package:crypto_wallet_mobile/models/notification.dart';
import 'package:crypto_wallet_mobile/models/subscription/get_subscription_vm.dart';
import 'package:crypto_wallet_mobile/ressources/providers/network_utils/api_response.dart';
import 'package:flutter/material.dart';

import 'alert_callback_widget.dart';

class NotificationWidget extends StatelessWidget {
  const NotificationWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    notificationBloc.fetchAllNotifications();
    suscriptionBloc.fetchSuscriptions();
    return SingleChildScrollView(
      physics: const ClampingScrollPhysics(),
      child: Column(
        children: [
          const AlertCallbackWidget(),
          Container(
              margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
              child: const Text(
                "Notifications settings",
                style: TextStyle(color: Colors.grey, fontSize: 20),
              )),
          StreamBuilder(
            stream: suscriptionBloc.suscriptions,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                switch (snapshot.data.status) {
                  case Status.loading:
                    return Text(snapshot.data.message);
                  case Status.completed:
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const ClampingScrollPhysics(),
                      itemCount: snapshot.data.data.length,
                      itemBuilder: (context, index) {
                        return NotificationSetting(snapshot.data.data, index);
                      },
                    );
                  case Status.error:
                    return Text(snapshot.data.message);
                }
              }
              return Container();
            },
          ),
          Container(
              margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
              child: const Text(
                "Notifications",
                style: TextStyle(color: Colors.grey, fontSize: 20),
              )),
          StreamBuilder(
            stream: notificationBloc.notifications,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                switch (snapshot.data.status) {
                  case Status.loading:
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  case Status.completed:
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const ClampingScrollPhysics(),
                      itemCount: snapshot.data.data.length,
                      itemBuilder: (context, index) {
                        return Notification(snapshot.data.data[index]);
                      },
                    );
                  case Status.error:
                    return Text(snapshot.data.message);
                }
              }
              return Container();
            },
          )
        ],
      ),
    );
  }
}

class Notification extends StatelessWidget {
  final NotificationModel data;
  const Notification(this.data, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Container(
          padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
          margin: const EdgeInsets.fromLTRB(10, 0, 25, 0),
          child: CircleAvatar(
            foregroundImage: CachedNetworkImageProvider(data.image!),
            backgroundColor: Colors.grey,
          ),
        ),
        Text(
          data.message!,
          style: const TextStyle(color: Colors.green),
        ),
        const Spacer(),
        Text(data.dateNotif!, style: const TextStyle(color: Colors.grey)),
        const Spacer(),
      ],
    );
  }
}

class NotificationSetting extends StatefulWidget {
  final int index;
  final List<GetSubscriptionVm> data;
  const NotificationSetting(this.data, this.index, {Key? key})
      : super(key: key);

  @override
  _NotificationSettingState createState() => _NotificationSettingState();
}

class _NotificationSettingState extends State<NotificationSetting> {
  var sliderValue = -1.0;
  @override
  Widget build(BuildContext context) {
    if (sliderValue == -1) {
      sliderValue = widget.data[widget.index].percent!;
    }

    var switchValue = widget.data[widget.index].isActive!;

    return Row(children: [
      const Spacer(),
      SizedBox(
        width: 60,
        child: Text(
          widget.data[widget.index].cryptoId!,
          style: const TextStyle(fontSize: 18, color: Colors.grey),
        ),
      ),
      Slider(
        activeColor: Colors.blue,
        divisions: 15,
        min: 1,
        max: 15,
        value: sliderValue,
        onChanged: (value) {
          setState(() {
            sliderValue = value;
          });
        },
        onChangeEnd: (value) {
          suscriptionBloc.modifySuscription(
              value,
              widget.data[widget.index].isActive!,
              widget.data[widget.index].cryptoId!);
        },
      ),
      const Spacer(),
      Switch(
        value: widget.data[widget.index].isActive!,
        onChanged: (value) {
          if (switchValue == false) {
            switchValue = true;
            suscriptionBloc.modifySuscription(
                widget.data[widget.index].percent!,
                value,
                widget.data[widget.index].cryptoId!);
          } else {
            switchValue = true;
            suscriptionBloc.modifySuscription(
                widget.data[widget.index].percent!,
                value,
                widget.data[widget.index].cryptoId!);
          }
        },
      ),
      IconButton(
          onPressed: () async => {
                suscriptionBloc
                    .deleteSuscription(widget.data[widget.index].cryptoId!),
                widget.data.removeAt(widget.index),
              },
          icon: const Icon(
            Icons.close,
            color: Colors.red,
          ))
    ]);
  }
}
