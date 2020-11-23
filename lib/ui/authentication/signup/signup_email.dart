/*
This is signup with email page

Don't forget to add all images and sound used in this pages at the pubspec.yaml
 */

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ijshopflutter/config/constants.dart';
import 'package:ijshopflutter/config/global_style.dart';
import 'package:ijshopflutter/network/network_handler.dart';
import 'package:ijshopflutter/ui/authentication/signin/signin_email.dart';
import 'package:ijshopflutter/ui/authentication/signin/signin_email_reg.dart';
import 'package:ijshopflutter/ui/bottom_navigation_bar.dart';
import 'package:ijshopflutter/ui/authentication/signin/signin.dart';
import 'package:ijshopflutter/ui/reuseable/app_localizations.dart';

class SignupEmailPage extends StatefulWidget {
  final String email;

  const SignupEmailPage({Key key, this.email = ''}) : super(key: key);

  @override
  _SignupEmailPageState createState() => _SignupEmailPageState();
}

class _SignupEmailPageState extends State<SignupEmailPage> {
  TextEditingController _etEmail = TextEditingController();
  TextEditingController _etName = TextEditingController();
  TextEditingController _etLName = TextEditingController();
  TextEditingController _etAdd = TextEditingController();
  TextEditingController _etPhone = TextEditingController();
  TextEditingController _etPass = TextEditingController();
  TextEditingController _etAgent = TextEditingController();
  String errorText;
  bool validate = false;
  bool circular = false;
  bool _obscureText = true;

  IconData _iconVisible = Icons.visibility_off;
  final _globalkey = GlobalKey<FormState>();
  NetworkHandler networkHandler = NetworkHandler();
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
    _etName.dispose();
    _etLName.dispose();
    _etAdd.dispose();
    _etPhone.dispose();
    _etPass.dispose();
    _etAgent.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        onWillPop: () {
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => SigninPage()),
              (Route<dynamic> route) => false);
          FocusScope.of(context).unfocus();
          return Future.value(true);
        },
        child: Form(
          key: _globalkey,
          child: ListView(
            padding: EdgeInsets.fromLTRB(30, 120, 30, 30),
            children: <Widget>[
              Center(
                  child:
                      Image.asset('assets/images/logo_light.png', height: 120)),
              Center(
                  child: Text('Feilds marked * are Required',
                      style: GlobalStyle.authBottom2)),
              SizedBox(
                height: 20,
              ),
              Text(AppLocalizations.of(context).translate('signup'),
                  style: GlobalStyle.authTitle),
              TextFormField(
                validator: (value) {
                  if (value.isEmpty) return "Enter Email";
                  if (!value.contains('@')) return "Email is invalid";
                  return null;
                },
                enabled: true,
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
              //first name field
              TextFormField(
                validator: (value) {
                  if (value.isEmpty) return "Field can't be empty";
                  return null;
                },
                keyboardType: TextInputType.text,
                controller: _etName,
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
                  labelText: 'First Name*',
                  labelStyle: TextStyle(color: BLACK_GREY),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              //last name field
              TextFormField(
                validator: (value) {
                  if (value.isEmpty) return "Field can't be empty";
                  return null;
                },
                keyboardType: TextInputType.text,
                controller: _etLName,
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
                  labelText: 'Last Name*',
                  labelStyle: TextStyle(color: BLACK_GREY),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              //Phone number field
              TextFormField(
                validator: (value) {
                  if (value.isEmpty) return "Field can't be empty";
                  if (value.length != 11) return "Check phone number";
                  return null;
                },
                keyboardType: TextInputType.phone,
                controller: _etPhone,
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
                  labelText: 'Phone Number*',
                  labelStyle: TextStyle(color: BLACK_GREY),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              //Address field
              TextFormField(
                keyboardType: TextInputType.text,
                controller: _etAdd,
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
                  labelText: 'Address*',
                  labelStyle: TextStyle(color: BLACK_GREY),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              //password field
              TextFormField(
                controller: _etPass,
                validator: (value) {
                  if (value.isEmpty) return "Enter Password";
                  if (value.length < 8) return "Password too short";
                  return null;
                },
                obscureText: _obscureText,
                style: TextStyle(color: CHARCOAL),
                decoration: InputDecoration(
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: PRIMARY_COLOR, width: 2.0)),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFFCCCCCC)),
                  ),
                  labelText: AppLocalizations.of(context).translate('password'),
                  labelStyle: TextStyle(color: BLACK_GREY),
                  suffixIcon: IconButton(
                      icon:
                          Icon(_iconVisible, color: Colors.grey[400], size: 20),
                      onPressed: () {
                        _toggleObscureText();
                      }),
                ),
              ),
              Text('Not less than 8 characters', style: GlobalStyle.authNotes),
              SizedBox(
                height: 10,
              ),
              //agent code
              TextFormField(
                keyboardType: TextInputType.text,
                controller: _etAgent,
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
                  labelText: 'Agent Code',
                  labelStyle: TextStyle(color: BLACK_GREY),
                ),
              ),
              Text('Enter Agent referral code', style: GlobalStyle.authNotes),
              SizedBox(
                height: 10,
              ),
              Container(
                child: SizedBox(
                    //width: double.maxFinite,
                    child: RaisedButton(
                  elevation: 2,
                  shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(3.0),
                      side: BorderSide(color: PRIMARY_COLOR)),
                  onPressed: () async {
                    setState(() {
                      circular = true;
                    });

                    if (_globalkey.currentState.validate()) {
                      Map<String, String> data = {
                        "email": _etEmail.text,
                        "firstName": _etName.text,
                        "homeAddress": _etAdd.text,
                        "lastName": _etLName.text,
                        "password": _etPass.text,
                        "phoneNumber": _etPhone.text,
                        "agentCode": _etAgent.text,
                      };
                      print(data);
                      var response = await networkHandler.post(
                          '/api/Buyer/BuyerReg', data);
                      Map<String, dynamic> output = json.decode(response.body);
                      print(output['code']);
                      if (output['code'] == '00') {
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                                builder: (context) =>
                                    SigninEmailRegPage(email: _etEmail.text)),
                            (Route<dynamic> route) => false);
                        setState(() {
                          circular = false;
                          validate = true;
                        });
                      } else if (output['code'] == '02') {
                        setState(() {
                          validate = false;
                          circular = false;
                          errorText = "user already registered";
                        });
                      }
                    } else {
                      setState(() {
                        validate = false;
                        circular = false;
                      });
                    }
                  },
                  padding: EdgeInsets.fromLTRB(0, 12, 0, 12),
                  color: PRIMARY_COLOR,
                  child: circular
                      ? CircularProgressIndicator()
                      : Text(
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
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (context) => SigninPage()),
                        (Route<dynamic> route) => false);
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
        ),
      ),
    );
  }
}
