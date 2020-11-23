/*
This is forgot password page

install plugin in pubspec.yaml
- fluttertoast => to show toast (https://pub.dev/packages/fluttertoast)

Don't forget to add all images and sound used in this pages at the pubspec.yaml
 */

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ijshopflutter/config/constants.dart';
import 'package:ijshopflutter/config/global_style.dart';
import 'package:ijshopflutter/ui/reuseable/app_localizations.dart';
import 'package:http/http.dart' as http;

class ForgotPasswordPage extends StatefulWidget {
  final String email;

  const ForgotPasswordPage({Key key, this.email = ''}) : super(key: key);

  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  TextEditingController _etEmail = TextEditingController();
  bool circular = false;

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
        body: ListView(
      padding: EdgeInsets.fromLTRB(30, 120, 30, 30),
      children: <Widget>[
        Center(child: Image.asset('assets/images/logo_light.png', height: 120)),
        SizedBox(
          height: 20,
        ),
        TextFormField(
          enabled: true,
          keyboardType: TextInputType.emailAddress,
          controller: _etEmail,
          style: TextStyle(color: CHARCOAL),
          onChanged: (textValue) {
            setState(() {});
          },
          decoration: InputDecoration(
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: PRIMARY_COLOR, width: 2.0)),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Color(0xFFCCCCCC)),
              ),
              labelText: AppLocalizations.of(context).translate('email'),
              labelStyle: TextStyle(color: BLACK_GREY)),
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          AppLocalizations.of(context).translate('reset_password_message'),
          style: GlobalStyle.resetPasswordNotes,
        ),
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
                  var response = await http.get(
                    RESET_PASSWORD_API + _etEmail.text,
                  );
                  var link = json.decode(response.body);
                  print(link);
                  if (link['code'] == '00') {
                    Fluttertoast.showToast(
                        msg: 'Successful, new password sent to: ' +
                            _etEmail.text,
                        toastLength: Toast.LENGTH_LONG);
                    setState(() {
                      circular = false;
                    });
                  } else {
                    setState(() {
                      circular = false;
                    });
                    Fluttertoast.showToast(
                        msg: 'Invalid Buyer Account',
                        toastLength: Toast.LENGTH_LONG);
                  }
                },
                padding: EdgeInsets.fromLTRB(0, 12, 0, 12),
                color: PRIMARY_COLOR,
                child: circular
                    ? CircularProgressIndicator()
                    : Text(
                        AppLocalizations.of(context)
                            .translate('reset_password'),
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
              )),
        ),
        SizedBox(
          height: 50,
        ),
        // create sign in link
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
                  AppLocalizations.of(context).translate('back_to_login'),
                  style: GlobalStyle.back,
                )
              ],
            ),
          ),
        )
      ],
    ));
  }
  /*Future checkUser() async {
    var response = await http.get(
      RESET_PASSWORD_API + _etEmail.text,
    );
    var link = json.decode(response.body);
    print(link);
  }*/
}
