/*
This is delivery estimated page
 */

import 'package:flutter/material.dart';
import 'package:ijshopflutter/config/constants.dart';
import 'package:ijshopflutter/config/global_style.dart';
import 'package:ijshopflutter/ui/reuseable/app_localizations.dart';

class DeliveryEstimatedPage extends StatefulWidget {
  @override
  _DeliveryEstimatedPageState createState() => _DeliveryEstimatedPageState();
}

class _DeliveryEstimatedPageState extends State<DeliveryEstimatedPage> {
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
            AppLocalizations.of(context).translate('delivery_estimated'),
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
          children: [_createLocationInformation(), _createCourierInformation()],
        ));
  }

  Widget _createLocationInformation() {
    return Container(
      padding: EdgeInsets.all(16),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(AppLocalizations.of(context).translate('location'),
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          SizedBox(
            height: 16,
          ),
          Text(AppLocalizations.of(context).translate('delivery_from') + ' :',
              style: TextStyle(color: SOFT_GREY, fontSize: 14)),
          SizedBox(
            height: 4,
          ),
          Text(AppLocalizations.of(context).translate('delivery_to') + ' :',
              style: TextStyle(color: SOFT_GREY, fontSize: 14)),
          SizedBox(
            height: 4,
          ),
        ],
      ),
    );
  }

  Widget _createCourierInformation() {
    return Container(
      margin: EdgeInsets.only(top: 16),
      padding: EdgeInsets.all(16),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(AppLocalizations.of(context).translate('courier'),
              style: GlobalStyle.chooseCourier),
          SizedBox(
            height: 8,
          ),
          Text(AppLocalizations.of(context).translate('courier_notes'),
              style: TextStyle(color: SOFT_GREY, fontSize: 14)),
          Divider(
            height: 32,
            color: Colors.grey[400],
          ),
        ],
      ),
    );
  }
}
