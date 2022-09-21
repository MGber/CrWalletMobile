import 'package:flutter/material.dart';

class NavBar extends StatelessWidget {
  const NavBar(GlobalKey<NavigatorState> navigatorKey, {Key? key})
      : super(key: key);
  static const iconColor = Colors.grey;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Colors.white,
      showSelectedLabels: false,
      selectedItemColor: Colors.blue,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(label: "Home", icon: Icon(Icons.home_outlined)),
        BottomNavigationBarItem(
            icon: Icon(Icons.account_balance_wallet_outlined, color: iconColor),
            label: "Wallet"),
        BottomNavigationBarItem(
            icon: Icon(Icons.list_outlined, color: iconColor),
            label: "Coin list"),
        BottomNavigationBarItem(
            icon: Icon(Icons.settings_outlined, color: iconColor),
            label: "Settings")
      ],
      currentIndex: 0,
    );
  }
}
