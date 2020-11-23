/*
This is notification page

include file in reuseable/shimmer_loading.dart to use shimmer loading

install plugin in pubspec.yaml
- flutter_statusbarcolor => to change status bar color and navigation status bar color (at the very top of the screen) (https://pub.dev/packages/flutter_statusbarcolor)

Don't forget to add all images and sound used in this pages at the pubspec.yaml
 */

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:ijshopflutter/config/constants.dart';
import 'package:ijshopflutter/config/global_style.dart';
import 'package:ijshopflutter/config/static_variable.dart';
//import 'package:ijshopflutter/ui/account/order/order_status.dart';
//import 'package:ijshopflutter/ui/home/flashsale.dart';
//import 'package:ijshopflutter/ui/reuseable/app_localizations.dart';
import 'package:ijshopflutter/ui/reuseable/shimmer_loading.dart';

class NotificationPage extends StatefulWidget {
  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  final _shimmerLoading = ShimmerLoading();

  bool _fromWhiteStatusBarForeground = false;

  bool _loading = true;
  Timer _timerLoadingDummy;

  @override
  void initState() {
    // detect last status bar color from previous page
    _fromWhiteStatusBarForeground = StaticVariable.useWhiteStatusBarForeground;

    // set status bar color to white and status navigation bar color to dark (At the very top of page)
    StaticVariable.useWhiteStatusBarForeground = false;
    FlutterStatusbarcolor.setStatusBarWhiteForeground(false);

    // this timer function is just for demo, so after 2 second, the shimmer loading will disappear and show the content
    _timerLoadingDummy = Timer(Duration(milliseconds: 200), () {
      setState(() {
        _loading = false;
      });
    });

    super.initState();
  }

  @override
  void dispose() {
    _timerLoadingDummy?.cancel();

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
            'Notification',
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
        body: WillPopScope(
          onWillPop: () {
            Navigator.pop(context);
            // check the previous status bar color and when the user click back button, set status bar color like the the previous page
            if (_fromWhiteStatusBarForeground == true) {
              StaticVariable.useWhiteStatusBarForeground = true;
              FlutterStatusbarcolor.setStatusBarWhiteForeground(true);
            } else {
              StaticVariable.useWhiteStatusBarForeground = false;
              FlutterStatusbarcolor.setStatusBarWhiteForeground(false);
            }
            return Future.value(true);
          },
          child: Container(
              child: (_loading == true)
                  ? _shimmerLoading.buildShimmerContent()
                  : ListView(children: <Widget>[])),
        ));
  }

  Widget _createItem(
      {String notifDate,
      String notifTitle,
      String notifMessage,
      StatefulWidget page}) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        if (page != null) {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => page));
        }
      },
      child: Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                margin: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(notifTitle,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: CHARCOAL)),
                    SizedBox(
                      height: 4,
                    ),
                    Text(notifDate,
                        style:
                            TextStyle(color: Colors.grey[400], fontSize: 11)),
                    SizedBox(
                      height: 8,
                    ),
                    Text(notifMessage, style: TextStyle(color: BLACK_GREY)),
                  ],
                )),
            Divider(
              height: 1,
              color: Colors.grey[400],
            ),
          ],
        ),
      ),
    );
  }
}
