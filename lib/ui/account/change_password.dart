/*
This is change password page

include file in reuseable/global_function.dart to call function from GlobalFunction
 */

import 'package:flutter/material.dart';
import 'package:ijshopflutter/config/constants.dart';
import 'package:ijshopflutter/config/global_style.dart';
import 'package:ijshopflutter/ui/reuseable/app_localizations.dart';
import 'package:ijshopflutter/ui/reuseable/global_function.dart';

class ChangePasswordPage extends StatefulWidget {
  @override
  _ChangePasswordPageState createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  // initialize global function
  final _globalFunction = GlobalFunction();

  final FocusNode _oldPasswordFocus = FocusNode();

  bool _obscureTextNewPass = true;
  bool _obscureTextRetypePass = true;
  IconData _iconVisibleNewPass = Icons.visibility_off;
  IconData _iconVisibleRetypePass = Icons.visibility_off;

  void _toggleNewPass() {
    setState(() {
      _obscureTextNewPass = !_obscureTextNewPass;
      if (_obscureTextNewPass == true) {
        _iconVisibleNewPass = Icons.visibility_off;
      } else {
        _iconVisibleNewPass = Icons.visibility;
      }
    });
  }

  void _toggleRetypePass() {
    setState(() {
      _obscureTextRetypePass = !_obscureTextRetypePass;
      if (_obscureTextRetypePass == true) {
        _iconVisibleRetypePass = Icons.visibility_off;
      } else {
        _iconVisibleRetypePass = Icons.visibility;
      }
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _oldPasswordFocus.dispose();
    super.dispose();
  }

  void _showPopupInsertPassword() {
    // set up the buttons
    Widget cancelButton = FlatButton(
      child: Text(AppLocalizations.of(context).translate('cancel'), style: TextStyle(color: SOFT_BLUE)),
      onPressed: () {
        Navigator.pop(context);
      },
    );
    Widget continueButton = FlatButton(
      child: Text(AppLocalizations.of(context).translate('submit'), style: TextStyle(color: SOFT_BLUE)),
      onPressed: () {
        Navigator.pop(context);
        _globalFunction.startLoading(context, AppLocalizations.of(context).translate('change_password_success'), 1);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      title: Text(AppLocalizations.of(context).translate('verify'), style: TextStyle(fontSize: 18),),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(AppLocalizations.of(context).translate('enter_old_password'), style: TextStyle(fontSize: 13, color: BLACK_GREY)),
          TextField(
            obscureText: true,
            focusNode: _oldPasswordFocus,
            style: TextStyle(color: CHARCOAL),
            decoration: InputDecoration(
              focusedBorder: UnderlineInputBorder(
                  borderSide:
                  BorderSide(color: PRIMARY_COLOR, width: 2.0)),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Color(0xFFCCCCCC)),
              ),
            ),
          ),
        ],
      ),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        FocusScope.of(context).requestFocus(_oldPasswordFocus);
        return alert;
      },
    );
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
            AppLocalizations.of(context).translate('change_password'),
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
            TextField(
              obscureText: _obscureTextNewPass,
              style: TextStyle(color: CHARCOAL),
              decoration: InputDecoration(
                focusedBorder: UnderlineInputBorder(
                    borderSide:
                    BorderSide(color: PRIMARY_COLOR, width: 2.0)),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFFCCCCCC)),
                ),
                labelText: AppLocalizations.of(context).translate('new_password'),
                labelStyle: TextStyle(color: BLACK_GREY),
                suffixIcon: IconButton(
                    icon: Icon(_iconVisibleNewPass, color: Colors.grey[400], size: 20),
                    onPressed: () {
                      _toggleNewPass();
                    }),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            TextField(
              obscureText: _obscureTextRetypePass,
              style: TextStyle(color: CHARCOAL),
              decoration: InputDecoration(
                focusedBorder: UnderlineInputBorder(
                    borderSide:
                    BorderSide(color: PRIMARY_COLOR, width: 2.0)),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFFCCCCCC)),
                ),
                labelText: AppLocalizations.of(context).translate('retype_password'),
                labelStyle: TextStyle(color: BLACK_GREY),
                suffixIcon: IconButton(
                    icon: Icon(_iconVisibleRetypePass, color: Colors.grey[400], size: 20),
                    onPressed: () {
                      _toggleRetypePass();
                    }),
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
                      _showPopupInsertPassword();
                    },
                    padding: EdgeInsets.fromLTRB(0, 12, 0, 12),
                    color: PRIMARY_COLOR,
                    child: Text(
                      AppLocalizations.of(context).translate('save'),
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                  )),
            ),
          ],
        )
    );
  }
}
