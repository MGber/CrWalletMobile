import 'dart:io';

import '../../../blocs/user_bloc.dart';

final headers = {
  'Content-type': 'application/json',
  'Accept': 'application/json',
};

Map<String, String> authorisationHeaders = {
  'Content-Type': 'application/json; charset=UTF-8',
  HttpHeaders.authorizationHeader: userLoggedBloc.user.getToken(),
  "Access-Control-Allow-Origin": "*"
};

//const baseUrl = "http://10.0.2.2:8080";
const baseUrl = "http://studapps.cg.helmo.be:5005/REST_LAMY_GABER";
