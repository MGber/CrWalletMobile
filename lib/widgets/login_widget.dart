import 'package:crypto_wallet_mobile/ressources/providers/network_utils/api_response.dart';
import 'package:crypto_wallet_mobile/widgets/utils/snackbar.dart';

import '../../blocs/navigation_service.dart';
import '../../blocs/user_bloc.dart';
import '../widgets/crypto_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';

import 'utils/widget_callback.dart';

class LoginWidget extends StatefulWidget {
  const LoginWidget({Key? key}) : super(key: key);

  @override
  _LoginWidgetState createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  final GlobalKey<FormState> _loginFormKey = GlobalKey<FormState>();
  final TextEditingController _loginControler = TextEditingController();
  final TextEditingController _passwordControler = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /*Disable overflow when keyboard appears*/
      resizeToAvoidBottomInset: false,
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Form(
          key: _loginFormKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SizedBox(height: 10),
              const Text(
                'Login',
                style: TextStyle(
                  fontSize: 25,
                ),
              ),
              const SizedBox(height: 10),
              const Text("Login"),
              TextFormField(
                key: const Key('login'),
                controller: _loginControler,
                validator: (value) {
                  return validateLogin(value);
                },
                decoration: const InputDecoration(hintText: 'Your login here'),
              ),
              const SizedBox(height: 10),
              const Text("Password"),
              TextFormField(
                key: const Key('password'),
                controller: _passwordControler,
                validator: (value) {
                  return validatePassword(value);
                },
                obscureText: true,
                decoration:
                    const InputDecoration(hintText: 'Your password here'),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                key: const Key('loginButton'),
                onPressed: () => {
                  if (_loginFormKey.currentState!.validate())
                    {
                      userLoggedBloc.logUser(
                          _loginControler.text, _passwordControler.text),
                    }
                },
                child: const Text('Login'),
              ),
              TextButton(
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                ),
                onPressed: () => {
                  navigatorService.mainKey.currentState!
                      .pushReplacementNamed("/signup")
                },
                child: const Text(
                  'No account ? Signup.',
                ),
              ),
              SignInButton(
                Buttons.Google,
                text: "Sign up with Google",
                onPressed: () {},
              ),
              StreamBuilder(
                stream: userLoggedBloc.getUser,
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    switch (snapshot.data.status) {
                      case Status.loading:
                        return Text(snapshot.data.message);
                      case Status.completed:
                        WidgetCallback.callBackMethod(() => {
                              navigatorService.mainKey.currentState!
                                  .pushNamedAndRemoveUntil(
                                      '/logged', (route) => false),
                            });
                        WidgetCallback.callBackMethod(() => {
                              SnackBarUtil.showSnackBar(
                                  context, "Login successfull.", Colors.green)
                            });
                        return Container();
                      case Status.error:
                        return Text(snapshot.data.message);
                    }
                  }
                  return Container();
                },
              )
            ],
          ),
        ),
      )),
    );
  }

  String? validateLogin(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a login';
    }
    if (value.length < 2) {
      return 'Minimum 5 characters';
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a password';
    }
    if (value.length < 2) {
      return 'Minimum 6 characters';
    }
    return null;
  }

  void autoLogIn() async {
    await userLoggedBloc.logUser('maxgbr', 'nohash');
    if (userLoggedBloc.isLogged) {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => const CoinListWidget()));
    }
  }
}

/*Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const CoinListWidget()))*/
