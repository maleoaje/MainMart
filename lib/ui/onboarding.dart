/*
This is onboarding page

install plugin in pubspec.yaml
- flutter_statusbarcolor => to change status bar color and navigation status bar color (at the very top of the screen) (https://pub.dev/packages/flutter_statusbarcolor)

Don't forget to add all images and sound used in this pages at the pubspec.yaml
 */

import 'package:flutter/material.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:ijshopflutter/config/constants.dart';
import 'package:ijshopflutter/library/flutter_overboard/overboard.dart';
import 'package:ijshopflutter/library/flutter_overboard/page_model.dart';
import 'package:ijshopflutter/ui/authentication/signin/signin.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnboardingPage extends StatefulWidget {
  @override
  _OnboardingPageState createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage>
    with TickerProviderStateMixin, WidgetsBindingObserver {
  // create each page of onBoard here
  final _pageList = [
    PageModel(
        color: Colors.white,
        imageAssetPath: 'assets/images/onboarding/search_product.gif',
        title: 'Choose Product',
        body: 'Search and browse the product you want to buy at MainMart',
        doAnimateImage: true),
    PageModel(
        color: Colors.white,
        imageFromUrl: GLOBAL_URL + '/assets/images/onboarding/cart.png',
        title: 'Add to Cart and Pay',
        body:
            'Add the product to shopping cart, choose delivery and then pay with your preferences payment',
        doAnimateImage: true),
    PageModel(
        color: Colors.white,
        imageFromUrl: GLOBAL_URL + '/assets/images/onboarding/delivery.png',
        title: 'Delivery',
        body:
            'Wait until the product that has been purchased comes to the house',
        doAnimateImage: true),
  ];

  @override
  void initState() {
    // start recording lifecycle
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  // this is the function to do something when the apps is switch
  @override
  didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      FlutterStatusbarcolor.setStatusBarWhiteForeground(false);
    }
    super.didChangeAppLifecycleState(state);
  }

  // if user click finish, you won't see this page again until you clear your data of this apps in your phone setting
  void _finishOnboarding() async {
    final SharedPreferences _pref = await SharedPreferences.getInstance();
    await _pref.setBool('onBoarding', false);
  }

  @override
  void dispose() {
    // stop recording lifecycle
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: OverBoard(
      pages: _pageList,
      showBullets: true,
      finishCallback: () {
        _finishOnboarding();

        // after you click finish, direct to signin page
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => SigninPage()),
            (Route<dynamic> route) => false);
      },
    ));
  }
}
