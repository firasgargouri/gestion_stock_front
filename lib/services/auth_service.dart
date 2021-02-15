import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  String baseUrl = 'http://192.168.1.4:8000/';
  String loginEndPoint = 'auth/token/';

  Future<int> login(String username, String password) async {
    String url = "$baseUrl$loginEndPoint";

    final prefs = await SharedPreferences.getInstance();

    final response = await http.post(
      url,
      body: {
        "username": username,
        "password": password,
        "grant_type": "password",
        "client_secret":
            "0lrrTDq7VcnCHzDjfSTPaLR34n6aBUGwvR9wa4pE8BcykCwwkSkei0dxXZ07ekq2DvrgWQaGRtZCH66kuYEGvCK2czcfxTV7azhSRVu8mtp22T70mYhH4h3qXMA0biX0",
        "client_id": "RsAntSfxSRGbHUfAB6M40SYq1dwNrMBTh94Sq0u3"
      },
    );
    if (response.statusCode == 200) {
      String access = json.decode(response.body)["access_token"];
      String refresh = json.decode(response.body)["refresh_token"];
      int expiration = json.decode(response.body)["expires_in"];

      prefs.setString('access', access);
      prefs.setString('refresh', refresh);
      prefs.setInt('expiration', expiration);
      prefs.setBool('isLogged', true);

      print('aaaaaaaaaaaaaaaaaaaaa');
      print(json.decode(response.body));
      print('aaaaaaaaaaaaaaaaaaaaa');

      return response.statusCode;
    } else {
      return response.statusCode;
    }
  }

  Future<int> tryRefreshToken() async {
    String url = "$baseUrl$loginEndPoint";

    final prefs = await SharedPreferences.getInstance();
    String refresh =
        prefs.getString('refresh') != null ? prefs.getString('refresh') : '';

    final response = await http.post(
      url,
      body: {
        "refresh_token": refresh,
        "grant_type": "refresh_token",
        "client_secret":
            "0lrrTDq7VcnCHzDjfSTPaLR34n6aBUGwvR9wa4pE8BcykCwwkSkei0dxXZ07ekq2DvrgWQaGRtZCH66kuYEGvCK2czcfxTV7azhSRVu8mtp22T70mYhH4h3qXMA0biX0",
        "client_id": "RsAntSfxSRGbHUfAB6M40SYq1dwNrMBTh94Sq0u3"
      },
    );
    if (response.statusCode == 200) {
      String access = json.decode(response.body)["access_token"];
      String refresh = json.decode(response.body)["refresh_token"];
      int expiration = json.decode(response.body)["expires_in"];

      prefs.setString('access', access);
      prefs.setString('refresh', refresh);
      prefs.setInt('expiration', expiration);
      prefs.setBool('isLogged', true);

      return response.statusCode;
    } else {
      return response.statusCode;
    }
  }
}
