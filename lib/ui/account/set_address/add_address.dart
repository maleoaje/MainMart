/*
This is add address page

include file in reuseable/global_function.dart to call function from GlobalFunction
 */

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ijshopflutter/config/constants.dart';
import 'package:ijshopflutter/config/global_style.dart';
import 'package:ijshopflutter/ui/reuseable/app_localizations.dart';
import 'package:ijshopflutter/ui/reuseable/global_function.dart';

class AddAddressPage extends StatefulWidget {
  @override
  _AddAddressPageState createState() => _AddAddressPageState();
}

class _AddAddressPageState extends State<AddAddressPage> {
  // initialize global function
  final _globalFunction = GlobalFunction();

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
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: Colors.black, //change your color here
          ),
          elevation: 0,
          title: Text(
            AppLocalizations.of(context).translate('add_address'),
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
              decoration: InputDecoration(
                  focusedBorder: UnderlineInputBorder(
                      borderSide:
                      BorderSide(color: PRIMARY_COLOR, width: 2.0)),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFFCCCCCC)),
                  ),
                  labelText: AppLocalizations.of(context).translate('address_title')+' *',
                  labelStyle:
                  TextStyle(color: BLACK_GREY)),
            ),
            SizedBox(
              height: 20,
            ),
            TextField(
              decoration: InputDecoration(
                  focusedBorder: UnderlineInputBorder(
                      borderSide:
                      BorderSide(color: PRIMARY_COLOR, width: 2.0)),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFFCCCCCC)),
                  ),
                  labelText: AppLocalizations.of(context).translate('recipient_name')+' *',
                  labelStyle:
                  TextStyle(color: BLACK_GREY)),
            ),
            SizedBox(
              height: 20,
            ),
            TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  focusedBorder: UnderlineInputBorder(
                      borderSide:
                      BorderSide(color: PRIMARY_COLOR, width: 2.0)),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFFCCCCCC)),
                  ),
                  labelText: AppLocalizations.of(context).translate('recipient_phone_number'),
                  labelStyle:
                  TextStyle(color: BLACK_GREY)),
            ),
            SizedBox(
              height: 20,
            ),
            TextField(
              decoration: InputDecoration(
                  focusedBorder: UnderlineInputBorder(
                      borderSide:
                      BorderSide(color: PRIMARY_COLOR, width: 2.0)),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFFCCCCCC)),
                  ),
                  labelText: AppLocalizations.of(context).translate('address_line1')+' *',
                  labelStyle:
                  TextStyle(color: BLACK_GREY)),
            ),
            SizedBox(
              height: 20,
            ),
            TextField(
              decoration: InputDecoration(
                  focusedBorder: UnderlineInputBorder(
                      borderSide:
                      BorderSide(color: PRIMARY_COLOR, width: 2.0)),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFFCCCCCC)),
                  ),
                  labelText: AppLocalizations.of(context).translate('address_line2'),
                  labelStyle:
                  TextStyle(color: BLACK_GREY)),
            ),
            SizedBox(
              height: 20,
            ),
            TextField(
              decoration: InputDecoration(
                  focusedBorder: UnderlineInputBorder(
                      borderSide:
                      BorderSide(color: PRIMARY_COLOR, width: 2.0)),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFFCCCCCC)),
                  ),
                  labelText: AppLocalizations.of(context).translate('state_province_region')+' *',
                  labelStyle:
                  TextStyle(color: BLACK_GREY)),
            ),
            SizedBox(
              height: 20,
            ),
            TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  focusedBorder: UnderlineInputBorder(
                      borderSide:
                      BorderSide(color: PRIMARY_COLOR, width: 2.0)),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFFCCCCCC)),
                  ),
                  labelText: AppLocalizations.of(context).translate('postal_code')+' *',
                  labelStyle:
                  TextStyle(color: BLACK_GREY)),
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
                      _globalFunction.startLoading(context, AppLocalizations.of(context).translate('add_address_success'), 1);
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
