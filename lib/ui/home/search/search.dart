/*
This is search page

include file in reuseable/global_function.dart to call function from GlobalFunction
include file in reuseable/shimmer_loading.dart to use shimmer loading
include file in reuseable/cache_image_network.dart to use cache image network
include file in model/account/last_seen_model.dart to get lastSeenData
include file in model/home/search/search_model.dart to get searchData

install plugin in pubspec.yaml
- flutter_statusbarcolor => to change status bar color and navigation status bar color (at the very top of the screen) (https://pub.dev/packages/flutter_statusbarcolor)

Don't forget to add all images and sound used in this pages at the pubspec.yaml
 */

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/style.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:ijshopflutter/bloc/account/last_seen_product/bloc.dart';
import 'package:ijshopflutter/bloc/home/search/search/bloc.dart';
import 'package:ijshopflutter/config/constants.dart';
import 'package:ijshopflutter/config/static_variable.dart';
import 'package:ijshopflutter/model/account/last_seen_model.dart';
import 'package:ijshopflutter/model/home/search/search_model.dart';
import 'package:ijshopflutter/ui/general/product_detail/product_detail.dart';
import 'package:ijshopflutter/ui/reuseable/app_localizations.dart';
import 'package:ijshopflutter/ui/reuseable/cache_image_network.dart';
import 'package:ijshopflutter/ui/home/search/search_product.dart';
import 'package:ijshopflutter/ui/reuseable/global_function.dart';
import 'package:ijshopflutter/ui/reuseable/shimmer_loading.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  // initialize global function and shimmer loading
  final _globalFunction = GlobalFunction();
  final _shimmerLoading = ShimmerLoading();

  List<SearchModel> searchData = List();

  SearchBloc _searchBloc;

  CancelToken apiToken = CancelToken(); // used to cancel fetch data from API

  bool _fromWhiteStatusBarForeground = false;

  TextEditingController _etSearch = TextEditingController();

  bool _lastData = false;

  @override
  void initState() {
    // get data when initState
    _searchBloc = BlocProvider.of<SearchBloc>(context);
    _searchBloc.add(GetSearch(sessionId: SESSION_ID, apiToken: apiToken));

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
    _etSearch.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double boxImageSize = (MediaQuery.of(context).size.width / 7);
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0.0,
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        // create search text field in the app bar
        title: Container(
          margin: EdgeInsets.only(right: 16),
          height: kToolbarHeight - 20,
          child: TextField(
            controller: _etSearch,
            autofocus: true,
            textInputAction: TextInputAction.search,
            onChanged: (textValue) {
              setState(() {});
            },
            maxLines: 1,
            style: TextStyle(fontSize: 13, color: Colors.grey[600]),
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.search, color: Colors.grey[500], size: 18),
              suffixIcon: GestureDetector(
                  onTap: () {
                    setState(() {
                      _etSearch = TextEditingController(text: '');
                    });
                  },
                  child: Icon(Icons.close, color: Colors.grey[500], size: 18)),
              contentPadding: EdgeInsets.all(0),
              isDense: true,
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.all(
                  Radius.circular(5),
                ),
              ),
              filled: true,
              fillColor: Colors.grey[200],
              hintText: AppLocalizations.of(context)
                  .translate('search_product_small'),
            ),
          ),
        ),
        actions: [
          GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () {
              setState(() {
                int idx = searchData
                    .indexWhere((data) => data.words == _etSearch.text);
                if (idx == -1) {
                  if (searchData.length == 5) {
                    searchData.removeLast();
                  }
                  searchData.insert(
                      0, SearchModel(id: 1, words: _etSearch.text));
                } else {
                  searchData.removeAt(idx);
                  searchData.insert(
                      0, SearchModel(id: 1, words: _etSearch.text));
                }
              });
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => SearchProductPage(
                          fromWhite: _fromWhiteStatusBarForeground,
                          words: _etSearch.text)));
            },
            child: Center(
              child: Row(
                children: [
                  Icon(Icons.search, color: PRIMARY_COLOR, size: 25),
                  SizedBox(width: 12),
                ],
              ),
            ),
          ),
        ],
      ),
      body: WillPopScope(
        onWillPop: () {
          Navigator.pop(context);
          FocusScope.of(context).unfocus();
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
        // if search field is empty, show history search
        // if search field not empty, show search text
        child: _showSearchText(),
      ),
    );
  }

  Widget _showSearchText() {
    return ListView(
      padding: EdgeInsets.all(16),
      children: [
        Container(
          margin: EdgeInsets.only(top: 16),
          child: GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () {
              setState(() {
                int idx = searchData
                    .indexWhere((data) => data.words == _etSearch.text);
                if (idx == -1) {
                  if (searchData.length == 5) {
                    searchData.removeLast();
                  }
                  searchData.insert(
                      0, SearchModel(id: 1, words: _etSearch.text));
                } else {
                  searchData.removeAt(idx);
                  searchData.insert(
                      0, SearchModel(id: 1, words: _etSearch.text));
                }
              });
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => SearchProductPage(
                          fromWhite: _fromWhiteStatusBarForeground,
                          words: _etSearch.text)));
            },
            child: Center(
              child: Row(
                children: [
                  Icon(Icons.search, color: PRIMARY_COLOR, size: 36),
                  SizedBox(width: 12),
                  Text(_etSearch.text,
                      style: TextStyle(
                          color: PRIMARY_COLOR,
                          fontWeight: FontWeight.bold,
                          fontSize: 20))
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
