import '../../blocs/navigation_service.dart';
import '../logged_in_widget.dart';
import 'widgets/coin_view/coin_view_widget.dart';
import '../widgets/login_widget.dart';
import '../widgets/signup_widget.dart';
import 'package:flutter/material.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/login',
      routes: {
        '/login': (context) => const LoginWidget(),
        '/signup': (context) => const SignupWidget(),
        '/logged': (context) => const LoggedInWidget(),
        '/coin': (context) => const CoinViewWidget(),
      },
      navigatorKey: navigatorService.mainKey,
      themeMode: ThemeMode.dark,
      title: 'CryptoWallet',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
    );
  }
}
