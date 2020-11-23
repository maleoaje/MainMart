/*
This is edit email page

include file in reuseable/global_function.dart to call function from GlobalFunction
 */

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ijshopflutter/config/constants.dart';
import 'package:ijshopflutter/config/global_style.dart';
import 'package:ijshopflutter/ui/account/account_information/edit_email_choose_verification.dart';
import 'package:ijshopflutter/ui/reuseable/app_localizations.dart';
import 'package:ijshopflutter/ui/reuseable/global_function.dart';

class EditEmailPage extends StatefulWidget {
  @override
  _EditEmailPageState createState() => _EditEmailPageState();
}

class _EditEmailPageState extends State<EditEmailPage> {
  // initialize global function
  final _globalFunction = GlobalFunction();

  TextEditingController _etEmail = TextEditingController();
  bool _buttonDisabled = true;

  @override
  void initState() {
    _etEmail = TextEditingController(text: 'omale@test.com');

    if (_globalFunction.validateEmail(_etEmail.text)) {
      _buttonDisabled = false;
    } else {
      _buttonDisabled = true;
    }
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
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: Colors.black, //change your color here
          ),
          elevation: 0,
          title: Text(
            AppLocalizations.of(context).translate('edit_email'),
            style: GlobalStyle.appBarTitle,
          ),
          backgroundColor: Colors.white,
          bottom: PreferredSize(
              child: Container(
                color: Colors.grey[100],
                height: 1.0,
              ),
              preferredSize: Size.fromHeight(1.0)),
        ),
        body: ListView(
          padding: EdgeInsets.all(16),
          children: [
            TextFormField(
              keyboardType: TextInputType.emailAddress,
              controller: _etEmail,
              style: TextStyle(color: CHARCOAL),
              onChanged: (textValue) {
                setState(() {
                  if (_globalFunction.validateEmail(textValue)) {
                    _buttonDisabled = false;
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
                  labelText: AppLocalizations.of(context).translate('email'),
                  labelStyle: TextStyle(color: BLACK_GREY)),
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
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    EditEmailChooseVerificationPage(
                                        email: _etEmail.text)));
                        FocusScope.of(context).unfocus();
                      }
                    },
                    padding: EdgeInsets.fromLTRB(0, 12, 0, 12),
                    color: _buttonDisabled ? Colors.grey[300] : PRIMARY_COLOR,
                    child: Text(
                      AppLocalizations.of(context).translate('next'),
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: _buttonDisabled
                              ? Colors.grey[600]
                              : Colors.white),
                      textAlign: TextAlign.center,
                    ),
                  )),
            ),
          ],
        ));
  }
}
