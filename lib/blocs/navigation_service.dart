import 'package:flutter/material.dart';

class NavigatorBloc {
  final GlobalKey<NavigatorState> mainKey = GlobalKey<NavigatorState>();
  final GlobalKey<NavigatorState> navBarKey = GlobalKey<NavigatorState>();
}

var navigatorService = NavigatorBloc();
