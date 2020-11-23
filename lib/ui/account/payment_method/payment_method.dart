/*
This is payment method page

include file in reuseable/global_function.dart to call function from GlobalFunction

install plugin in pubspec.yaml
- fluttertoast => to show toast (https://pub.dev/packages/fluttertoast)

Don't forget to add all images and sound used in this pages at the pubspec.yaml
 */

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ijshopflutter/config/constants.dart';
import 'package:ijshopflutter/config/global_style.dart';
import 'package:ijshopflutter/ui/account/payment_method/add_payment_method.dart';
import 'package:ijshopflutter/ui/account/payment_method/edit_payment_method.dart';
import 'package:ijshopflutter/ui/reuseable/app_localizations.dart';
import 'package:ijshopflutter/ui/reuseable/global_function.dart';

class PaymentMethodPage extends StatefulWidget {
  @override
  _PaymentMethodPageState createState() => _PaymentMethodPageState();
}

class _PaymentMethodPageState extends State<PaymentMethodPage> {
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
            AppLocalizations.of(context).translate('payment_method'),
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
            Text(AppLocalizations.of(context).translate('default_payment_pref'),
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: CHARCOAL)),
            Container(
              margin: EdgeInsets.only(top: 8),
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Color(0xffcccccc),
                  width: 1.0,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: Text(
                        AppLocalizations.of(context)
                            .translate('payment_method'),
                        style:
                            TextStyle(fontSize: 14, color: Colors.grey[400])),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 8),
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
                          child:
                              Image.asset('assets/images/visa.png', height: 10),
                        ),
                        Text(
                            AppLocalizations.of(context)
                                .translate('visa_card_ending_in1'),
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: CHARCOAL))
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 24),
                    child: Text(
                        AppLocalizations.of(context)
                            .translate('billing_address'),
                        style:
                            TextStyle(fontSize: 14, color: Colors.grey[400])),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 8),
                    child: Text(
                        'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Quisque tortor tortor, ultrices id scelerisque a, elementum id elit.',
                        style: TextStyle(fontSize: 14, color: CHARCOAL)),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 24),
                    child: Text(
                        AppLocalizations.of(context).translate('phone_number'),
                        style:
                            TextStyle(fontSize: 14, color: Colors.grey[400])),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 8),
                    child: Text('0811888999',
                        style: TextStyle(fontSize: 14, color: CHARCOAL)),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 32,
            ),
            Container(
              margin: EdgeInsets.only(bottom: 8),
              child: Text(
                  AppLocalizations.of(context)
                      .translate('list_of_payment_method'),
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: CHARCOAL)),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Container(
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(
                      color: Color(0xffcccccc),
                      width: 1.0,
                    ),
                  ),
                ),
                child: DataTable(
                  columns: <DataColumn>[
                    DataColumn(
                        label: Text(
                            AppLocalizations.of(context)
                                .translate('credit_card'),
                            style: TextStyle(
                                fontWeight: FontWeight.bold, color: CHARCOAL))),
                    DataColumn(
                        label: Text(
                            AppLocalizations.of(context)
                                .translate('name_on_card'),
                            style: TextStyle(
                                fontWeight: FontWeight.bold, color: CHARCOAL))),
                    DataColumn(
                        label: Text(
                            AppLocalizations.of(context)
                                .translate('expires_on'),
                            style: TextStyle(
                                fontWeight: FontWeight.bold, color: CHARCOAL))),
                    DataColumn(
                        label: Text(
                            AppLocalizations.of(context).translate('action'),
                            style: TextStyle(
                                fontWeight: FontWeight.bold, color: CHARCOAL))),
                  ],
                  rows: <DataRow>[
                    DataRow(
                      cells: <DataCell>[
                        DataCell(Row(
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
                              child: Image.asset('assets/images/visa.png',
                                  height: 10),
                            ),
                            Text(AppLocalizations.of(context)
                                .translate('visa_card_ending_in1'))
                          ],
                        )),
                        DataCell(Text("Omale")),
                        DataCell(Text("04/2023")),
                        DataCell(Row(
                          children: [
                            Container(
                              margin: EdgeInsets.only(right: 8),
                              padding: EdgeInsets.fromLTRB(8, 2, 8, 2),
                              decoration: BoxDecoration(
                                  color: SOFT_BLUE,
                                  borderRadius: BorderRadius.circular(2)),
                              child: Row(
                                children: [
                                  Text(
                                      AppLocalizations.of(context)
                                          .translate('default'),
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 11)),
                                  SizedBox(
                                    width: 4,
                                  ),
                                  Icon(Icons.done,
                                      color: Colors.white, size: 11)
                                ],
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            EditPaymentMethodPage()));
                              },
                              child: Text(
                                  AppLocalizations.of(context)
                                      .translate('edit'),
                                  style: TextStyle(color: SOFT_BLUE)),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 8),
                              child: GestureDetector(
                                onTap: () {
                                  _showPopupDeletePayment(0);
                                },
                                child: Text(
                                    AppLocalizations.of(context)
                                        .translate('delete'),
                                    style: TextStyle(color: SOFT_BLUE)),
                              ),
                            )
                          ],
                        )),
                      ],
                    ),
                    DataRow(
                      cells: <DataCell>[
                        DataCell(Row(
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
                              child: Image.asset('assets/images/mastercard.png',
                                  height: 20),
                            ),
                            Text(AppLocalizations.of(context)
                                .translate('master_card_ending_in'))
                          ],
                        )),
                        DataCell(Text("Omale")),
                        DataCell(Text("07/2022")),
                        DataCell(Row(
                          children: [
                            Container(
                              margin: EdgeInsets.only(right: 8),
                              child: GestureDetector(
                                onTap: () {
                                  showPopupMakeDefault();
                                },
                                child: Text(
                                    AppLocalizations.of(context)
                                        .translate('make_default'),
                                    style: TextStyle(color: SOFT_BLUE)),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            EditPaymentMethodPage()));
                              },
                              child: Text(
                                  AppLocalizations.of(context)
                                      .translate('edit'),
                                  style: TextStyle(color: SOFT_BLUE)),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 8),
                              child: GestureDetector(
                                onTap: () {
                                  _showPopupDeletePayment(1);
                                },
                                child: Text(
                                    AppLocalizations.of(context)
                                        .translate('delete'),
                                    style: TextStyle(color: SOFT_BLUE)),
                              ),
                            )
                          ],
                        )),
                      ],
                    ),
                    DataRow(
                      cells: <DataCell>[
                        DataCell(Row(
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
                              child: Image.asset('assets/images/visa.png',
                                  height: 10),
                            ),
                            Text(AppLocalizations.of(context)
                                .translate('visa_card_ending_in2'))
                          ],
                        )),
                        DataCell(Text("Omale")),
                        DataCell(Text("11/2021")),
                        DataCell(Row(
                          children: [
                            Container(
                              margin: EdgeInsets.only(right: 8),
                              child: GestureDetector(
                                onTap: () {
                                  showPopupMakeDefault();
                                },
                                child: Text(
                                    AppLocalizations.of(context)
                                        .translate('make_default'),
                                    style: TextStyle(color: SOFT_BLUE)),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            EditPaymentMethodPage()));
                              },
                              child: Text(
                                  AppLocalizations.of(context)
                                      .translate('edit'),
                                  style: TextStyle(color: SOFT_BLUE)),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 8),
                              child: GestureDetector(
                                onTap: () {
                                  _showPopupDeletePayment(2);
                                },
                                child: Text(
                                    AppLocalizations.of(context)
                                        .translate('delete'),
                                    style: TextStyle(color: SOFT_BLUE)),
                              ),
                            )
                          ],
                        )),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 32),
              child: ButtonTheme(
                height: 40,
                child: FlatButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AddPaymentMethodPage()));
                    },
                    padding: EdgeInsets.all(0),
                    splashColor: Colors.grey[50],
                    color: Colors.transparent,
                    highlightColor: Colors.grey[50],
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    child: Text(
                      AppLocalizations.of(context).translate('add_a_card'),
                      style: TextStyle(
                          color: SOFT_BLUE,
                          fontWeight: FontWeight.bold,
                          fontSize: 13),
                      textAlign: TextAlign.center,
                    ),
                    shape: new RoundedRectangleBorder(
                      side: BorderSide(color: SOFT_BLUE, width: 1.0),
                      borderRadius: new BorderRadius.circular(5.0),
                    )),
              ),
            )
          ],
        ));
  }

  void showPopupMakeDefault() {
    // set up the buttons
    Widget cancelButton = FlatButton(
      child: Text(AppLocalizations.of(context).translate('no'),
          style: TextStyle(color: SOFT_BLUE)),
      onPressed: () {
        Navigator.pop(context);
      },
    );
    Widget continueButton = FlatButton(
      child: Text(AppLocalizations.of(context).translate('yes'),
          style: TextStyle(color: SOFT_BLUE)),
      onPressed: () {
        Navigator.pop(context);
        _globalFunction.startLoading(
            context, AppLocalizations.of(context).translate('success'), 0);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      title: Text(
        AppLocalizations.of(context).translate('make_default'),
        style: TextStyle(fontSize: 18),
      ),
      content: Text(
          AppLocalizations.of(context).translate('default_payment_message'),
          style: TextStyle(fontSize: 13, color: BLACK_GREY)),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  void _showPopupDeletePayment(int index) {
    // set up the buttons
    Widget cancelButton = FlatButton(
      child: Text(AppLocalizations.of(context).translate('no'),
          style: TextStyle(color: SOFT_BLUE)),
      onPressed: () {
        Navigator.pop(context);
      },
    );
    Widget continueButton = FlatButton(
      child: Text(AppLocalizations.of(context).translate('yes'),
          style: TextStyle(color: SOFT_BLUE)),
      onPressed: () {
        Navigator.pop(context);
        if (index == 0) {
          Fluttertoast.showToast(
              msg: AppLocalizations.of(context)
                  .translate('default_payment_message2'),
              toastLength: Toast.LENGTH_LONG);
        } else {
          _globalFunction.startLoading(
              context,
              AppLocalizations.of(context)
                  .translate('delete_payment_method_success'),
              0);
        }
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      title: Text(
        AppLocalizations.of(context).translate('delete_payment_method'),
        style: TextStyle(fontSize: 18),
      ),
      content: Text(
          AppLocalizations.of(context)
              .translate('delete_payment_method_message'),
          style: TextStyle(fontSize: 13, color: BLACK_GREY)),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
