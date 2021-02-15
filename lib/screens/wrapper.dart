import 'package:flutter/material.dart';
import 'package:gestionstock/screens/auth/login.dart';
import 'package:gestionstock/screens/home/home.dart';
import 'package:gestionstock/services/auth_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Wrapper extends StatefulWidget {
  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  // auth variables
  String access = '';
  String refresh = '';
  int expiration = 0;

  @override
  void initState() {
    getData();
  }

  getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      access =
          prefs.getString('access') != null ? prefs.getString('access') : '';
      refresh =
          prefs.getString('refresh') != null ? prefs.getString('refresh') : '';
      print('aaaaaaaaaaaaaaaaaaaaa');
      print(refresh);
      print('aaaaaaaaaaaaaaaaaaaaa');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: (refresh != '')
          ? FutureBuilder(
              future: AuthService().tryRefreshToken(),
              builder: (BuildContext context, AsyncSnapshot statusRefresh) {
                if (statusRefresh.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (statusRefresh.hasData) {
                  if (statusRefresh.data == 200) {
                    return Home();
                  } else {
                    return Login();
                  }
                } else {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text('Connection Problem'),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pushReplacementNamed(context, '/wrapper');
                          },
                          child: Text('Retry'),
                        )
                      ],
                    ),
                  );
                }
              },
            )
          : Login(),
    );
  }
}
