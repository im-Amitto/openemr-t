import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:openemr_app/utils/rest_ds.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../models/user.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  User user;

  final formKey = new GlobalKey<FormState>();
  final scaffoldKey = new GlobalKey<ScaffoldState>();
  String _username, _password, _url;

  void _showSnackBar(String text) {
    scaffoldKey.currentState
        .showSnackBar(new SnackBar(content: new Text(text)));
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
          key: scaffoldKey,
          backgroundColor: GFColors.LIGHT,
          body: Padding(
            padding: EdgeInsets.only(left: width * 0.1, right: width * 0.1),
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Image.asset(
                    'lib/assets/images/gflogo.png',
                    width: width * 0.25,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    child: TextFormField(
                      onSaved: (val) => _username = val,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(), labelText: 'Username'),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    child: TextFormField(
                      onSaved: (val) => _password = val,
                      obscureText: true,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(), labelText: 'Password'),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    child: TextFormField(
                      onSaved: (val) => _url = val,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'URL',
                          hintText: "http://example.com"),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  GFButton(
                    onPressed: () => submit(context),
                    text: 'login',
                    color: GFColors.DARK,
                  ),
                ],
              ),
            ),
          )),
    );
  }

  void submit(context) async {
    final prefs = await SharedPreferences.getInstance();
    final form = formKey.currentState;
    RestDatasource api = new RestDatasource();
    if (form.validate()) {
      form.save();
      api.login(_username.trim(), _password.trim(), _url).then((User user) {
        prefs.setString('token', user.tokenType + " " + user.accessToken);
        prefs.setString('username', user.username);
        prefs.setString('password', user.password);
        prefs.setString('baseUrl', user.baseUrl);
        Navigator.pop(context);
      }).catchError((Object error) => _showSnackBar(error.toString()));
    }
  }
}
