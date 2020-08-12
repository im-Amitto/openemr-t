import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import './userHome.dart';
import '../models/user.dart';
import 'package:json_store/json_store.dart';
import '../utils/store.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  User user;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
          body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Image.asset('lib/assets/images/logo.png'),
          SizedBox(
            width: 400,
            child: TextField(
              onChanged: (text) {
                print(text);
                setState(() {
                  user.username = text;
                });
              },
              decoration: InputDecoration(
                  border: OutlineInputBorder(), labelText: 'Username'),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          SizedBox(
            width: 400,
            child: TextField(
              onChanged: (text) {
                setState(() {
                  user.password = text;
                });
              },
              obscureText: true,
              decoration: InputDecoration(
                  border: OutlineInputBorder(), labelText: 'Password'),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          SizedBox(
            width: 400,
            child: TextField(
              onChanged: (text) {
                setState(() {
                  user.url = text;
                });
              },
              decoration: InputDecoration(
                  border: OutlineInputBorder(), labelText: 'Website Url'),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          GFButton(
            onPressed: submit,
            text: 'login',
            color: GFColors.PRIMARY,
          ),
        ],
      )),
    );
  }

  void submit() {
    // do your shit here

    // if login succeessfull then

    // set store data
    Store store;
    store._setStoreState('username', user.username);
  }
}
