import 'package:flutter/material.dart';
import 'package:gestionstock/services/auth_service.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String username = '';
  String password = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Text('Login'),
            SizedBox(height: 30.0),
            TextField(
              keyboardType: TextInputType.text,
              onChanged: (input) => username = input,
              decoration: InputDecoration(
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                  color: Colors.deepOrange[600],
                )),
                labelText: "Username",
                labelStyle: TextStyle(
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
              ),
            ),
            TextField(
              keyboardType: TextInputType.text,
              onChanged: (input) => password = input,
              obscureText: true,
              decoration: InputDecoration(
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                  color: Colors.deepOrange[600],
                )),
                labelText: "Password",
                labelStyle: TextStyle(
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
              ),
            ),
            ElevatedButton(
              child: Text('Connect'),
              onPressed: () async {
                await AuthService().login(username, password).then((status) {
                  if (status == 200) {
                    final snackBar =
                        SnackBar(content: Text("Login Successful"));

                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    Navigator.pushReplacementNamed(context, '/home');
                  } else {
                    final snackBar =
                        SnackBar(content: Text("Wrong Username/Password"));

                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }
                });
              },
            )
          ],
        ),
      ),
    );
  }
}
