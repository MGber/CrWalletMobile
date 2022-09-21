import 'package:crypto_wallet_mobile/blocs/suscription_bloc.dart';
import 'package:crypto_wallet_mobile/widgets/utils/snackbar.dart';
import 'package:crypto_wallet_mobile/widgets/utils/widget_callback.dart';
import 'package:flutter/material.dart';

class AlertCallbackWidget extends StatelessWidget {
  const AlertCallbackWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: suscriptionBloc.alerts,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          WidgetCallback.callBackMethod(() => {
                SnackBarUtil.showSnackBar(
                    context, "Alert ! New notification...", Colors.grey)
              });
        }
        return Container();
      },
    );
  }
}
