/*
This is about page

install plugin in pubspec.yaml
- package_info (https://pub.dev/packages/package_info)

Don't forget to add all images and sound used in this pages at the pubspec.yaml
 */

import 'package:flutter/material.dart';
import 'package:ijshopflutter/config/constants.dart';
import 'package:ijshopflutter/config/global_style.dart';
import 'package:ijshopflutter/ui/reuseable/app_localizations.dart';
import 'package:package_info/package_info.dart';

class AboutPage extends StatefulWidget {
  @override
  _AboutPageState createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  String _version = '1.0.0';

  Future<void> _getSystemDevice() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    setState(() {
      _version = packageInfo.version;
    });
  }

  @override
  void initState() {
    _getSystemDevice();
    super.initState();
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
            AppLocalizations.of(context).translate('about'),
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Center(
                  child:
                      Image.asset('assets/images/logo_light.png', height: 140)),
              SizedBox(
                height: 20,
              ),
              Text(
                AppLocalizations.of(context).translate('app_version'),
                style: TextStyle(fontSize: 14, color: CHARCOAL),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                _version,
                style: TextStyle(fontSize: 14, color: CHARCOAL),
              ),
            ],
          ),
        ));
  }
}
