/*
This is signin page

include file in reuseable/global_function.dart to call function from GlobalFunction

install plugin in pubspec.yaml
- fluttertoast => to show toast (https://pub.dev/packages/fluttertoast)

Don't forget to add all images and sound used in this pages at the pubspec.yaml
 */

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
//import 'package:fluttertoast/fluttertoast.dart';
import 'package:ijshopflutter/config/constants.dart';
import 'package:ijshopflutter/config/global_style.dart';
//import 'package:ijshopflutter/ui/bottom_navigation_bar.dart';
import 'package:ijshopflutter/ui/authentication/signin/signin_email.dart';
import 'package:ijshopflutter/ui/authentication/signin/signin_phone_number_choose_verification.dart';
import 'package:ijshopflutter/ui/authentication/signup/signup.dart';
import 'package:ijshopflutter/ui/authentication/signup/signup_email.dart';
import 'package:ijshopflutter/ui/reuseable/app_localizations.dart';
import 'package:ijshopflutter/ui/reuseable/global_function.dart';

class SigninPage extends StatefulWidget {
  @override
  _SigninPageState createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> with WidgetsBindingObserver {
  // initialize global function
  final _globalFunction = GlobalFunction();

  bool _buttonDisabled = true;
  String _validate = '';

  TextEditingController _etEmailPhone = TextEditingController();

  @override
  void initState() {
    // start recording lifecycle
    WidgetsBinding.instance.addObserver(this);

    // set status bar color to transparent
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
      ),
    );
    FlutterStatusbarcolor.setStatusBarWhiteForeground(false);

    super.initState();
  }

  @override
  void dispose() {
    // stop recording lifecycle
    WidgetsBinding.instance.removeObserver(this);

    _etEmailPhone.dispose();
    super.dispose();
  }

  // this is the function to do something when the apps is switch
  @override
  didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      FlutterStatusbarcolor.setStatusBarWhiteForeground(false);
    }
    super.didChangeAppLifecycleState(state);
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
        Text(AppLocalizations.of(context).translate('signin'),
            style: GlobalStyle.authTitle),
        TextFormField(
          keyboardType: TextInputType.emailAddress,
          controller: _etEmailPhone,
          style: TextStyle(color: CHARCOAL),
          onChanged: (textValue) {
            setState(() {
              /*if (_globalFunction.validateMobileNumber(textValue)) {
                _buttonDisabled = false;
                _validate = 'phonenumber';
              } else*/
              if (_globalFunction.validateEmail(textValue)) {
                _buttonDisabled = false;
                _validate = 'email';
              } else {
                _buttonDisabled = true;
              }
            });
          },
          decoration: InputDecoration(
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: PRIMARY_COLOR, width: 2.0)),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Color(0xFFCCCCCC)),
              ),
              labelText: 'Email',
              labelStyle: TextStyle(color: BLACK_GREY)),
        ),
        SizedBox(
          height: 10,
        ),
        Align(
          alignment: Alignment.topLeft,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(AppLocalizations.of(context).translate('example') + ' : ',
                  style: GlobalStyle.authNotes),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //Text('08118889991', style: GlobalStyle.authNotes),
                  Text('example@domain.com', style: GlobalStyle.authNotes)
                ],
              )
            ],
          ),
        ),
        SizedBox(
          height: 40,
        ),
        Container(
          child: SizedBox(
              width: double.maxFinite,
              child: FlatButton(
                splashColor:
                    _buttonDisabled ? Colors.transparent : PRIMARY_COLOR,
                highlightColor:
                    _buttonDisabled ? Colors.transparent : PRIMARY_COLOR,
                shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(3.0),
                ),
                onPressed: () {
                  if (!_buttonDisabled) {
                    if (_validate == 'email') {
                      Navigator.of(context).push(PageRouteBuilder(
                          pageBuilder: (_, __, ___) =>
                              SigninEmailPage(email: _etEmailPhone.text)));
                      FocusScope.of(context).unfocus();
                    }
                    /* else if (_validate == 'phonenumber') {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  SigninPhoneNumberChooseVerificationPage(
                                      phoneNumber: _etEmailPhone.text)));
                      FocusScope.of(context).unfocus();
                  }*/
                  }
                },
                padding: EdgeInsets.fromLTRB(0, 12, 0, 12),
                color: _buttonDisabled ? Colors.grey[300] : PRIMARY_COLOR,
                child: Text(
                  AppLocalizations.of(context).translate('next'),
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: _buttonDisabled ? Colors.grey[600] : Colors.white),
                  textAlign: TextAlign.center,
                ),
              )),
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
      ],
    ));
  }
}
