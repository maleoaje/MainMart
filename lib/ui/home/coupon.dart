/*
This is coupon page

include file in reuseable/global_function.dart to call function from GlobalFunction
include file in reuseable/global_widget.dart to call function from GlobalWidget
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
import 'package:ijshopflutter/ui/home/coupon_detail.dart';
import 'package:ijshopflutter/ui/reuseable/app_localizations.dart';
import 'package:ijshopflutter/ui/reuseable/global_function.dart';
import 'package:ijshopflutter/ui/reuseable/global_widget.dart';
import 'package:ijshopflutter/ui/reuseable/shimmer_loading.dart';

class CouponPage extends StatefulWidget {
  @override
  _CouponPageState createState() => _CouponPageState();
}

class _CouponPageState extends State<CouponPage> {
  // initialize global function, global widget and shimmer loading
  final _globalFunction = GlobalFunction();
  final _globalWidget = GlobalWidget();
  final _shimmerLoading = ShimmerLoading();

  List<CouponModel> couponData = List();

  CouponBloc _couponBloc;
  int _apiPage = 0;
  ScrollController _scrollController = ScrollController();
  bool _lastData = false;
  bool _processApi = false;

  CancelToken apiToken = CancelToken(); // used to cancel fetch data from API

  bool _fromWhiteStatusBarForeground = false;

  TextEditingController _etSearch = TextEditingController();

  @override
  void initState() {
    // get data when initState
    _couponBloc = BlocProvider.of<CouponBloc>(context);
    _couponBloc.add(GetCoupon(
        sessionId: SESSION_ID,
        skip: _apiPage.toString(),
        limit: LIMIT_PAGE.toString(),
        apiToken: apiToken));

    // detect last status bar color from previous page
    _fromWhiteStatusBarForeground = StaticVariable.useWhiteStatusBarForeground;

    // set status bar color to white and status navigation bar color to dark (At the very top of page)
    StaticVariable.useWhiteStatusBarForeground = false;
    FlutterStatusbarcolor.setStatusBarWhiteForeground(false);

    super.initState();
  }

  @override
  void dispose() {
    apiToken.cancel("cancelled"); // cancel fetch data from API
    _scrollController.dispose();

    _etSearch.dispose();
    super.dispose();
  }

  // this function used to fetch data from API if we scroll to the bottom of the page
  void _onScroll() {
    double maxScroll = _scrollController.position.maxScrollExtent;
    double currentScroll = _scrollController.position.pixels;

    if (currentScroll == maxScroll) {
      if (_lastData == false && !_processApi) {
        _couponBloc.add(GetCoupon(
            sessionId: SESSION_ID,
            skip: _apiPage.toString(),
            limit: LIMIT_PAGE.toString(),
            apiToken: apiToken));
        _processApi = true;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    _scrollController.addListener(_onScroll);
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: Colors.black, //change your color here
          ),
          elevation: 0,
          title: Text(
            AppLocalizations.of(context).translate('coupon'),
            style: GlobalStyle.appBarTitle,
          ),
          backgroundColor: Colors.white,
          bottom: PreferredSize(
            child: Container(
              decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(
                  color: Colors.grey[100],
                  width: 1.0,
                )),
              ),
              padding: EdgeInsets.fromLTRB(16, 0, 16, 12),
              height: kToolbarHeight,
              child: TextFormField(
                controller: _etSearch,
                textAlignVertical: TextAlignVertical.bottom,
                maxLines: 1,
                style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                onChanged: (textValue) {
                  setState(() {});
                },
                decoration: InputDecoration(
                  fillColor: Colors.grey[100],
                  filled: true,
                  hintText: AppLocalizations.of(context)
                      .translate('enter_promo_code'),
                  prefixIcon: Icon(Icons.search, color: Colors.grey[500]),
                  suffixIcon: (_etSearch.text == '')
                      ? null
                      : GestureDetector(
                          onTap: () {
                            setState(() {
                              _etSearch = TextEditingController(text: '');
                            });
                          },
                          child: Icon(Icons.close, color: Colors.grey[500])),
                  focusedBorder: UnderlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                      borderSide: BorderSide(color: Colors.grey[200])),
                  enabledBorder: UnderlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    borderSide: BorderSide(color: Colors.grey[200]),
                  ),
                ),
              ),
            ),
            preferredSize: Size.fromHeight(kToolbarHeight),
          ),
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
          child: BlocListener<CouponBloc, CouponState>(
            listener: (context, state) {
              if (state is CouponError) {
                _globalFunction.showToast(
                    type: 'error', message: state.errorMessage);
              }
              if (state is GetCouponSuccess) {
                if (state.couponData.length == 0) {
                  _lastData = true;
                } else {
                  _apiPage += LIMIT_PAGE;
                  couponData.addAll(state.couponData);
                }
                _processApi = false;
              }
            },
            child: BlocBuilder<CouponBloc, CouponState>(
              builder: (context, state) {
                if (state is CouponError) {
                  return Container(
                      child: Center(
                          child: Text(ERROR_OCCURED,
                              style:
                                  TextStyle(fontSize: 14, color: BLACK_GREY))));
                } else {
                  if (_lastData && _apiPage == 0) {
                    return Container(
                        child: Center(
                            child: Text(
                                AppLocalizations.of(context)
                                    .translate('no_coupon_data'),
                                style: TextStyle(
                                    fontSize: 14, color: BLACK_GREY))));
                  } else {
                    if (couponData.length == 0) {
                      return _shimmerLoading.buildShimmerContent();
                    } else {
                      return ListView.builder(
                        itemCount: (state is CouponWaiting)
                            ? couponData.length + 1
                            : couponData.length,
                        padding: EdgeInsets.fromLTRB(16, 0, 16, 16),
                        // Add one more item for progress indicator
                        itemBuilder: (BuildContext context, int index) {
                          if (index == couponData.length) {
                            return _globalWidget
                                .buildProgressIndicator(_lastData);
                          } else {
                            return _buildCouponCard(couponData[index]);
                          }
                        },
                        controller: _scrollController,
                      );
                    }
                  }
                }
              },
            ),
          ),
        ));
  }

  Widget _buildCouponCard(CouponModel couponData) {
    return Card(
      margin: EdgeInsets.only(top: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4),
      ),
      elevation: 2,
      color: Colors.white,
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => CouponDetailPage(
                      couponId: couponData.id,
                      fromWhite: _fromWhiteStatusBarForeground)));
        },
        child: Container(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(top: 5),
                padding: EdgeInsets.fromLTRB(8, 4, 8, 4),
                decoration: BoxDecoration(
                    color: SOFT_BLUE, borderRadius: BorderRadius.circular(5)),
                child: Text(
                    AppLocalizations.of(context).translate('limited_offer'),
                    style: GlobalStyle.couponLimitedOffer),
              ),
              SizedBox(height: 12),
              Text(couponData.name, style: GlobalStyle.couponName),
              SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      GlobalStyle.iconTime,
                      SizedBox(
                        width: 4,
                      ),
                      Text(
                          AppLocalizations.of(context)
                                  .translate('expiring_in') +
                              ' ' +
                              couponData.day +
                              ' ' +
                              AppLocalizations.of(context).translate('days'),
                          style: GlobalStyle.couponExpired),
                    ],
                  ),
                  GestureDetector(
                    onTap: () {
                      Fluttertoast.showToast(
                          msg: AppLocalizations.of(context)
                              .translate('coupon_applied'),
                          toastLength: Toast.LENGTH_LONG);
                      Navigator.pop(context);
                      // check the previous status bar color and when the user click use, set status bar color like the the previous page
                      if (_fromWhiteStatusBarForeground == true) {
                        StaticVariable.useWhiteStatusBarForeground = true;
                        FlutterStatusbarcolor.setStatusBarWhiteForeground(true);
                      } else {
                        StaticVariable.useWhiteStatusBarForeground = false;
                        FlutterStatusbarcolor.setStatusBarWhiteForeground(
                            false);
                      }
                    },
                    child: Text(
                        AppLocalizations.of(context).translate('use_now'),
                        style: TextStyle(
                            fontSize: 14,
                            color: SOFT_BLUE,
                            fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
