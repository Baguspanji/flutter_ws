import 'package:flutter/material.dart';
import 'package:flutter_ws/src/models/user_model.dart';
import 'package:flutter_ws/src/ui/colors.dart';

import 'package:flutter_ws/src/pref/preference.dart';

class LoginPage extends StatefulWidget {
  static String tag = 'login-page';
  @override
  _LoginPageState createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var _username = TextEditingController();
  var _password = TextEditingController();

  @override
  void initState() {
    getKdUser().then((value) {
      if (value != null) {
        Navigator.pushReplacementNamed(context, '/users');
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final logo = Hero(
      tag: 'hero',
      child: CircleAvatar(
        backgroundColor: Colors.transparent,
        radius: 48.0,
        child: Image.asset('assets/logo.png'),
      ),
    );

    final email = TextFormField(
      controller: _username,
      keyboardType: TextInputType.name,
      autofocus: false,
      decoration: InputDecoration(
        hintText: 'Username',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );

    final password = TextFormField(
      controller: _password,
      autofocus: false,
      obscureText: true,
      decoration: InputDecoration(
        hintText: 'Password',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );

    final loginButton = Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        onPressed: () {
          onLogin();
        },
        padding: EdgeInsets.all(12),
        color: colorses.dasar,
        child: Text('Log In', style: TextStyle(color: Colors.white)),
      ),
    );

    final forgotLabel = FlatButton(
      child: Text(
        'Forgot password?',
        style: TextStyle(color: Colors.black54),
      ),
      onPressed: () {},
    );

    return Scaffold(
      backgroundColor: colorses.background,
      body: Center(
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.only(left: 24.0, right: 24.0),
          children: <Widget>[
            logo,
            SizedBox(height: 48.0),
            email,
            SizedBox(height: 8.0),
            password,
            SizedBox(height: 24.0),
            loginButton,
          ],
        ),
      ),
    );
  }

  void onLogin() {
    const data = [
      {'user': "panji", 'pass': "panji"},
      {'user': "admin", 'pass': "admin"},
      {'user': "client", 'pass': "client"},
    ];

    data.forEach((element) {
      var list = UserData.fromJson(element);
      if (list.user == _username.text && list.pass == _password.text) {
        setKdUser(list.user);

        Navigator.pushReplacementNamed(context, '/users');
      }
    });
  }
}
