/*
This is signup phone number page

Don't forget to add all images and sound used in this pages at the pubspec.yaml
 */

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ijshopflutter/config/constants.dart';
import 'package:ijshopflutter/config/global_style.dart';
import 'package:ijshopflutter/ui/bottom_navigation_bar.dart';
import 'package:ijshopflutter/ui/authentication/signin/signin.dart';
import 'package:ijshopflutter/ui/reuseable/app_localizations.dart';

class SignupPhoneNumberPage extends StatefulWidget {
  final String phoneNumber;

  const SignupPhoneNumberPage({Key key, this.phoneNumber = ''}) : super(key: key);

  @override
  _SignupPhoneNumberPageState createState() => _SignupPhoneNumberPageState();
}

class _SignupPhoneNumberPageState extends State<SignupPhoneNumberPage> {
  TextEditingController _etPhoneNumber = TextEditingController();
  TextEditingController _etName = TextEditingController();

  @override
  void initState() {
    _etPhoneNumber = TextEditingController(text: widget.phoneNumber);
    super.initState();
  }

  @override
  void dispose() {
    _etPhoneNumber.dispose();
    _etName.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: WillPopScope(
          onWillPop: (){
            Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => SigninPage()), (Route<dynamic> route) => false);
            FocusScope.of(context).unfocus();
            return Future.value(true);
          },
          child: ListView(
            padding: EdgeInsets.fromLTRB(30, 120, 30, 30),
            children: <Widget>[
              Center(
                  child: Image.asset('assets/images/logo_light.png',
                      height: 50)),
              SizedBox(
                height: 80,
              ),
              Text(AppLocalizations.of(context).translate('signup'), style: GlobalStyle.authTitle),
              TextFormField(
                enabled: false,
                keyboardType: TextInputType.number,
                controller: _etPhoneNumber,
                style: TextStyle(color: CHARCOAL),
                onChanged: (textValue) {
                  setState(() {});
                },
                decoration: InputDecoration(
                  focusedBorder: UnderlineInputBorder(
                      borderSide:
                      BorderSide(color: PRIMARY_COLOR, width: 2.0)),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFFCCCCCC)),
                  ),
                  labelText: AppLocalizations.of(context).translate('phone_number'),
                  labelStyle: TextStyle(color: BLACK_GREY),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                keyboardType: TextInputType.text,
                controller: _etName,
                style: TextStyle(color: CHARCOAL),
                onChanged: (textValue) {
                  setState(() {});
                },
                decoration: InputDecoration(
                  focusedBorder: UnderlineInputBorder(
                      borderSide:
                      BorderSide(color: PRIMARY_COLOR, width: 2.0)),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFFCCCCCC)),
                  ),
                  labelText: AppLocalizations.of(context).translate('name'),
                  labelStyle: TextStyle(color: BLACK_GREY),
                ),
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
                      onPressed: () {
                        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => BottomNavigationBarPage()), (Route<dynamic> route) => false);
                      },
                      padding: EdgeInsets.fromLTRB(0, 12, 0, 12),
                      color: PRIMARY_COLOR,
                      child: Text(
                        AppLocalizations.of(context).translate('register'),
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                    )),
              ),
              SizedBox(
                height: 30,
              ),
              Center(
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => SigninPage()), (Route<dynamic> route) => false);
                    FocusScope.of(context).unfocus();
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
              ),
            ],
          ),
        ));
  }
}
