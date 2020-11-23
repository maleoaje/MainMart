/*
This is last search page

include file in reuseable/global_function.dart to call function from GlobalFunction
include file in reuseable/global_widget.dart to call function from GlobalWidget
include file in reuseable/cache_image_network.dart to use cache image network
include file in reuseable/shimmer_loading.dart to use shimmer loading
include file in model/home/last_search_model.dart to get lastSearchData

install plugin in pubspec.yaml
- flutter_statusbarcolor => to change status bar color and navigation status bar color (at the very top of the screen) (https://pub.dev/packages/flutter_statusbarcolor)

Don't forget to add all images and sound used in this pages at the pubspec.yaml
 */

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:ijshopflutter/bloc/home/last_search/bloc.dart';
import 'package:ijshopflutter/config/constants.dart';
import 'package:ijshopflutter/config/global_style.dart';
import 'package:ijshopflutter/config/static_variable.dart';
import 'package:ijshopflutter/model/home/last_search_model.dart';
import 'package:ijshopflutter/ui/general/product_detail/product_detail.dart';
import 'package:ijshopflutter/ui/reuseable/app_localizations.dart';
import 'package:ijshopflutter/ui/reuseable/cache_image_network.dart';
import 'package:ijshopflutter/ui/home/search/search.dart';
import 'package:ijshopflutter/ui/reuseable/global_function.dart';
import 'package:ijshopflutter/ui/reuseable/global_widget.dart';
import 'package:ijshopflutter/ui/reuseable/shimmer_loading.dart';

class LastSearchPage extends StatefulWidget {
  @override
  _LastSearchPageState createState() => _LastSearchPageState();
}

class _LastSearchPageState extends State<LastSearchPage> {
  // initialize global function, global widget and shimmer loading
  final _globalFunction = GlobalFunction();
  final _globalWidget = GlobalWidget();
  final _shimmerLoading = ShimmerLoading();

  List<LastSearchModel> lastSearchData = List();

  LastSearchBloc _lastSearchBloc;
  int _apiPage = 0;
  ScrollController _scrollController = ScrollController();
  bool _lastData = false;
  bool _processApi = false;

  CancelToken apiToken = CancelToken(); // used to cancel fetch data from API

  bool _fromWhiteStatusBarForeground = false;

  @override
  void initState() {
    // get data when initState
    _lastSearchBloc = BlocProvider.of<LastSearchBloc>(context);
    _lastSearchBloc.add(GetLastSearch(
        sessionId: SESSION_ID,
        skip: _apiPage.toString(),
        limit: '10',
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

    super.dispose();
  }

  // this function used to fetch data from API if we scroll to the bottom of the page
  void _onScroll() {
    double maxScroll = _scrollController.position.maxScrollExtent;
    double currentScroll = _scrollController.position.pixels;

    if (currentScroll == maxScroll) {
      if (_lastData == false && !_processApi) {
        _lastSearchBloc.add(GetLastSearch(
            sessionId: SESSION_ID,
            skip: _apiPage.toString(),
            limit: '10',
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
            'Featured Products',
            style: GlobalStyle.appBarTitle,
          ),
          backgroundColor: Colors.white,
          actions: [
            IconButton(
                icon: Icon(Icons.search, color: BLACK_GREY),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SearchPage()));
                }),
          ],
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
          child: BlocListener<LastSearchBloc, LastSearchState>(
            listener: (context, state) {
              if (state is LastSearchError) {
                _globalFunction.showToast(
                    type: 'error', message: state.errorMessage);
              }
              if (state is GetLastSearchSuccess) {
                if (state.lastSearchData.length == 0) {
                  _lastData = true;
                } else {
                  _apiPage += 10;
                  lastSearchData.addAll(state.lastSearchData);
                }
                _processApi = false;
              }
            },
            child: BlocBuilder<LastSearchBloc, LastSearchState>(
              builder: (context, state) {
                if (state is LastSearchError) {
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
                                    .translate('no_last_search'),
                                style: TextStyle(
                                    fontSize: 14, color: BLACK_GREY))));
                  } else {
                    if (lastSearchData.length == 0) {
                      return _shimmerLoading.buildShimmerProduct(
                          ((MediaQuery.of(context).size.width) - 24) / 2 - 12);
                    } else {
                      return CustomScrollView(
                          shrinkWrap: true,
                          primary: false,
                          controller: _scrollController,
                          slivers: <Widget>[
                            SliverPadding(
                              padding: EdgeInsets.fromLTRB(12, 8, 12, 8),
                              sliver: SliverGrid(
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  mainAxisSpacing: 8,
                                  crossAxisSpacing: 8,
                                  childAspectRatio:
                                      GlobalStyle.gridDelegateRatio,
                                ),
                                delegate: SliverChildBuilderDelegate(
                                  (BuildContext context, int index) {
                                    return _buildLastSearchCard(index);
                                  },
                                  childCount: lastSearchData.length,
                                ),
                              ),
                            ),
                            SliverToBoxAdapter(
                              child: _globalWidget
                                  .buildProgressIndicator(_lastData),
                            ),
                          ]);
                    }
                  }
                }
              },
            ),
          ),
        ));
  }

  Widget _buildLastSearchCard(index) {
    final double boxImageSize =
        ((MediaQuery.of(context).size.width) - 24) / 2 - 12;
    return Container(
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        elevation: 2,
        color: Colors.white,
        child: GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ProductDetailPage(
                          fromWhite: null,
                          name: lastSearchData[index].name,
                          image: lastSearchData[index].image,
                          price: lastSearchData[index].price,
                          description: lastSearchData[index].description,
                          summary: lastSearchData[index].summary,
                        )));
          },
          child: Column(
            children: <Widget>[
              ClipRRect(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10)),
                  child: buildCacheNetworkImage(
                      width: boxImageSize,
                      height: boxImageSize,
                      url:
                          'https://apistore.mainmart.com.ng/Resources/Images/' +
                              lastSearchData[index].image)),
              Container(
                margin: EdgeInsets.fromLTRB(8, 8, 8, 8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      lastSearchData[index].name,
                      style: GlobalStyle.productName,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                              '\₦ ' +
                                  _globalFunction.removeDecimalZeroFormat(
                                      lastSearchData[index].price),
                              style: GlobalStyle.productPrice),
                          /*Text(
                              '0' +
                                  ' ' +
                                  AppLocalizations.of(context)
                                      .translate('sale'),
                              style: GlobalStyle.productSale)*/
                        ],
                      ),
                    ), /*
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 5),
                      child: Row(
                        children: [
                          Icon(Icons.location_on, color: SOFT_GREY, size: 12),
                          Text(' ' + 'MainMart Stores',
                              style: GlobalStyle.productLocation)
                        ],
                      ),
                    Container(
                      margin: EdgeInsets.only(top: 5),
                      child: Row(
                        children: [
                          _globalWidget.createRatingBar(0),
                          Text('(0)', style: GlobalStyle.productTotalReview)
                        ],
                      ),
                    )*/
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
