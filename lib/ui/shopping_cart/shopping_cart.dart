/*
This is shopping cart page

include file in reuseable/global_function.dart to call function from GlobalFunction
include file in reuseable/global_widget.dart to call function from GlobalWidget
include file in model/shopping_cart/shopping_cart_model.dart to get shoppingCartData
include file in reuseable/cache_image_network.dart to use cache image network

install plugin in pubspec.yaml
- fluttertoast => to show toast (https://pub.dev/packages/fluttertoast)

Don't forget to add all images and sound used in this pages at the pubspec.yaml
 */

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ijshopflutter/bloc/shopping_cart/bloc.dart';
import 'package:ijshopflutter/config/constants.dart';
import 'package:ijshopflutter/config/global_style.dart';
import 'package:ijshopflutter/model/shopping_cart/shopping_cart_model.dart';
import 'package:ijshopflutter/ui/home/coupon.dart';
import 'package:ijshopflutter/ui/reuseable/app_localizations.dart';
import 'package:ijshopflutter/ui/reuseable/global_function.dart';
import 'package:ijshopflutter/ui/reuseable/global_widget.dart';
import 'package:ijshopflutter/ui/shopping_cart/delivery.dart';
import 'package:ijshopflutter/ui/general/product_detail/product_detail.dart';
import 'package:ijshopflutter/ui/reuseable/cache_image_network.dart';

class ShoppingCartPage extends StatefulWidget {
  @override
  _ShoppingCartPageState createState() => _ShoppingCartPageState();
}

class _ShoppingCartPageState extends State<ShoppingCartPage> {
  // initialize global function and global widget
  final _globalFunction = GlobalFunction();
  final _globalWidget = GlobalWidget();

  List<ShoppingCartModel> shoppingCartData = List();

  bool _lastData = false;

  double _totalPrice = 0;

  @override
  void initState() {
    // get data when initState

    super.initState();
  }

  @override
  void dispose() {
// cancel fetch data from API
    super.dispose();
  }

  void _countTotalPrice() {
    _totalPrice = 0;
    for (int i = 0; i < shoppingCartData.length; i++) {
      _totalPrice += shoppingCartData[i].price * shoppingCartData[i].qty;
    }
  }

  @override
  Widget build(BuildContext context) {
    final double boxImageSize = (MediaQuery.of(context).size.width / 5);

    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: Colors.white, //change your color here
          ),
          elevation: 3,
          title: Text(
            AppLocalizations.of(context).translate('shopping_cart'),
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: PRIMARY_COLOR,
          bottom: PreferredSize(
              child: Container(
                color: Colors.grey[100],
                height: 1.0,
              ),
              preferredSize: Size.fromHeight(1.0)),
        ),
        body: FlatButton(
          shape: new RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(4),
          ),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        DeliveryPage(shoppingCartData: shoppingCartData)));
          },
          color: PRIMARY_COLOR,
          child: Text(
            'Proceed',
            style: TextStyle(
                fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
            textAlign: TextAlign.center,
          ),
        ));
  }
}
