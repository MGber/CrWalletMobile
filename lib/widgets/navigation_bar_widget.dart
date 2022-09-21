import '../../blocs/crypto_coin_bloc.dart';
import '../../blocs/navigation_service.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class NavBar extends StatefulWidget {
  const NavBar({Key? key}) : super(key: key);

  @override
  _NavBarState createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Colors.white,
      showSelectedLabels: true,
      showUnselectedLabels: true,
      unselectedItemColor: Colors.amber[800],
      selectedItemColor: Colors.amber[800],
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(label: "Home", icon: Icon(Icons.home_outlined)),
        BottomNavigationBarItem(
            icon: Icon(Icons.account_balance_wallet_outlined), label: "Wallet"),
        BottomNavigationBarItem(
            icon: Icon(MdiIcons.medalOutline), label: "Ranking"),
        BottomNavigationBarItem(
            icon: Icon(Icons.notifications), label: "Notifications")
      ],
      currentIndex: selectedIndex,
      onTap: _onTapItem,
    );
  }

  void _onTapItem(int value) {
    if (selectedIndex == value) return;
    setState(() {
      selectedIndex = value;
    });
    switch (value) {
      case 0:
        navigatorService.navBarKey.currentState!
            .pushReplacementNamed('/')
            .then((value) => coinsBloc.fetchAllCoins());
        break;
      case 1:
        navigatorService.navBarKey.currentState!
            .pushReplacementNamed('/wallet');
        break;
      case 2:
        navigatorService.navBarKey.currentState!
            .pushReplacementNamed('/ranking');
        break;
      case 3:
        navigatorService.navBarKey.currentState!
            .pushReplacementNamed('/notification');
        break;
      default:
        throw Exception("Error while loading route");
    }
  }
}
