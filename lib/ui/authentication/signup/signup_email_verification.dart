/*
This is signup email verification page

include file in reuseable/global_function.dart to call function from GlobalFunction

install plugin in pubspec.yaml
- pin_code_fields => to create input field for code verification (https://pub.dev/packages/pin_code_fields)

Don't forget to add all images and sound used in this pages at the pubspec.yaml
 */

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ijshopflutter/config/constants.dart';
import 'package:ijshopflutter/config/global_style.dart';
import 'package:ijshopflutter/ui/authentication/signup/signup_email.dart';
import 'package:ijshopflutter/ui/reuseable/app_localizations.dart';
import 'package:ijshopflutter/ui/reuseable/global_function.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class SignupEmailVerificationPage extends StatefulWidget {
  final String email;

  const SignupEmailVerificationPage({Key key, this.email = ''}) : super(key: key);

  @override
  _SignupEmailVerificationPageState createState() => _SignupEmailVerificationPageState();
}

class _SignupEmailVerificationPageState extends State<SignupEmailVerificationPage> {
  // initialize global function
  final _globalFunction = GlobalFunction();

  bool _buttonDisabled = true;
  String _verificationCode = '';

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
          padding: EdgeInsets.fromLTRB(30, 120, 30, 30),
          children: <Widget>[
            Center(
                child: Icon(Icons.email, color: PRIMARY_COLOR, size: 50)
            ),
            SizedBox(height: 20),
            Center(
                child: Text(
                  AppLocalizations.of(context).translate('enter_verification_code'),
                  style: GlobalStyle.chooseVerificationTitle,
                )),
            SizedBox(
              height: 20,
            ),
            Container(
              width: MediaQuery.of(context).size.width / 1.5,
              child: Text(
                AppLocalizations.of(context).translate('enter_verification_code_message')+widget.email,
                style: GlobalStyle.chooseVerificationMessage,
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 50),
              child: PinCodeTextField(
                autoFocus: true,
                appContext: context,
                textInputType: TextInputType.number,
                length: 4,
                obsecureText: false,
                animationType: AnimationType.fade,
                pinTheme: PinTheme(
                    shape: PinCodeFieldShape.underline,
                    fieldHeight: 50,
                    fieldWidth: 40,
                    inactiveColor: SOFT_GREY,
                    activeColor: PRIMARY_COLOR,
                    selectedColor: PRIMARY_COLOR
                ),
                animationDuration: Duration(milliseconds: 300),
                backgroundColor: Colors.transparent,
                onChanged: (value) {
                  setState(() {
                    if(value.length==4){
                      _buttonDisabled = false;
                    } else {
                      _buttonDisabled = true;
                    }
                    _verificationCode = value;
                  });
                },
                beforeTextPaste: (text) {
                  return false;
                },
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Container(
              child: SizedBox(
                  width: double.maxFinite,
                  child: FlatButton(
                    splashColor: _buttonDisabled?Colors.transparent:PRIMARY_COLOR,
                    highlightColor: _buttonDisabled?Colors.transparent:PRIMARY_COLOR,
                    shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(3.0),
                    ),
                    onPressed: () {
                      if(!_buttonDisabled){
                        print(_verificationCode);
                        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => SignupEmailPage(email: widget.email)), (Route<dynamic> route) => false);
                        FocusScope.of(context).unfocus();
                      }
                    },
                    padding: EdgeInsets.fromLTRB(0, 12, 0, 12),
                    color: _buttonDisabled?Colors.grey[300]:PRIMARY_COLOR,
                    child: Text(
                      AppLocalizations.of(context).translate('verify'),
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: _buttonDisabled?Colors.grey[600]:Colors.white),
                      textAlign: TextAlign.center,
                    ),
                  )
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Center(
              child: Wrap(
                children: [
                  Text(
                    AppLocalizations.of(context).translate('not_receive_code'),
                    style: GlobalStyle.notReceiveCode,
                  ),
                  GestureDetector(
                    onTap: (){
                      _globalFunction.resendVerification(context, AppLocalizations.of(context).translate('resend_verification_message_email'));
                    },
                    child: Text(
                      AppLocalizations.of(context).translate('resend'),
                      style: GlobalStyle.resendVerification,
                    ),
                  )
                ],
              ),
            ),
          ],
        ));
  }
}
