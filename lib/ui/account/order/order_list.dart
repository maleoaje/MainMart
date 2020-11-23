/*
This is order list page

include file in reuseable/global_function.dart to call function from GlobalFunction
include file in reuseable/global_widget.dart to call function from GlobalWidget
include file in reuseable/cache_image_network.dart to use cache image network
include file in reuseable/shimmer_loading.dart to use shimmer loading
include file in model/account/order_list_model.dart to get orderListData
 */

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ijshopflutter/bloc/account/order_list/bloc.dart';
import 'package:ijshopflutter/config/constants.dart';
import 'package:ijshopflutter/config/global_style.dart';
import 'package:ijshopflutter/model/account/order_list_model.dart';
import 'package:ijshopflutter/ui/account/order/order_detail.dart';
import 'package:ijshopflutter/ui/reuseable/app_localizations.dart';
import 'package:ijshopflutter/ui/reuseable/cache_image_network.dart';
import 'package:ijshopflutter/ui/reuseable/global_function.dart';
import 'package:ijshopflutter/ui/reuseable/global_widget.dart';
import 'package:ijshopflutter/ui/reuseable/shimmer_loading.dart';

class OrderPage extends StatefulWidget {
  @override
  _OrderPageState createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  // initialize global function, global widget and shimmer loading
  final _globalFunction = GlobalFunction();
  final _globalWidget = GlobalWidget();
  final _shimmerLoading = ShimmerLoading();

  List<OrderListModel> orderListData = List();

  OrderListBloc _orderListProductBloc;
  int _apiPage = 0;
  ScrollController _scrollController = ScrollController();
  bool _lastData = false;
  bool _processApi = false;

  CancelToken apiToken = CancelToken(); // used to cancel fetch data from API

  @override
  void initState() {
    // get data when initState
    _orderListProductBloc = BlocProvider.of<OrderListBloc>(context);
    _orderListProductBloc.add(GetOrderList(
        sessionId: SESSION_ID,
        status: '',
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
        _orderListProductBloc.add(GetOrderList(
            sessionId: SESSION_ID,
            status: '',
            skip: _apiPage.toString(),
            limit: LIMIT_PAGE.toString(),
            apiToken: apiToken));
        _processApi = true;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final double boxImageSize = (MediaQuery.of(context).size.width / 6);
    _scrollController.addListener(_onScroll);
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: Colors.black, //change your color here
          ),
          elevation: 0,
          title: Text(
            AppLocalizations.of(context).translate('order_list'),
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
        body: BlocListener<OrderListBloc, OrderListState>(
          listener: (context, state) {
            if (state is OrderListError) {
              _globalFunction.showToast(
                  type: 'error', message: state.errorMessage);
            }
            if (state is GetOrderListSuccess) {
              if (state.orderListData.length == 0) {
                _lastData = true;
              } else {
                _apiPage += LIMIT_PAGE;
                orderListData.addAll(state.orderListData);
              }
              _processApi = false;
            }
          },
          child: BlocBuilder<OrderListBloc, OrderListState>(
            builder: (context, state) {
              if (state is OrderListError) {
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
                                  .translate('no_order_list'),
                              style:
                                  TextStyle(fontSize: 14, color: BLACK_GREY))));
                } else {
                  if (orderListData.length == 0) {
                    return _shimmerLoading.buildShimmerContent();
                  } else {
                    return ListView.builder(
                      itemCount: (state is OrderListWaiting)
                          ? orderListData.length + 1
                          : orderListData.length,
                      // Add one more item for progress indicator
                      padding: EdgeInsets.symmetric(vertical: 0),
                      itemBuilder: (BuildContext context, int index) {
                        if (index == orderListData.length) {
                          return _globalWidget
                              .buildProgressIndicator(_lastData);
                        } else {
                          return _buildOrderListCard(index, boxImageSize);
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

  Widget _buildOrderListCard(index, boxImageSize) {
    return Container(
      margin: EdgeInsets.fromLTRB(12, 6, 12, 0),
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => OrderDetailPage()));
        },
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          elevation: 2,
          color: Colors.white,
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(12),
                  child: Text(orderListData[index].status,
                      style: TextStyle(color: SOFT_BLUE, fontSize: 12)),
                ),
                Divider(
                  height: 0,
                  color: Colors.grey[400],
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(12, 12, 12, 0),
                  child: Text(orderListData[index].date,
                      style: TextStyle(fontSize: 12, color: Colors.grey[400])),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(12, 8, 12, 0),
                  child: Text(orderListData[index].invoice,
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                ),
                Container(
                  margin: EdgeInsets.all(12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                          child: buildCacheNetworkImage(
                              width: boxImageSize,
                              height: boxImageSize,
                              url: orderListData[index].image)),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              orderListData[index].name,
                              style: GlobalStyle.productName.copyWith(
                                  fontSize: 14, fontWeight: FontWeight.bold),
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Container(
                                margin: EdgeInsets.only(top: 4),
                                child: Text(
                                    '+2 ' +
                                        AppLocalizations.of(context)
                                            .translate('other_product'),
                                    style: GlobalStyle.shoppingCartOtherProduct
                                        .copyWith(color: Colors.grey[400])))
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Divider(
                  height: 0,
                  color: Colors.grey[400],
                ),
                Container(
                    margin: EdgeInsets.all(12),
                    alignment: Alignment.topRight,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                            AppLocalizations.of(context)
                                .translate('total_payment'),
                            style: TextStyle(fontSize: 12)),
                        Container(
                          margin: EdgeInsets.only(top: 4),
                          child: Text(
                              '\$' +
                                  _globalFunction.removeDecimalZeroFormat(
                                      orderListData[index].payment),
                              style: GlobalStyle.productPrice),
                        )
                      ],
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
