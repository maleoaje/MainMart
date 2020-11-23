/*
This is order detail page

include file in reuseable/global_function.dart to call function from GlobalFunction
include file in reuseable/cache_image_network.dart to use cache image network
 */

import 'package:flutter/material.dart';
import 'package:ijshopflutter/config/constants.dart';
import 'package:ijshopflutter/config/global_style.dart';
import 'package:ijshopflutter/ui/account/order/order_status.dart';
import 'package:ijshopflutter/ui/general/chat_us.dart';
import 'package:ijshopflutter/ui/general/product_detail/product_detail.dart';
import 'package:ijshopflutter/ui/reuseable/app_localizations.dart';
import 'package:ijshopflutter/ui/reuseable/cache_image_network.dart';
import 'package:ijshopflutter/ui/reuseable/global_function.dart';

class OrderDetailPage extends StatefulWidget {
  @override
  _OrderDetailPageState createState() => _OrderDetailPageState();
}

class _OrderDetailPageState extends State<OrderDetailPage> {
  // initialize global function
  final _globalFunction = GlobalFunction();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double boxImageSize = (MediaQuery.of(context).size.width / 6);

    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: Colors.black, //change your color here
          ),
          elevation: 2,
          title: Text(
            AppLocalizations.of(context).translate('order_detail'),
            style: GlobalStyle.appBarTitle,
          ),
          backgroundColor: Colors.white,
        ),
        body: ListView(
          children: [
            _createOrderStatus(),
            Container(
              margin: EdgeInsets.only(top: 6),
              child: Column(
                children: [
                  _buildItemCard(boxImageSize, 1),
                  _buildItemCard(boxImageSize, 2),
                  _buildItemCard(boxImageSize, 3),
                ],
              ),
            ),
            _createDeliveryDetail(),
            _createPaymentInformation(),
            Container(
              margin: EdgeInsets.all(32),
              child: SizedBox(
                  width: double.maxFinite,
                  child: RaisedButton(
                    elevation: 2,
                    shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(3.0),
                        side: BorderSide(color: PRIMARY_COLOR)),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ChatUsPage()));
                    },
                    padding: EdgeInsets.fromLTRB(0, 12, 0, 12),
                    color: PRIMARY_COLOR,
                    child: Text(
                      AppLocalizations.of(context).translate('chat_us'),
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                  )),
            ),
          ],
        ));
  }

  Widget _createOrderStatus() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            offset: Offset(0.0, 1.0), //(x,y)
            blurRadius: 3.0,
          ),
        ],
      ),
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(AppLocalizations.of(context).translate('status'),
              style: TextStyle(color: BLACK_GREY, fontSize: 13)),
          SizedBox(
            height: 4,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(AppLocalizations.of(context).translate('order_completed'),
                  style: TextStyle(
                      color: PRIMARY_COLOR,
                      fontSize: 14,
                      fontWeight: FontWeight.bold)),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => OrderStatusPage()));
                },
                child: Text(
                    AppLocalizations.of(context).translate('view_status'),
                    style: TextStyle(color: PRIMARY_COLOR, fontSize: 13)),
              )
            ],
          ),
          Divider(
            height: 32,
            color: Colors.grey[400],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(AppLocalizations.of(context).translate('order_date'),
                  style: TextStyle(color: BLACK_GREY, fontSize: 13)),
              Text('3 September 2019 11:32 UTC',
                  style: TextStyle(
                      color: BLACK_GREY,
                      fontSize: 13,
                      fontWeight: FontWeight.bold))
            ],
          ),
          Divider(
            height: 32,
            color: Colors.grey[400],
          ),
          Text('INV385714262',
              style: TextStyle(color: BLACK_GREY, fontSize: 13)),
        ],
      ),
    );
  }

  Widget _buildItemCard(boxImageSize, id) {
    // create local data
    String name = 'Delta Boots Import 8 Inch';
    String image = GLOBAL_URL + '/assets/images/product/25.jpg';
    int countItem = 1;
    int weight = 800;
    double price = 18.3;
    double totalPrice = 18.3;
    if (id == 2) {
      name =
          'DATA CABLE TYPE-C TO TYPE-C BASEUS HALO DATA CABLE PD 2.0 60W - 0.5 M';
      image = GLOBAL_URL + '/assets/images/product/35.jpg';
      countItem = 2;
      weight = 100;
      price = 3;
      totalPrice = 6;
    } else if (id == 3) {
      name = 'TEROPONG MINI 30 X 60 BINOCULARS HD NIGHT VERSION 30 X 60';
      image = GLOBAL_URL + '/assets/images/product/2.jpg';
      countItem = 1;
      weight = 400;
      price = 7.2;
      totalPrice = 7.2;
    }
    return Container(
      margin: EdgeInsets.fromLTRB(12, 6, 12, 0),
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
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ProductDetailPage(
                              fromWhite: null,
                              name: name,
                              image: image,
                              price: price,
                              rating: 5,
                              review: 23,
                              sale: 40)));
                },
                child: Container(
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
                              url: image)),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              name,
                              style: GlobalStyle.productName.copyWith(
                                  fontSize: 14, fontWeight: FontWeight.bold),
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Container(
                                margin: EdgeInsets.only(top: 4),
                                child: Text(
                                    countItem.toString() +
                                        ' ' +
                                        AppLocalizations.of(context)
                                            .translate('item') +
                                        '  (' +
                                        weight.toString() +
                                        ' ' +
                                        AppLocalizations.of(context)
                                            .translate('gr') +
                                        ')',
                                    style: GlobalStyle.shoppingCartOtherProduct
                                        .copyWith(color: Colors.grey[400]))),
                            Container(
                              margin: EdgeInsets.only(top: 4),
                              child: Text(
                                  '\$' +
                                      _globalFunction
                                          .removeDecimalZeroFormat(price),
                                  style: GlobalStyle.productPrice),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Divider(
                height: 0,
                color: Colors.grey[400],
              ),
              Container(
                  margin: EdgeInsets.all(12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                          AppLocalizations.of(context).translate('total_price'),
                          style: TextStyle(fontSize: 12)),
                      Container(
                        child: Text(
                            '\$' +
                                _globalFunction
                                    .removeDecimalZeroFormat(totalPrice),
                            style: GlobalStyle.productPrice),
                      )
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }

  Widget _createDeliveryDetail() {
    return Container(
        margin: EdgeInsets.only(top: 12),
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              offset: Offset(0.0, 1.0), //(x,y)
              blurRadius: 3.0,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(AppLocalizations.of(context).translate('delivery_details'),
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            SizedBox(
              height: 16,
            ),
            Table(
              children: [
                TableRow(children: [
                  Container(
                    child: Text(
                        AppLocalizations.of(context)
                            .translate('courier_delivery'),
                        style: TextStyle(
                          color: BLACK_GREY,
                          fontSize: 13,
                        )),
                  ),
                  Container(
                    child: Text('DHL Express',
                        style: TextStyle(
                            color: CHARCOAL,
                            fontSize: 14,
                            fontWeight: FontWeight.bold)),
                  )
                ]),
                TableRow(children: [
                  Container(
                    margin: EdgeInsets.only(top: 8),
                    child: Text(
                        AppLocalizations.of(context).translate('awb_number'),
                        style: TextStyle(
                          color: BLACK_GREY,
                          fontSize: 13,
                        )),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 8),
                    child: Text('5614571226',
                        style: TextStyle(
                            color: CHARCOAL,
                            fontSize: 14,
                            fontWeight: FontWeight.bold)),
                  )
                ]),
                TableRow(children: [
                  Container(
                    margin: EdgeInsets.only(top: 8),
                    child: Text(
                        AppLocalizations.of(context)
                            .translate('delivery_address'),
                        style: TextStyle(
                          color: BLACK_GREY,
                          fontSize: 13,
                        )),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          child: Text('Oamle',
                              style: TextStyle(
                                  color: CHARCOAL,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold)),
                        ),
                        Container(
                          child: Text('08118889991',
                              style: TextStyle(
                                  color: CHARCOAL,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold)),
                        ),
                        Container(
                          child: Text('Abuja',
                              style: TextStyle(
                                  color: CHARCOAL,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold)),
                        ),
                        Container(
                          child: Text('',
                              style: TextStyle(
                                  color: CHARCOAL,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold)),
                        ),
                        Container(
                          child: Text('Nigeria',
                              style: TextStyle(
                                  color: CHARCOAL,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold)),
                        ),
                      ],
                    ),
                  )
                ]),
              ],
            ),
          ],
        ));
  }

  Widget _createPaymentInformation() {
    return Container(
        margin: EdgeInsets.only(top: 16),
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              offset: Offset(0.0, 1.0), //(x,y)
              blurRadius: 3.0,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(AppLocalizations.of(context).translate('payment_information'),
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            SizedBox(
              height: 16,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(AppLocalizations.of(context).translate('payment_method'),
                    style: TextStyle(color: BLACK_GREY, fontSize: 13)),
                Text(
                    AppLocalizations.of(context)
                        .translate('visa_card_ending_in1'),
                    style: TextStyle(
                        color: CHARCOAL,
                        fontSize: 13,
                        fontWeight: FontWeight.bold))
              ],
            ),
            Divider(
              height: 32,
              color: Colors.grey[400],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                    AppLocalizations.of(context).translate('total_price') +
                        ' (4 ' +
                        AppLocalizations.of(context).translate('item') +
                        ')',
                    style: TextStyle(color: BLACK_GREY, fontSize: 13)),
                Text('\$31.5', style: GlobalStyle.productPrice)
              ],
            ),
            SizedBox(
              height: 8,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                    AppLocalizations.of(context).translate('total_delivery') +
                        ' (1.3 Kg)',
                    style: TextStyle(color: BLACK_GREY, fontSize: 13)),
                Text('\$19', style: GlobalStyle.productPrice)
              ],
            ),
            Divider(
              height: 32,
              color: Colors.grey[400],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(AppLocalizations.of(context).translate('total_payment'),
                    style:
                        TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                Text('\$50.5', style: GlobalStyle.productPrice)
              ],
            ),
          ],
        ));
  }
}
