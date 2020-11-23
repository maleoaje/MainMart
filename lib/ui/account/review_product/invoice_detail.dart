/*
This is invoice detail page

include file in reuseable/global_widget.dart to call function from GlobalWidget
include file in reuseable/cache_image_network.dart to use cache image network
include file in reuseable/shimmer_loading.dart to use shimmer loading

 */

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:ijshopflutter/config/constants.dart';
import 'package:ijshopflutter/config/global_style.dart';
import 'package:ijshopflutter/ui/reuseable/app_localizations.dart';
import 'package:ijshopflutter/ui/reuseable/cache_image_network.dart';
import 'package:ijshopflutter/ui/reuseable/global_widget.dart';
import 'package:ijshopflutter/ui/reuseable/shimmer_loading.dart';
import 'package:ijshopflutter/ui/account/review_product/review_product.dart';

class InvoiceDetailPage extends StatefulWidget {
  final String invoices;

  const InvoiceDetailPage({Key key, this.invoices = ''}) : super(key: key);

  @override
  _InvoiceDetailPageState createState() => _InvoiceDetailPageState();
}

class _InvoiceDetailPageState extends State<InvoiceDetailPage> {
  // initialize global widget
  final _globalWidget = GlobalWidget();
  final _shimmerLoading = ShimmerLoading();

  bool _loading = true;
  Timer _timerLoadingDummy;

  @override
  void initState() {
    // this timer function is just for demo, so after 2 second, the shimmer loading will disappear and show the content
    _timerLoadingDummy = Timer(Duration(milliseconds: 300), () {
      setState(() {
        _loading = false;
      });
    });

    super.initState();
  }

  @override
  void dispose() {
    _timerLoadingDummy?.cancel();

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
          elevation: 0,
          title: Text(
            widget.invoices,
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
        body: (_loading == true)
            ? _shimmerLoading.buildShimmerContent()
            : ListView(
                padding: EdgeInsets.only(bottom: 12),
                children: [
                  _buildItemCard(1, boxImageSize),
                  _buildItemCard(2, boxImageSize),
                  _buildItemCard(3, boxImageSize)
                ],
              )
    );
  }

  Widget _buildItemCard(id, boxImageSize){
    // create local data
    String name = 'Delta Boots Import 8 Inch';
    String image = GLOBAL_URL+'/assets/images/product/25.jpg';
    if(id == 2){
      name = 'DATA CABLE TYPE-C TO TYPE-C BASEUS HALO DATA CABLE PD 2.0 60W - 0.5 M';
      image = GLOBAL_URL+'/assets/images/product/35.jpg';
    } else if(id == 3){
      name = 'TEROPONG MINI 30 X 60 BINOCULARS HD NIGHT VERSION 30 X 60';
      image = GLOBAL_URL+'/assets/images/product/2.jpg';
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
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => ReviewProductPage(name: name, image:image)));
                },
                child: Container(
                  margin: EdgeInsets.all(12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      ClipRRect(
                          borderRadius:
                          BorderRadius.all(Radius.circular(8)),
                          child: buildCacheNetworkImage(width: boxImageSize, height: boxImageSize, url: image)),
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
                              style: GlobalStyle.productName.copyWith(fontSize: 14, fontWeight: FontWeight.bold),
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 4),
                              child: (id==2)
                                  ? _globalWidget.createRatingBar(4)
                                  : Text(AppLocalizations.of(context).translate('not_reviewed'), style: GlobalStyle.shoppingCartOtherProduct.copyWith(color: Colors.grey[400]))
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
                  alignment: Alignment.topRight,
                  child: GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => ReviewProductPage(name: name, image:image)));
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(id==2?AppLocalizations.of(context).translate('edit_review'):AppLocalizations.of(context).translate('add_review'), style: TextStyle(
                            color: PRIMARY_COLOR
                        )),
                        Icon(Icons.chevron_right, size: 20, color: PRIMARY_COLOR),
                      ],
                    ),
                  )
              )
            ],
          ),
        ),
      ),
    );
  }
}
