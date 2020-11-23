/*
This is the main navigation
In this pages we used WidgetsBindingObserver
This function is used to do something when you switch to another apps and enter the apps again

install plugin in pubspec.yaml
- fluttertoast => to show toast (https://pub.dev/packages/fluttertoast)
- flutter_statusbarcolor => to change status bar color and navigation status bar color (at the very top of the screen) (https://pub.dev/packages/flutter_statusbarcolor)

Don't forget to add all images and sound used in this pages at the pubspec.yaml
 */

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ijshopflutter/config/constants.dart';
import 'package:ijshopflutter/config/static_variable.dart';
import 'package:ijshopflutter/ui/account/account.dart';
import 'package:ijshopflutter/ui/home/home.dart';
import 'package:ijshopflutter/ui/reuseable/app_localizations.dart';
import 'package:ijshopflutter/ui/shopping_cart/shopping_cart.dart';
import 'package:ijshopflutter/ui/wishlist/wishlist.dart';

class BottomNavigationBarPage extends StatefulWidget {
  @override
  _BottomNavigationBarPageState createState() =>
      _BottomNavigationBarPageState();
}

class _BottomNavigationBarPageState extends State<BottomNavigationBarPage>
    with SingleTickerProviderStateMixin, WidgetsBindingObserver {
  PageController _pageController;
  int _currentIndex = 0;

  // Pages if you click bottom navigation
  final List<Widget> _contentPages = <Widget>[
    HomePage(),
    WishlistPage(),
    ShoppingCartPage(),
    AccountPage(),
  ];

  @override
  void initState() {
    // start recording lifecycle
    WidgetsBinding.instance.addObserver(this);

    // set status bar navigation color to white (at the top of the pages)
    StaticVariable.useWhiteStatusBarForeground = true;
    FlutterStatusbarcolor.setStatusBarWhiteForeground(true);

    // set status bar color to transparent
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
      ),
    );

    // set initial pages for navigation to home page
    _pageController = PageController(initialPage: 0);
    _pageController.addListener(_handleTabSelection);
    super.initState();
  }

  void _handleTabSelection() {
    setState(() {});
  }

  @override
  void dispose() {
    // stop recording lifecycle
    WidgetsBinding.instance.removeObserver(this);
    _pageController.dispose();
    super.dispose();
  }

  // this is the function to do something when the apps is switch
  @override
  didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      if (StaticVariable.useWhiteStatusBarForeground != null) {
        FlutterStatusbarcolor.setStatusBarWhiteForeground(
            StaticVariable.useWhiteStatusBarForeground);
      }
    }
    super.didChangeAppLifecycleState(state);
  }

  // this function is used for exit the application, user must click back button two times
  DateTime _currentBackPressTime;
  Future<bool> _onWillPop() {
    DateTime now = DateTime.now();
    if (_currentBackPressTime == null ||
        now.difference(_currentBackPressTime) > Duration(seconds: 2)) {
      _currentBackPressTime = now;
      Fluttertoast.showToast(
          msg: AppLocalizations.of(context)
              .translate('press_back_again_to_exit'),
          toastLength: Toast.LENGTH_LONG);
      return Future.value(false);
    }
    return Future.value(true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        onWillPop: _onWillPop,
        child: PageView(
          controller: _pageController,
          physics: NeverScrollableScrollPhysics(),
          children: _contentPages.map((Widget content) {
            return content;
          }).toList(),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        onTap: (value) {
          _currentIndex = value;
          _pageController.jumpToPage(value);
          if (_currentIndex == 0) {
            /*
            if nav bar change to home,
            check if the home page is scrolling and the status bar color is changed
            */
            if (StaticVariable.homeIsScroll) {
              // if scroll then change status bar color to dark
              StaticVariable.useWhiteStatusBarForeground = false;
              FlutterStatusbarcolor.setStatusBarWhiteForeground(false);
            } else {
              // if not scroll then change status bar color to white
              StaticVariable.useWhiteStatusBarForeground = true;
              FlutterStatusbarcolor.setStatusBarWhiteForeground(true);
            }
          } else if (_currentIndex == 1) {
            // if nav bar change to wishlist then set status bar color to dark
            StaticVariable.useWhiteStatusBarForeground = false;
            FlutterStatusbarcolor.setStatusBarWhiteForeground(false);
          } else if (_currentIndex == 2) {
            // if nav bar change to wishlist then set status bar color to dark
            StaticVariable.useWhiteStatusBarForeground = false;
            FlutterStatusbarcolor.setStatusBarWhiteForeground(false);
          } else if (_currentIndex == 3) {
            // if nav bar change to wishlist then set status bar color to dark
            StaticVariable.useWhiteStatusBarForeground = false;
            FlutterStatusbarcolor.setStatusBarWhiteForeground(false);
          }
          // this unfocus is to prevent show keyboard in the wishlist page when focus on search text field
          FocusScope.of(context).unfocus();
        },
        selectedFontSize: 8,
        unselectedFontSize: 8,
        iconSize: 28,
        items: [
          BottomNavigationBarItem(
              // ignore: deprecated_member_use
              title: Text(AppLocalizations.of(context).translate('home'),
                  style: TextStyle(
                      color: _currentIndex == 0 ? PRIMARY_COLOR : SOFT_GREY,
                      fontWeight: FontWeight.bold)),
              icon: Icon(Icons.home,
                  color: _currentIndex == 0 ? PRIMARY_COLOR : SOFT_GREY)),
          BottomNavigationBarItem(
              // ignore: deprecated_member_use
              title: Text('Categories',
                  style: TextStyle(
                      color: _currentIndex == 1 ? ASSENT_COLOR : SOFT_GREY,
                      fontWeight: FontWeight.bold)),
              icon: Icon(Icons.category,
                  color: _currentIndex == 1 ? ASSENT_COLOR : SOFT_GREY)),
          BottomNavigationBarItem(
              // ignore: deprecated_member_use
              title: Text(AppLocalizations.of(context).translate('cart'),
                  style: TextStyle(
                      color: _currentIndex == 2 ? PRIMARY_COLOR : SOFT_GREY,
                      fontWeight: FontWeight.bold)),
              icon: Icon(Icons.shopping_cart,
                  color: _currentIndex == 2 ? PRIMARY_COLOR : SOFT_GREY)),
          BottomNavigationBarItem(
              // ignore: deprecated_member_use
              title: Text(AppLocalizations.of(context).translate('account'),
                  style: TextStyle(
                      color: _currentIndex == 3 ? PRIMARY_COLOR : SOFT_GREY,
                      fontWeight: FontWeight.bold)),
              icon: Icon(Icons.person_outline,
                  color: _currentIndex == 3 ? PRIMARY_COLOR : SOFT_GREY)),
        ],
      ),
    );
  }
}
