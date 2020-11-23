/*
This is edit payment page

include file in reuseable/global_function.dart to call function from GlobalFunction

Don't forget to add all images and sound used in this pages at the pubspec.yaml
 */

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ijshopflutter/config/constants.dart';
import 'package:ijshopflutter/config/global_style.dart';
import 'package:ijshopflutter/ui/reuseable/app_localizations.dart';
import 'package:ijshopflutter/ui/reuseable/global_function.dart';

class EditPaymentMethodPage extends StatefulWidget {
  @override
  _EditPaymentMethodPageState createState() => _EditPaymentMethodPageState();
}

class _EditPaymentMethodPageState extends State<EditPaymentMethodPage> {
  // initialize global function
  final _globalFunction = GlobalFunction();

  TextEditingController _etCreditCardNumber = TextEditingController();
  TextEditingController _etCreditCardName = TextEditingController();
  TextEditingController _etFullName = TextEditingController();
  TextEditingController _etAddressLine1 = TextEditingController();
  TextEditingController _etAddressLine2 = TextEditingController();
  TextEditingController _etCity = TextEditingController();
  TextEditingController _etState = TextEditingController();
  TextEditingController _etPostalCode = TextEditingController();
  TextEditingController _etPhoneNumber = TextEditingController();

  List<String> _monthList = new List();
  List<String> _yearList = new List();
  String _expiredMonth = "04";
  String _expiredYear = "2023";

  @override
  void initState() {
    _etCreditCardNumber = TextEditingController(text: '4485653755194392');
    _etCreditCardName = TextEditingController(text: 'Omale');
    _etFullName = TextEditingController(text: 'Omale');
    _etAddressLine1 = TextEditingController(
        text: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.');
    _etAddressLine2 = TextEditingController(
        text:
            'Quisque tortor tortor, ultrices id scelerisque a, elementum id elit.');
    _etCity = TextEditingController(text: 'Abuja');
    _etState = TextEditingController(text: 'FCT');
    _etPostalCode = TextEditingController(text: '900108');
    _etPhoneNumber = TextEditingController(text: '08118889991');

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      _initForLang();
    });

    super.initState();
  }

  void _initForLang() {
    setState(() {
      // select box data for month of credit card
      _monthList.add(AppLocalizations.of(context).translate('month'));
      _monthList.add("01");
      _monthList.add('02');
      _monthList.add('03');
      _monthList.add('04');
      _monthList.add('05');
      _monthList.add('06');
      _monthList.add('07');
      _monthList.add('08');
      _monthList.add('09');
      _monthList.add('10');
      _monthList.add('11');
      _monthList.add('12');

      // select box data for year of credit card
      _yearList.add(AppLocalizations.of(context).translate('year'));
      _yearList.add("2020");
      _yearList.add('2021');
      _yearList.add('2022');
      _yearList.add('2023');
      _yearList.add('2024');
      _yearList.add('2025');
    });
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
            AppLocalizations.of(context).translate('edit_payment_method'),
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
            Text(
                AppLocalizations.of(context)
                    .translate('credit_card_information'),
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            Container(
              margin: EdgeInsets.only(top: 20),
              child: Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(right: 8),
                    padding: EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Color(0xffcccccc),
                        width: 1.0,
                      ),
                    ),
                    child: Image.asset('assets/images/visa.png', height: 10),
                  ),
                  Container(
                    margin: EdgeInsets.only(right: 8),
                    padding: EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Color(0xffcccccc),
                        width: 1.0,
                      ),
                    ),
                    child:
                        Image.asset('assets/images/mastercard.png', height: 20),
                  ),
                ],
              ),
            ),
            TextField(
              controller: _etCreditCardNumber,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: PRIMARY_COLOR, width: 2.0)),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFFCCCCCC)),
                  ),
                  labelText: AppLocalizations.of(context)
                          .translate('credit_card_number') +
                      ' *',
                  labelStyle: TextStyle(color: BLACK_GREY)),
            ),
            SizedBox(
              height: 20,
            ),
            TextField(
              controller: _etCreditCardName,
              decoration: InputDecoration(
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: PRIMARY_COLOR, width: 2.0)),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFFCCCCCC)),
                  ),
                  labelText: AppLocalizations.of(context)
                          .translate('name_of_cardholder') +
                      ' *',
                  labelStyle: TextStyle(color: BLACK_GREY)),
            ),
            SizedBox(
              height: 20,
            ),
            Text(AppLocalizations.of(context).translate('expired_date') + ' *',
                style: TextStyle(color: BLACK_GREY, fontSize: 12)),
            Row(
              children: [
                _buildExpiredMonth(),
                SizedBox(
                  width: 16,
                ),
                _buildExpiredYear(),
              ],
            ),
            SizedBox(
              height: 32,
            ),
            Text(AppLocalizations.of(context).translate('billing_information'),
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            TextField(
              controller: _etFullName,
              decoration: InputDecoration(
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: PRIMARY_COLOR, width: 2.0)),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFFCCCCCC)),
                  ),
                  labelText:
                      AppLocalizations.of(context).translate('full_name') +
                          ' *',
                  labelStyle: TextStyle(color: BLACK_GREY)),
            ),
            SizedBox(
              height: 20,
            ),
            TextField(
              decoration: InputDecoration(
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: PRIMARY_COLOR, width: 2.0)),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFFCCCCCC)),
                  ),
                  labelText:
                      AppLocalizations.of(context).translate('company_name'),
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
              controller: _etCity,
              decoration: InputDecoration(
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: PRIMARY_COLOR, width: 2.0)),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFFCCCCCC)),
                  ),
                  labelText:
                      AppLocalizations.of(context).translate('city') + ' *',
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
              height: 20,
            ),
            TextField(
              controller: _etPhoneNumber,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: PRIMARY_COLOR, width: 2.0)),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFFCCCCCC)),
                  ),
                  labelText:
                      AppLocalizations.of(context).translate('phone_number') +
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
                              .translate('edit_payment_method_success'),
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

  //  dropdown menu
  DropdownButton<String> _buildExpiredMonth() {
    return DropdownButton<String>(
      value: _expiredMonth,
      icon: Icon(Icons.arrow_drop_down),
      iconSize: 24,
      elevation: 16,
      style: TextStyle(color: Colors.grey[700], fontSize: 16),
      underline: Container(
        height: 1,
        color: Colors.grey[600],
      ),
      onChanged: (String data) {
        setState(() {
          _expiredMonth = data;
        });
      },
      items: _monthList.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Container(
            child: Text(value),
            alignment: Alignment.center,
          ),
        );
      }).toList(),
    );
  }

  DropdownButton<String> _buildExpiredYear() {
    return DropdownButton<String>(
      value: _expiredYear,
      icon: Icon(Icons.arrow_drop_down),
      iconSize: 24,
      elevation: 16,
      style: TextStyle(color: Colors.grey[700], fontSize: 16),
      underline: Container(
        height: 1,
        color: Colors.grey[600],
      ),
      onChanged: (String data) {
        setState(() {
          _expiredYear = data;
        });
      },
      items: _yearList.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Container(
            child: Text(value),
            alignment: Alignment.center,
          ),
        );
      }).toList(),
    );
  }
}
