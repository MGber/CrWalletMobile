import '../../models/order/order.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HistoryItem extends StatefulWidget {
  final Order data;
  const HistoryItem(this.data, {Key? key}) : super(key: key);

  @override
  _HistoryItemState createState() => _HistoryItemState();
}

class _HistoryItemState extends State<HistoryItem> {
  static const textStyle = TextStyle(
    fontSize: 18,
  );

  @override
  Widget build(BuildContext context) {
    var data = widget.data;
    var date = DateTime.parse(data.dateTransaction);
    final f = DateFormat('dd-MM-yyyy hh:mm');
    return ExpansionTile(
      title: getOrderPrefix(data),
      backgroundColor: getColor(widget.data.mode),
      collapsedBackgroundColor: getColor(widget.data.mode),
      textColor: Colors.white,
      children: [
        Column(
          children: [
            Row(
              children: [
                Text(
                  f.format(date),
                  style: textStyle,
                )
              ],
            ),
            Row(
              children: [
                Text(
                  "${data.removeDecimalZeroFormat(data.quantity)} ${data.cryptoMoney!.slug}",
                  style: textStyle,
                )
              ],
            ),
            Row(
              children: [
                Text(
                  "${data.removeDecimalZeroFormat(data.unitPrice)} \$ / ${data.cryptoMoney!.slug}",
                  style: textStyle,
                )
              ],
            )
          ],
        )
      ],
    );
  }

  Widget getOrderPrefix(Order data) {
    if (data.mode == "ACHAT") {
      return Row(
        children: [
          Text(
            "- ${(data.removeDecimalZeroFormat(data.quantity * data.unitPrice))} USD",
            style: textStyle,
          ),
          const Icon(Icons.arrow_forward),
          Text(
            " + ${data.removeDecimalZeroFormat(data.quantity)} ${data.cryptoMoney!.slug}",
            style: textStyle,
          ),
        ],
      );
    }
    return Row(
      children: [
        Text(
            "- ${data.removeDecimalZeroFormat(data.quantity)} ${data.cryptoMoney!.slug}"),
        const Icon(Icons.arrow_forward),
        Text(
            " + ${data.removeDecimalZeroFormat(data.quantity * data.unitPrice)} USD"),
      ],
    );
  }

  Color? getColor(String mode) {
    if (mode == "VENTE") {
      return Colors.green[300];
    }
    return Colors.red[300];
  }
}
