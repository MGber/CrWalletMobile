import '../../blocs/navigation_service.dart';
import '../widgets/crypto_list_widget.dart';
import '../widgets/navigation_bar_widget.dart';
import '../widgets/ranking_widget.dart';
import 'widgets/notifications_widget.dart';
import 'widgets/wallet/wallet_widget.dart';
import 'package:flutter/material.dart';

class LoggedInWidget extends StatelessWidget {
  const LoggedInWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minWidth: MediaQuery.of(context).size.width,
            minHeight: MediaQuery.of(context).size.height,
          ),
          child: Navigator(
            key: navigatorService.navBarKey,
            initialRoute: '/',
            onGenerateRoute: (RouteSettings settings) {
              WidgetBuilder builder;
              // Manage your route names here
              switch (settings.name) {
                case '/':
                  builder = (BuildContext context) => const CoinListWidget();
                  break;
                case '/wallet':
                  builder = (BuildContext context) => const WalletWidget();
                  break;
                case '/ranking':
                  builder = (BuildContext context) => const RankingWidget();
                  break;
                case '/notification':
                  builder =
                      (BuildContext context) => const NotificationWidget();
                  break;
                default:
                  throw Exception('Invalid route: ${settings.name}');
              }
              return MaterialPageRoute(builder: builder);
            },
          ),
        ),
      ),
      bottomNavigationBar: const NavBar(),
    );
  }
}
