/*
This is signin with email page

install plugin in pubspec.yaml
- fluttertoast => to show toast (https://pub.dev/packages/fluttertoast)

Don't forget to add all images and sound used in this pages at the pubspec.yaml
 */

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
//import 'package:fluttertoast/fluttertoast.dart';
import 'package:ijshopflutter/config/constants.dart';
import 'package:ijshopflutter/config/global_style.dart';
import 'package:ijshopflutter/network/network_handler.dart';
import 'package:ijshopflutter/ui/authentication/signup/signup_email.dart';
import 'package:ijshopflutter/ui/bottom_navigation_bar.dart';
import 'package:ijshopflutter/ui/authentication/forgot_password/forgot_password.dart';
import 'package:ijshopflutter/ui/authentication/signup/signup.dart';
import 'package:ijshopflutter/ui/reuseable/app_localizations.dart';

class SigninEmailRegPage extends StatefulWidget {
  final String email;

  const SigninEmailRegPage({Key key, this.email = ''}) : super(key: key);

  @override
  _SigninEmailRegPageState createState() => _SigninEmailRegPageState();
}

class _SigninEmailRegPageState extends State<SigninEmailRegPage> {
  TextEditingController _etEmail = TextEditingController();
  TextEditingController _etPass = TextEditingController();
  NetworkHandler networkHandler = NetworkHandler();
  String errorText;
  bool validate = false;
  bool circular = false;
  bool _obscureText = true;
  final _globalkey = GlobalKey<FormState>();
  IconData _iconVisible = Icons.visibility_off;

  void _toggleObscureText() {
    setState(() {
      _obscureText = !_obscureText;
      if (_obscureText == true) {
        _iconVisible = Icons.visibility_off;
      } else {
        _iconVisible = Icons.visibility;
      }
    });
  }

  @override
  void initState() {
    _etEmail = TextEditingController(text: widget.email);

    super.initState();
  }

  @override
  void dispose() {
    _etEmail.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Form(
      key: _globalkey,
      child: ListView(
        padding: EdgeInsets.fromLTRB(30, 120, 30, 30),
        children: <Widget>[
          Center(
              child: Text(
            'Welcome to',
            style: GlobalStyle.authTitle,
          )),
          Center(
            child: Image.asset('assets/images/logo_light.png', height: 120),
          ),
          Center(
              child: Text(
            'Check Registered email for further instructions on account activation.',
            style: TextStyle(color: Colors.redAccent),
          )),
          SizedBox(
            height: 20,
          ),
          Text(AppLocalizations.of(context).translate('signin'),
              style: GlobalStyle.authTitle),
          TextFormField(
            enabled: false,
            keyboardType: TextInputType.emailAddress,
            controller: _etEmail,
            style: TextStyle(color: CHARCOAL),
            onChanged: (textValue) {
              setState(() {});
            },
            decoration: InputDecoration(
              errorText: validate ? null : errorText,
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: PRIMARY_COLOR, width: 2.0)),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Color(0xFFCCCCCC)),
              ),
              labelText: AppLocalizations.of(context).translate('email'),
              labelStyle: TextStyle(color: BLACK_GREY),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          TextFormField(
            /* validator: (value) {
              if (value.isEmpty) return "Enter Password";
              if (value.length < 8) return "Password too short";
              return null;
            },*/
            obscureText: _obscureText,
            style: TextStyle(color: CHARCOAL),
            decoration: InputDecoration(
              errorText: validate ? null : errorText,
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: PRIMARY_COLOR, width: 2.0)),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Color(0xFFCCCCCC)),
              ),
              labelText: AppLocalizations.of(context).translate('password'),
              labelStyle: TextStyle(color: BLACK_GREY),
              suffixIcon: IconButton(
                  icon: Icon(_iconVisible, color: Colors.grey[400], size: 20),
                  onPressed: () {
                    _toggleObscureText();
                  }),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Align(
              alignment: Alignment.centerRight,
              child: Container(
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ForgotPasswordPage()));
                    FocusScope.of(context).unfocus();
                  },
                  child: Text(
                    AppLocalizations.of(context).translate('forgot_password'),
                    style: TextStyle(color: PRIMARY_COLOR, fontSize: 13),
                  ),
                ),
              )),
          SizedBox(
            height: 40,
          ),
          Container(
            child: SizedBox(
                width: double.maxFinite,
                child: RaisedButton(
                  elevation: 2,
                  shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(3.0),
                      side: BorderSide(color: PRIMARY_COLOR)),
                  onPressed: () async {
                    setState(() {
                      circular = true;
                    });
                    Map<String, String> data = {
                      "phonemail": _etEmail.text,
                      "password": _etPass.text,
                      "channelID": "mobile"
                    };
                    var response = await networkHandler.post(
                        '/api/Buyer/BuyerLogin', data);
                    Map<String, dynamic> output = json.decode(response.body);
                    print(output['code']);
                    if (output['code'] == '00') {
                      //Map<String, dynamic> output = json.decode(response.body);
                      if (_globalkey.currentState.validate()) {
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                                builder: (context) =>
                                    BottomNavigationBarPage()),
                            (Route<dynamic> route) => false);
                      }
                      setState(() {
                        validate = true;
                        circular = false;
                      });
                    } else {
                      setState(() {
                        validate = false;
                        circular = false;
                        errorText =
                            "Invalid Login details or not yet Verified, Kindly Retry";
                      });
                    }
                  },
                  padding: EdgeInsets.fromLTRB(0, 12, 0, 12),
                  color: PRIMARY_COLOR,
                  child: circular
                      ? CircularProgressIndicator()
                      : Text(
                          AppLocalizations.of(context).translate('login'),
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                )),
          ),
          SizedBox(
            height: 40,
          ),
          SizedBox(
            height: 20,
          ),
          Center(
            child: GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SignupEmailPage()));
                FocusScope.of(context).unfocus();
              },
              child: Wrap(
                children: [
                  Text(
                    AppLocalizations.of(context).translate('no_account_yet'),
                    style: GlobalStyle.authBottom1,
                  ),
                  Text(
                    AppLocalizations.of(context).translate('create_one'),
                    style: GlobalStyle.authBottom2,
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Center(
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  GlobalStyle.iconBack,
                  Text(
                    ' ' + AppLocalizations.of(context).translate('back'),
                    style: GlobalStyle.back,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
