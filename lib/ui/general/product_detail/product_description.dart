/*
This is product description page

include file in reuseable/cache_image_network.dart to use cache image network
 */

import 'package:flutter/material.dart';
import 'package:ijshopflutter/config/global_style.dart';
import 'package:ijshopflutter/ui/reuseable/app_localizations.dart';
import 'package:ijshopflutter/ui/reuseable/cache_image_network.dart';

class ProductDescriptionPage extends StatefulWidget {
  final String name, image, description, summary;

  const ProductDescriptionPage(
      {Key key,
      this.name = '',
      this.image = '',
      this.description = '',
      this.summary = ''})
      : super(key: key);
  @override
  _ProductDescriptionPageState createState() => _ProductDescriptionPageState();
}

class _ProductDescriptionPageState extends State<ProductDescriptionPage> {
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
    final double boxImageSize = (MediaQuery.of(context).size.width / 4);

    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: Colors.black, //change your color here
          ),
          elevation: 0,
          title: Text(
            AppLocalizations.of(context).translate('product_description'),
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
        body: ListView(
          children: [
            _createProductImageAndTitle(boxImageSize),
            Divider(height: 0, color: Colors.grey[400]),
            Container(
              padding: EdgeInsets.all(16),
              child: Text(widget.description),
            )
          ],
        ));
  }

  Widget _createProductImageAndTitle(boxImageSize) {
    return Container(
        margin: EdgeInsets.all(24),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(4)),
                child: buildCacheNetworkImage(
                    width: boxImageSize,
                    height: boxImageSize,
                    url: widget.image)),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    widget.name,
                    style: GlobalStyle.productName
                        .copyWith(fontSize: 14, fontWeight: FontWeight.bold),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            )
          ],
        ));
  }
}
