/*
This is edit address page

include file in reuseable/global_function.dart to call function from GlobalFunction
 */

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ijshopflutter/config/constants.dart';
import 'package:ijshopflutter/config/global_style.dart';
import 'package:ijshopflutter/ui/reuseable/app_localizations.dart';
import 'package:ijshopflutter/ui/reuseable/global_function.dart';

class EditAddressPage extends StatefulWidget {
  @override
  _EditAddressPageState createState() => _EditAddressPageState();
}

class _EditAddressPageState extends State<EditAddressPage> {
  // initialize global function
  final _globalFunction = GlobalFunction();

  // create controller to edit text field
  TextEditingController _etAddressTitle = TextEditingController();
  TextEditingController _etRecipientName = TextEditingController();
  TextEditingController _etRecipientPhoneNumber = TextEditingController();
  TextEditingController _etAddressLine1 = TextEditingController();
  TextEditingController _etAddressLine2 = TextEditingController();
  TextEditingController _etPostalCode = TextEditingController();
  TextEditingController _etState = TextEditingController();

  @override
  void initState() {
    _etAddressTitle = TextEditingController(text: 'Home Address');
    _etRecipientName = TextEditingController(text: 'Omal');
    _etRecipientPhoneNumber = TextEditingController(text: '0811888999');
    _etAddressLine1 = TextEditingController(text: 'Abuja');
    _etAddressLine2 = TextEditingController(text: '');
    _etPostalCode = TextEditingController(text: '900108');
    _etState = TextEditingController(text: 'Nigeria');

    super.initState();
  }

  @override
  void dispose() {
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
            AppLocalizations.of(context).translate('edit_address'),
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
              controller: _etAddressTitle,
              decoration: InputDecoration(
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: PRIMARY_COLOR, width: 2.0)),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFFCCCCCC)),
                  ),
                  labelText:
                      AppLocalizations.of(context).translate('address_title') +
                          ' *',
                  labelStyle: TextStyle(color: BLACK_GREY)),
            ),
            SizedBox(
              height: 20,
            ),
            TextField(
              controller: _etRecipientName,
              decoration: InputDecoration(
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: PRIMARY_COLOR, width: 2.0)),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFFCCCCCC)),
                  ),
                  labelText:
                      AppLocalizations.of(context).translate('recipient_name') +
                          ' *',
                  labelStyle: TextStyle(color: BLACK_GREY)),
            ),
            SizedBox(
              height: 20,
            ),
            TextField(
              controller: _etRecipientPhoneNumber,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: PRIMARY_COLOR, width: 2.0)),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFFCCCCCC)),
                  ),
                  labelText: AppLocalizations.of(context)
                      .translate('recipient_phone_number'),
                  labelStyle: TextStyle(color: BLACK_GREY)),
            ),
            SizedBox(
              height: 20,
            ),
            TextField(
              controller: _etAddressLine1,
              decoration: InputDecoration(
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: PRIMARY_COLOR, width: 2.0)),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFFCCCCCC)),
                  ),
                  labelText:
                      AppLocalizations.of(context).translate('address_line1') +
                          ' *',
                  labelStyle: TextStyle(color: BLACK_GREY)),
            ),
            SizedBox(
              height: 20,
            ),
            TextField(
              controller: _etAddressLine2,
              decoration: InputDecoration(
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: PRIMARY_COLOR, width: 2.0)),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFFCCCCCC)),
                  ),
                  labelText:
                      AppLocalizations.of(context).translate('address_line2'),
                  labelStyle: TextStyle(color: BLACK_GREY)),
            ),
            SizedBox(
              height: 20,
            ),
            TextField(
              controller: _etState,
              decoration: InputDecoration(
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: PRIMARY_COLOR, width: 2.0)),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFFCCCCCC)),
                  ),
                  labelText: AppLocalizations.of(context)
                          .translate('state_province_region') +
                      ' *',
                  labelStyle: TextStyle(color: BLACK_GREY)),
            ),
            SizedBox(
              height: 20,
            ),
            TextField(
              controller: _etPostalCode,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: PRIMARY_COLOR, width: 2.0)),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFFCCCCCC)),
                  ),
                  labelText:
                      AppLocalizations.of(context).translate('postal_code') +
                          ' *',
                  labelStyle: TextStyle(color: BLACK_GREY)),
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
                      _globalFunction.startLoading(
                          context,
                          AppLocalizations.of(context)
                              .translate('edit_address_success'),
                          1);
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
        ));
  }
}
