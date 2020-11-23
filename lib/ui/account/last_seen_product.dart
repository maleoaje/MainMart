/*
This is last seen product page

include file in reuseable/global_function.dart to call function from GlobalFunction
include file in reuseable/global_widget.dart to call function from GlobalWidget
include file in reuseable/cache_image_network.dart to use cache image network
include file in reuseable/shimmer_loading.dart to use shimmer loading
include file in model/model/account/last_seen_model.dart to get lastSeenData
 */

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ijshopflutter/bloc/account/last_seen_product/bloc.dart';
import 'package:ijshopflutter/config/constants.dart';
import 'package:ijshopflutter/config/global_style.dart';
import 'package:ijshopflutter/model/account/last_seen_model.dart';
import 'package:ijshopflutter/ui/general/product_detail/product_detail.dart';
import 'package:ijshopflutter/ui/reuseable/app_localizations.dart';
import 'package:ijshopflutter/ui/reuseable/cache_image_network.dart';
import 'package:ijshopflutter/ui/reuseable/global_function.dart';
import 'package:ijshopflutter/ui/reuseable/global_widget.dart';
import 'package:ijshopflutter/ui/reuseable/shimmer_loading.dart';

class LastSeenProductPage extends StatefulWidget {
  @override
  _LastSeenProductPageState createState() => _LastSeenProductPageState();
}

class _LastSeenProductPageState extends State<LastSeenProductPage> {
  // initialize global function and global widget
  final _globalFunction = GlobalFunction();
  final _globalWidget = GlobalWidget();
  final _shimmerLoading = ShimmerLoading();

  List<LastSeenModel> lastSeenData = List();

  LastSeenProductBloc _lastSeenProductBloc;
  int _apiPage = 0;
  ScrollController _scrollController = ScrollController();
  bool _lastData = false;
  bool _processApi = false;

  CancelToken apiToken = CancelToken(); // used to cancel fetch data from API

  @override
  void initState() {
    // get data when initState
    _lastSeenProductBloc = BlocProvider.of<LastSeenProductBloc>(context);
    _lastSeenProductBloc.add(GetLastSeenProduct(
        sessionId: SESSION_ID,
        skip: _apiPage.toString(),
        limit: LIMIT_PAGE.toString(),
        apiToken: apiToken));

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
        _lastSeenProductBloc.add(GetLastSeenProduct(
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
    final double boxImageSize = (MediaQuery.of(context).size.width / 4);
    _scrollController.addListener(_onScroll);
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: Colors.black, //change your color here
          ),
          elevation: 0,
          title: Text(
            AppLocalizations.of(context).translate('last_seen_product'),
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
        body: BlocListener<LastSeenProductBloc, LastSeenProductState>(
          listener: (context, state) {
            if (state is LastSeenProductError) {
              _globalFunction.showToast(
                  type: 'error', message: state.errorMessage);
            }
            if (state is GetLastSeenProductSuccess) {
              if (state.lastSeenData.length == 0) {
                _lastData = true;
              } else {
                _apiPage += LIMIT_PAGE;
                lastSeenData.addAll(state.lastSeenData);
              }
              _processApi = false;
            }
          },
          child: BlocBuilder<LastSeenProductBloc, LastSeenProductState>(
            builder: (context, state) {
              if (state is LastSeenProductError) {
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
                                  .translate('no_last_seen_product'),
                              style:
                                  TextStyle(fontSize: 14, color: BLACK_GREY))));
                } else {
                  if (lastSeenData.length == 0) {
                    return _shimmerLoading.buildShimmerContent();
                  } else {
                    return ListView.builder(
                      itemCount: (state is LastSeenProductWaiting)
                          ? lastSeenData.length + 1
                          : lastSeenData.length,
                      // Add one more item for progress indicator
                      padding: EdgeInsets.symmetric(vertical: 0),
                      itemBuilder: (BuildContext context, int index) {
                        if (index == lastSeenData.length) {
                          return _globalWidget
                              .buildProgressIndicator(_lastData);
                        } else {
                          return _buildItem(index, boxImageSize);
                        }
                      },
                      controller: _scrollController,
                    );
                  }
                }
              }
            },
          ),
        ));
  }

  Widget _buildItem(index, boxImageSize) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ProductDetailPage(
                        fromWhite: null,
                        name: lastSeenData[index].name,
                        image: lastSeenData[index].image,
                        price: lastSeenData[index].price,
                        rating: lastSeenData[index].rating,
                        review: lastSeenData[index].review,
                        sale: lastSeenData[index].sale)));
          },
          child: Container(
            margin: EdgeInsets.fromLTRB(12, 6, 12, 6),
            child: Container(
              margin: EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(4)),
                      child: buildCacheNetworkImage(
                          width: boxImageSize,
                          height: boxImageSize,
                          url: lastSeenData[index].image)),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          lastSeenData[index].name,
                          style: GlobalStyle.productName.copyWith(fontSize: 13),
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 5),
                          child: Text(
                              '\$ ' +
                                  _globalFunction.removeDecimalZeroFormat(
                                      lastSeenData[index].price),
                              style: GlobalStyle.productPrice),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 5),
                          child: Row(
                            children: [
                              Icon(Icons.location_on,
                                  color: SOFT_GREY, size: 12),
                              Text(' ' + lastSeenData[index].location,
                                  style: GlobalStyle.productLocation)
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 5),
                          child: Row(
                            children: [
                              _globalWidget
                                  .createRatingBar(lastSeenData[index].rating),
                              Text(
                                  '(' +
                                      lastSeenData[index].review.toString() +
                                      ')',
                                  style: GlobalStyle.productTotalReview)
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 5),
                          child: Text(
                              lastSeenData[index].sale.toString() +
                                  ' ' +
                                  AppLocalizations.of(context)
                                      .translate('sale'),
                              style: GlobalStyle.productSale),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        (index == lastSeenData.length - 1)
            ? Wrap()
            : Divider(
                height: 0,
                color: Colors.grey[400],
              )
      ],
    );
  }
}
