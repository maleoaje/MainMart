/*
This is edit phone number page

include file in reuseable/global_function.dart to call function from GlobalFunction
 */

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ijshopflutter/config/constants.dart';
import 'package:ijshopflutter/config/global_style.dart';
import 'package:ijshopflutter/ui/account/account_information/edit_phone_number_choose_verification.dart';
import 'package:ijshopflutter/ui/reuseable/app_localizations.dart';
import 'package:ijshopflutter/ui/reuseable/global_function.dart';

class EditPhoneNumberPage extends StatefulWidget {
  @override
  _EditPhoneNumberPageState createState() => _EditPhoneNumberPageState();
}

class _EditPhoneNumberPageState extends State<EditPhoneNumberPage> {
  // initialize global function
  final _globalFunction = GlobalFunction();

  TextEditingController _etPhoneNumber = TextEditingController();
  bool _buttonDisabled = true;

  @override
  void initState() {
    _etPhoneNumber = TextEditingController(text: '0811888999');

    if(_globalFunction.validateMobileNumber(_etPhoneNumber.text)){
      _buttonDisabled = false;
    } else {
      _buttonDisabled = true;
    }
    super.initState();
  }

  @override
  void dispose() {
    _etPhoneNumber.dispose();
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
            AppLocalizations.of(context).translate('edit_phone_number'),
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
              keyboardType: TextInputType.number,
              controller: _etPhoneNumber,
              style: TextStyle(color: CHARCOAL),
              onChanged: (textValue) {
                setState(() {
                  if(_globalFunction.validateMobileNumber(textValue)){
                    _buttonDisabled = false;
                  } else {
                    _buttonDisabled = true;
                  }
                });
              },
              decoration: InputDecoration(
                  focusedBorder: UnderlineInputBorder(
                      borderSide:
                      BorderSide(color: PRIMARY_COLOR, width: 2.0)),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFFCCCCCC)),
                  ),
                  labelText: AppLocalizations.of(context).translate('phone_number'),
                  labelStyle: TextStyle(color: BLACK_GREY)),
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
                        Navigator.push(context, MaterialPageRoute(builder: (context) => EditPhoneNumberChooseVerificationPage(phoneNumber: _etPhoneNumber.text)));
                        FocusScope.of(context).unfocus();
                      }
                    },
                    padding: EdgeInsets.fromLTRB(0, 12, 0, 12),
                    color: _buttonDisabled?Colors.grey[300]:PRIMARY_COLOR,
                    child: Text(
                      AppLocalizations.of(context).translate('next'),
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: _buttonDisabled?Colors.grey[600]:Colors.white),
                      textAlign: TextAlign.center,
                    ),
                  )),
            ),
          ],
        )
    );
  }
}
