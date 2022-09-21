import '../ressources/providers/network_utils/api_response.dart';

import '../../blocs/navigation_service.dart';
import '../../blocs/user_bloc.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';

import 'alert_callback_widget.dart';
import 'utils/snackbar.dart';
import 'utils/widget_callback.dart';

class SignupWidget extends StatefulWidget {
  const SignupWidget({Key? key}) : super(key: key);

  @override
  _SignupWidgetState createState() => _SignupWidgetState();
}

class _SignupWidgetState extends State<SignupWidget> {
  final GlobalKey<FormState> _signupFormKey = GlobalKey<FormState>();
  final TextEditingController _login = TextEditingController();
  final TextEditingController _firstName = TextEditingController();
  final TextEditingController _lastname = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _password2 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /*Disable overflow when keyboard appears*/
      resizeToAvoidBottomInset: false,
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Form(
          key: _signupFormKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const AlertCallbackWidget(),
              const SizedBox(height: 10),
              const Text(
                'Signup',
                style: TextStyle(
                  fontSize: 25,
                ),
              ),
              const SizedBox(height: 10),
              const Text('Login'),
              TextFormField(
                controller: _login,
                validator: (value) => (value == null || value.isEmpty)
                    ? 'Please enter a login'
                    : null,
                decoration: const InputDecoration(hintText: 'franck123'),
              ),
              const Text("First name"),
              TextFormField(
                controller: _firstName,
                validator: (value) => (value == null || value.isEmpty)
                    ? 'Please enter your first name'
                    : null,
                decoration: const InputDecoration(hintText: 'Franck'),
              ),
              const SizedBox(height: 10),
              const Text("Last name"),
              TextFormField(
                controller: _lastname,
                validator: (value) => (value == null || value.isEmpty)
                    ? 'Please eneter your last name'
                    : null,
                decoration: const InputDecoration(hintText: 'Sinatra'),
              ),
              const SizedBox(height: 10),
              const Text("Email"),
              TextFormField(
                controller: _email,
                validator: (value) =>
                    (value != null && EmailValidator.validate(value))
                        ? null
                        : 'Please enetr a valid email',
                decoration:
                    const InputDecoration(hintText: 'example@email.com'),
              ),
              const SizedBox(height: 10),
              const Text("Password"),
              TextFormField(
                controller: _password,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter password';
                  }
                  if (_password2.text != value) {
                    return 'Passwords dont match';
                  }
                  return null;
                },
                obscureText: true,
                decoration:
                    const InputDecoration(hintText: 'Your password here'),
              ),
              const SizedBox(height: 10),
              const Text("Confirm password"),
              TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please confirm password';
                  }
                  if (_password2.text != value) {
                    return 'Passwords dont match';
                  }
                  return null;
                },
                controller: _password2,
                obscureText: true,
                decoration: const InputDecoration(hintText: 'Confirm password'),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () => {
                  if (_signupFormKey.currentState!.validate())
                    {
                      userLoggedBloc.registerUser(_login.text, _email.text,
                          _password.text, _lastname.text, _firstName.text),
                    }
                },
                child: const Text('Signup'),
              ),
              TextButton(
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                ),
                onPressed: () => {
                  navigatorService.mainKey.currentState!.pushNamed('/login')
                },
                child: const Text(
                  'An account ? Login.',
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
                                  context, "Account created.", Colors.green)
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
}
