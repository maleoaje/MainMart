/*
This is coupon detail page

include file in reuseable/global_function.dart to call function from GlobalFunction
include file in reuseable/shimmer_loading.dart to use shimmer loading
include file in model/home/coupon_model.dart to get couponData

install plugin in pubspec.yaml
- fluttertoast => to show toast (https://pub.dev/packages/fluttertoast)
- flutter_statusbarcolor => to change status bar color and navigation status bar color (at the very top of the screen) (https://pub.dev/packages/flutter_statusbarcolor)
 */

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ijshopflutter/bloc/home/coupon/bloc.dart';
import 'package:ijshopflutter/config/constants.dart';
import 'package:ijshopflutter/config/global_style.dart';
import 'package:ijshopflutter/config/static_variable.dart';
import 'package:ijshopflutter/model/home/coupon_model.dart';
import 'package:ijshopflutter/ui/reuseable/app_localizations.dart';
import 'package:ijshopflutter/ui/reuseable/global_function.dart';
import 'package:ijshopflutter/ui/reuseable/shimmer_loading.dart';

class CouponDetailPage extends StatefulWidget {
  final int couponId;
  final bool fromWhite;

  const CouponDetailPage({Key key, this.couponId = 0, this.fromWhite = false})
      : super(key: key);

  @override
  _CouponDetailPageState createState() => _CouponDetailPageState();
}

class _CouponDetailPageState extends State<CouponDetailPage> {
  // initialize global function and shimmer loading
  final _globalFunction = GlobalFunction();
  final _shimmerLoading = ShimmerLoading();

  CouponBloc _couponBloc;

  CouponModel couponData;
  CancelToken apiToken = CancelToken(); // used to cancel fetch data from API

  bool _fromWhiteStatusBarForeground = false;

  @override
  void initState() {
    // get data when initState
    _couponBloc = BlocProvider.of<CouponBloc>(context);
    _couponBloc.add(GetCouponDetail(
        sessionId: SESSION_ID, id: widget.couponId, apiToken: apiToken));

    // detect last status bar color from previous page
    _fromWhiteStatusBarForeground = widget.fromWhite;
    super.initState();
  }

  @override
  void dispose() {
    apiToken.cancel("cancelled"); // cancel fetch data from API
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
            AppLocalizations.of(context).translate('coupon_detail'),
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
        body: BlocListener<CouponBloc, CouponState>(
          listener: (context, state) {
            if (state is CouponDetailError) {
              _globalFunction.showToast(
                  type: 'error', message: state.errorMessage);
            }
            if (state is GetCouponDetailSuccess) {
              couponData = state.couponData;
            }
          },
          child: BlocBuilder<CouponBloc, CouponState>(
            builder: (context, state) {
              if (state is CouponDetailError) {
                return Container(
                    child: Center(
                        child: Text(ERROR_OCCURED,
                            style:
                                TextStyle(fontSize: 14, color: BLACK_GREY))));
              } else {
                if (couponData == null) {
                  return _shimmerLoading.buildShimmerContent();
                } else {
                  return ListView(
                    padding: EdgeInsets.fromLTRB(24, 20, 24, 24),
                    children: [
                      _buildCouponCard(couponData),
                      Container(
                        margin: EdgeInsets.only(top: 24),
                        child: Text(
                            AppLocalizations.of(context)
                                .translate('terms_conditions'),
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold)),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 12),
                        child: Text(couponData.term),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 12),
                        child: SizedBox(
                            width: double.maxFinite,
                            child: RaisedButton(
                              elevation: 2,
                              shape: new RoundedRectangleBorder(
                                  borderRadius: new BorderRadius.circular(3.0),
                                  side: BorderSide(color: PRIMARY_COLOR)),
                              onPressed: () {
                                Fluttertoast.showToast(
                                    msg: AppLocalizations.of(context)
                                        .translate('coupon_applied'),
                                    toastLength: Toast.LENGTH_LONG);
                                Navigator.pop(context);
                                Navigator.pop(context);

                                // check the previous status bar color and when the user click use button, set status bar color like the the previous page
                                if (_fromWhiteStatusBarForeground == true) {
                                  StaticVariable.useWhiteStatusBarForeground =
                                      true;
                                  FlutterStatusbarcolor
                                      .setStatusBarWhiteForeground(true);
                                } else {
                                  StaticVariable.useWhiteStatusBarForeground =
                                      false;
                                  FlutterStatusbarcolor
                                      .setStatusBarWhiteForeground(false);
                                }
                              },
                              padding: EdgeInsets.fromLTRB(0, 12, 0, 12),
                              color: PRIMARY_COLOR,
                              child: Text(
                                AppLocalizations.of(context).translate('use'),
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                                textAlign: TextAlign.center,
                              ),
                            )),
                      ),
                    ],
                  );
                }
              }
            },
          ),
        ));
  }

  Widget _buildCouponCard(CouponModel couponData) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4),
      ),
      elevation: 2,
      color: Colors.white,
      child: Container(
        padding: EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(couponData.name,
                style: GlobalStyle.couponName.copyWith(fontSize: 18)),
            SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  margin: EdgeInsets.only(top: 5),
                  padding: EdgeInsets.fromLTRB(8, 4, 8, 4),
                  decoration: BoxDecoration(
                      color: SOFT_BLUE,
                      borderRadius: BorderRadius.circular(5)), //
                  child: Text(
                      AppLocalizations.of(context).translate('limited_offer'),
                      style: GlobalStyle.couponLimitedOffer),
                ),
                Row(
                  children: [
                    GlobalStyle.iconTime,
                    SizedBox(
                      width: 4,
                    ),
                    Text(
                        AppLocalizations.of(context).translate('expiring_in') +
                            ' ' +
                            couponData.day +
                            ' ' +
                            AppLocalizations.of(context).translate('days'),
                        style: GlobalStyle.couponExpired),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
