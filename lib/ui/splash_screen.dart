/*
This is splash screen page

install plugin in pubspec.yaml
- flutter_statusbarcolor => to change status bar color and navigation status bar color (at the very top of the screen) (https://pub.dev/packages/flutter_statusbarcolor)

Don't forget to add all images and sound used in this pages at the pubspec.yaml
 */

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
//import 'package:ijshopflutter/config/constants.dart';
import 'package:ijshopflutter/ui/authentication/signin/signin.dart';
import 'package:ijshopflutter/ui/onboarding.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreenPage extends StatefulWidget {
  @override
  _SplashScreenPageState createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  Timer _timer;
  int _second = 3; // set timer for 3 second and then direct to next page

  void _startTimer(StatefulWidget nextPage) {
    const period = const Duration(seconds: 1);
    _timer = Timer.periodic(period, (timer) {
      setState(() {
        _second--;
      });
      if (_second == 0) {
        _cancelFlashsaleTimer();
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => nextPage),
            (Route<dynamic> route) => false);
      }
    });
  }

  void _cancelFlashsaleTimer() {
    if (_timer != null) {
      _timer.cancel();
      _timer = null;
    }
  }

  Future<bool> _getOnboarding() async {
    final SharedPreferences _pref = await SharedPreferences.getInstance();
    bool onBoarding = _pref.getBool('onBoarding') ?? true;
    return onBoarding;
  }

  @override
  void initState() {
    // set status bar color to transparent
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
      ),
    );
    FlutterStatusbarcolor.setStatusBarWhiteForeground(false);

    StatefulWidget nextPage = OnboardingPage();
    _getOnboarding().then((val) {
      if (val == false) {
        nextPage = SigninPage();
      }

      if (_second != 0) {
        _startTimer(nextPage);
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _cancelFlashsaleTimer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/logo_light.png', height: 150),
          ],
        ),
      ),
    ));
  }
}
