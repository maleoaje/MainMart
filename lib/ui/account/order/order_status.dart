/*
This is order status page
 */

import 'package:flutter/material.dart';
import 'package:ijshopflutter/config/constants.dart';
import 'package:ijshopflutter/config/global_style.dart';
import 'package:ijshopflutter/ui/reuseable/app_localizations.dart';

class OrderStatusPage extends StatefulWidget {
  @override
  _OrderStatusPageState createState() => _OrderStatusPageState();
}

class _OrderStatusPageState extends State<OrderStatusPage> {
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
            AppLocalizations.of(context).translate('order_status'),
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
        body: Container(
          child: ListView(
            padding: EdgeInsets.all(32),
            children: [
              _createPathTop('11 Sep 2019 08:40', AppLocalizations.of(context).translate('order_completed'), AppLocalizations.of(context).translate('order_completed_message')),
              _createPath('11 Sep 2019 08:39', AppLocalizations.of(context).translate('order_arrived'), AppLocalizations.of(context).translate('order_arrived_message')),
              _createPath('9 Sep 2019 14:12', AppLocalizations.of(context).translate('order_sent'), AppLocalizations.of(context).translate('order_sent_message')),
              _createPath('9 Sep 2019 14:12', AppLocalizations.of(context).translate('ready_to_pickup'), AppLocalizations.of(context).translate('ready_to_pickup_message')),
              _createPath('9 Sep 2019 12:12', AppLocalizations.of(context).translate('order_processed'), AppLocalizations.of(context).translate('order_processed_message')),
              _createPath('9 Sep 2019 11:52', AppLocalizations.of(context).translate('payment_received'), AppLocalizations.of(context).translate('payment_received_message')),
              _createPath('9 Sep 2019 11:32', AppLocalizations.of(context).translate('waiting_for_payment'), AppLocalizations.of(context).translate('waiting_for_payment_message')),
              _createPathDown('9 Sep 2019 11:32', AppLocalizations.of(context).translate('order_placed'), AppLocalizations.of(context).translate('order_placed_message')),
            ],
          ),
        )
    );
  }

  Widget _createPathTop(String date, String orderStatus, String orderDescription){
    return Stack(
      children: [
        Container(
          margin: EdgeInsets.only(top: 0),
          width: 16,
          height: 16,
          decoration: new BoxDecoration(
            shape: BoxShape.circle,// You can use like this way or like the below line
            //borderRadius: new BorderRadius.circular(30.0),
            color: PRIMARY_COLOR,
          ),
        ),
        IntrinsicHeight(
          child: Row(
            children: <Widget>[
              Container(
                margin:EdgeInsets.only(left: 7.5, right: 7.5),
                child: Container(
                  width: 1,
                  color: PRIMARY_COLOR,
                ),
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(left: 32, right: 32),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(orderStatus, style: TextStyle(
                          fontWeight: FontWeight.bold, color: CHARCOAL
                      )),
                      SizedBox(
                        height: 4,
                      ),
                      Text(date, style: TextStyle(
                          color: Colors.grey[400], fontSize: 11
                      )),
                      SizedBox(
                        height: 8,
                      ),
                      Text(orderDescription, style: TextStyle(
                          color: BLACK_GREY
                      )),
                      SizedBox(
                        height: 24,
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget _createPath(String date, String orderStatus, String orderDescription){
    return Stack(
      children: [
        Container(
          margin: EdgeInsets.only(top: 0),
          width: 16,
          height: 16,
          decoration: new BoxDecoration(
            shape: BoxShape.circle,// You can use like this way or like the below line
            //borderRadius: new BorderRadius.circular(30.0),
            color: Colors.grey[400],
          ),
        ),
        IntrinsicHeight(
          child: Row(
            children: <Widget>[
              Container(
                margin:EdgeInsets.only(left: 7.5, right: 7.5),
                child: Container(
                  width: 1,
                  color: Colors.grey[400],
                ),
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(left: 32, right: 32),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(orderStatus, style: TextStyle(
                          fontWeight: FontWeight.bold, color: CHARCOAL
                      )),
                      SizedBox(
                        height: 4,
                      ),
                      Text(date, style: TextStyle(
                          color: Colors.grey[400], fontSize: 11
                      )),
                      SizedBox(
                        height: 8,
                      ),
                      Text(orderDescription, style: TextStyle(
                          color: BLACK_GREY
                      )),
                      SizedBox(
                        height: 24,
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget _createPathDown(String date, String orderStatus, String orderDescription){
    return Stack(
      children: [
        Container(
          margin: EdgeInsets.only(top: 0),
          width: 16,
          height: 16,
          decoration: new BoxDecoration(
            shape: BoxShape.circle,// You can use like this way or like the below line
            //borderRadius: new BorderRadius.circular(30.0),
            color: Colors.grey[400],
          ),
        ),
        IntrinsicHeight(
          child: Row(
            children: <Widget>[
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(left: 48, right: 48),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(orderStatus, style: TextStyle(
                          fontWeight: FontWeight.bold, color: CHARCOAL
                      )),
                      SizedBox(
                        height: 4,
                      ),
                      Text(date, style: TextStyle(
                          color: Colors.grey[400], fontSize: 11
                      )),
                      SizedBox(
                        height: 8,
                      ),
                      Text(orderDescription, style: TextStyle(
                          color: BLACK_GREY
                      )),
                    ],
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
