/*
This is payment page
 */

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:ijshopflutter/config/constants.dart';
import 'package:ijshopflutter/config/global_style.dart';
import 'package:ijshopflutter/config/static_variable.dart';
import 'package:ijshopflutter/ui/bottom_navigation_bar.dart';
import 'package:ijshopflutter/ui/reuseable/app_localizations.dart';

class PaymentPage extends StatefulWidget {
  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
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
            AppLocalizations.of(context).translate('payment'),
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
          children: [
            Container(
              padding: EdgeInsets.all(16),
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(AppLocalizations.of(context).translate('summary'),
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  SizedBox(
                    height: 16,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Text(
                            AppLocalizations.of(context)
                                .translate('total_payment'),
                            style: TextStyle(color: CHARCOAL, fontSize: 14)),
                      ),
                      Container(
                        child:
                            Text('\₦74', style: GlobalStyle.paymentTotalPrice),
                      )
                    ],
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 12),
              padding: EdgeInsets.all(16),
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                          AppLocalizations.of(context)
                              .translate('payment_method'),
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold)),
                      GestureDetector(
                        onTap: () {
                          showModalBottomSheet<void>(
                            context: context,
                            builder: (BuildContext context) {
                              return _createChoosePayment();
                            },
                          );
                        },
                        child: Text(
                            AppLocalizations.of(context).translate('change'),
                            style:
                                TextStyle(color: PRIMARY_COLOR, fontSize: 14)),
                      ),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 16),
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
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.all(32),
              child: SizedBox(
                  width: double.maxFinite,
                  child: RaisedButton(
                    elevation: 2,
                    shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(3.0),
                        side: BorderSide(color: PRIMARY_COLOR)),
                    onPressed: () {
                      showLoading(AppLocalizations.of(context)
                          .translate('payment_success'));
                    },
                    padding: EdgeInsets.fromLTRB(0, 12, 0, 12),
                    color: PRIMARY_COLOR,
                    child: Text(
                      AppLocalizations.of(context).translate('pay'),
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                  )),
            )
          ],
        ));
  }

  Widget _createChoosePayment() {
    return StatefulBuilder(
        builder: (BuildContext context, StateSetter mystate) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              margin: EdgeInsets.only(top: 12, bottom: 12),
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                  color: Colors.grey[500],
                  borderRadius: BorderRadius.circular(10)),
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(16, 8, 16, 8),
            child: Text(
                AppLocalizations.of(context).translate('payment_method'),
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          ),
          Flexible(
            child: ListView(
              padding: EdgeInsets.all(16),
              children: <Widget>[
                GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: () {
                    Navigator.pop(context);
                  },
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
                      Text(AppLocalizations.of(context)
                          .translate('visa_card_ending_in1'))
                    ],
                  ),
                ),
                Divider(
                  height: 32,
                  color: Colors.grey[400],
                ),
                GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: () {
                    Navigator.pop(context);
                  },
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
                        child: Image.asset('assets/images/mastercard.png',
                            height: 20),
                      ),
                      Text(AppLocalizations.of(context)
                          .translate('master_card_ending_in'))
                    ],
                  ),
                ),
                Divider(
                  height: 32,
                  color: Colors.grey[400],
                ),
                GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: () {
                    Navigator.pop(context);
                  },
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
                      Text(AppLocalizations.of(context)
                          .translate('visa_card_ending_in2'))
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      );
    });
  }

  void showLoading(String textMessage) {
    _progressDialog(context);
    Timer(Duration(seconds: 2), () {
      Navigator.pop(context);
      _buildShowDialog(context, textMessage);
    });
  }

  Future _progressDialog(BuildContext context) {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return WillPopScope(
            onWillPop: () {
              return null;
            },
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        });
  }

  Future _buildShowDialog(BuildContext context, String textMessage) {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return WillPopScope(
            onWillPop: () {
              return null;
            },
            child: Dialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)), //this right here
              child: Container(
                padding: EdgeInsets.all(20),
                margin: EdgeInsets.fromLTRB(40, 20, 40, 20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(
                      textMessage,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 14, color: BLACK_GREY),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      child: RaisedButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0),
                            side: BorderSide(color: PRIMARY_COLOR)),
                        onPressed: () {
                          StaticVariable.useWhiteStatusBarForeground = true;
                          Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                  builder: (context) =>
                                      BottomNavigationBarPage()),
                              (Route<dynamic> route) => false);
                        },
                        padding: EdgeInsets.fromLTRB(0, 12, 0, 12),
                        color: PRIMARY_COLOR,
                        textColor: Colors.white,
                        child: Text(
                          AppLocalizations.of(context)
                              .translate('ok')
                              .toUpperCase(),
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }
}
