/*
This is search product page

include file in reuseable/global_function.dart to call function from GlobalFunction
include file in reuseable/global_widget.dart to call function from GlobalWidet
include file in reuseable/cache_image_network.dart to use cache image network
include file in reuseable/shimmer_loading.dart to use shimmer loading
include file in model/home/search/search_product_model.dart to get searchProductData

install plugin in pubspec.yaml
- flutter_statusbarcolor => to change status bar color and navigation status bar color (at the very top of the screen) (https://pub.dev/packages/flutter_statusbarcolor)

Don't forget to add all images and sound used in this pages at the pubspec.yaml
 */

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:ijshopflutter/bloc/home/search/search_product/bloc.dart';
import 'package:ijshopflutter/config/constants.dart';
import 'package:ijshopflutter/config/global_style.dart';
import 'package:ijshopflutter/config/static_variable.dart';
import 'package:ijshopflutter/model/home/search/search_product_model.dart';
import 'package:ijshopflutter/ui/general/product_detail/product_detail.dart';
import 'package:ijshopflutter/ui/reuseable/app_localizations.dart';
import 'package:ijshopflutter/ui/reuseable/cache_image_network.dart';
import 'package:ijshopflutter/ui/home/search/search.dart';
import 'package:ijshopflutter/ui/reuseable/global_function.dart';
import 'package:ijshopflutter/ui/reuseable/global_widget.dart';
import 'package:ijshopflutter/ui/reuseable/shimmer_loading.dart';

class SearchProductPage extends StatefulWidget {
  final bool fromWhite;
  final String words;

  const SearchProductPage({Key key, this.fromWhite = false, this.words})
      : super(key: key);

  @override
  _SearchProductPageState createState() => _SearchProductPageState();
}

class _SearchProductPageState extends State<SearchProductPage> {
  // initialize global function, global widget and shimmer laoding
  final _globalFunction = GlobalFunction();
  final _globalWidget = GlobalWidget();
  final _shimmerLoading = ShimmerLoading();

  List<SearchProductModel> searchProductData = List();

  SearchProductBloc _searchProductBloc;
  int _apiPage = 0;
  ScrollController _scrollController = ScrollController();
  bool _lastData = false;
  bool _processApi = false;

  CancelToken apiToken = CancelToken(); // used to cancel fetch data from API

  bool _fromWhiteStatusBarForeground = false;

  TextEditingController _etSearch = TextEditingController();

  // create sort filter data
  List<String> _sortList;
  int _sortIndex = 0;

  // create other filter 1 data
  List<String> _otherFilterOneList;
  int _otherFilterOneIndex = 0;

  // create other filter 2 data
  List<String> _otherFilterTwoList;
  int _otherFilterTwoIndex = 0;

  // create other filter 3 data
  List<String> _otherFilterThreeList;
  int _otherFilterThreeIndex = 0;

  @override
  void initState() {
    // get data when initState
    _searchProductBloc = BlocProvider.of<SearchProductBloc>(context);
    _searchProductBloc.add(GetSearchProduct(
        sessionId: SESSION_ID,
        search: widget.words,
        skip: _apiPage.toString(),
        limit: LIMIT_PAGE.toString(),
        apiToken: apiToken));

    _fromWhiteStatusBarForeground = widget.fromWhite;

    _etSearch.text = widget.words;

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      _initForLang();
    });

    super.initState();
  }

  void _initForLang() {
    setState(() {
      _sortList = [
        'Relevant Product',
        'Review',
        'Newest Product',
        'Highest Price',
        'Lowest Price'
      ];
      _otherFilterOneList = ['Filter 1', 'Filter 2', 'Filter 3', 'Filter 4'];
      _otherFilterTwoList = [
        'Filter 1',
        'Filter 2',
        'Filter 3',
        'Filter 4',
        'Filter 5',
        'Filter 6',
        'Filter 7'
      ];
      _otherFilterThreeList = [
        'Filter 1',
        'Filter 2',
        'Filter 3',
        'Filter 4',
        'Filter 5',
        'Filter 6',
        'Filter 7',
        'Filter 8',
        'Filter 9',
        'Filter 10'
      ];
    });
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
        _searchProductBloc.add(GetSearchProduct(
            sessionId: SESSION_ID,
            search: widget.words,
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
          titleSpacing: 0.0,
          iconTheme: IconThemeData(
            color: Colors.black, //change your color here
          ),
          backgroundColor: Colors.white,
          elevation: 0,
          title: Container(
            margin: EdgeInsets.only(right: 16),
            child: SizedBox(
                width: double.maxFinite,
                child: FlatButton(
                  shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(5),
                  ),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => SearchPage()));
                  },
                  color: Colors.grey[100],
                  child: Row(
                    children: [
                      Icon(Icons.search, color: Colors.grey[500], size: 18),
                      SizedBox(width: 8),
                      Text(
                        widget.words,
                        style: TextStyle(
                            fontSize: 13,
                            color: Colors.grey[600],
                            fontWeight: FontWeight.normal),
                      )
                    ],
                  ),
                )),
          ),
          actions: [
            /*GestureDetector(
              onTap: () {
                showModalBottomSheet<void>(
                  context: context,
                  builder: (BuildContext context) {
                    return _showFilterPopup();
                  },
                );
              },
              child: Container(
                margin: EdgeInsets.only(right: 16),
                child: Icon(Icons.filter_list, color: BLACK_GREY),
              ),
            ),*/
          ],
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
          child: BlocListener<SearchProductBloc, SearchProductState>(
            listener: (context, state) {
              if (state is SearchProductError) {
                _globalFunction.showToast(
                    type: 'error', message: state.errorMessage);
              }
              if (state is GetSearchProductSuccess) {
                if (state.searchProductData.length == 0) {
                  _lastData = true;
                } else {
                  _apiPage += LIMIT_PAGE;
                  searchProductData.addAll(state.searchProductData);
                }
                _processApi = false;
              }
            },
            child: BlocBuilder<SearchProductBloc, SearchProductState>(
              builder: (context, state) {
                if (state is SearchProductError) {
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
                                    .translate('no_search_product'),
                                style: TextStyle(
                                    fontSize: 14, color: BLACK_GREY))));
                  } else {
                    print('nothing searched');
                    if (searchProductData.length == 0) {
                      return _shimmerLoading.buildShimmerProduct(
                          ((MediaQuery.of(context).size.width) - 24) / 2 - 12);
                    } else {
                      print('search ok');
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
                                    return _buildSearchProductCard(index);
                                  },
                                  childCount: searchProductData.length,
                                ),
                              ),
                            ),
                            SliverToBoxAdapter(
                              child: (_apiPage == LIMIT_PAGE &&
                                      searchProductData.length < LIMIT_PAGE)
                                  ? Wrap()
                                  : _globalWidget
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

  Widget _showFilterPopup() {
    // must use StateSetter to update data between main screen and popup.
    // if use default setState, the data will not update
    return StatefulBuilder(
        builder: (BuildContext context, StateSetter mystate) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              margin: EdgeInsets.only(top: 12, bottom: 12),
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                  color: Colors.grey[500],
                  borderRadius: BorderRadius.circular(10)),
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(16, 8, 16, 8),
            child: Text(AppLocalizations.of(context).translate('filter'),
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          ),
          Flexible(
            child: ListView(
              padding: EdgeInsets.all(16),
              children: <Widget>[
                Text(AppLocalizations.of(context).translate('sort'),
                    style: GlobalStyle.filterTitle),
                Wrap(
                  children: List.generate(_sortList.length, (index) {
                    return _radioSort(_sortList[index], index, mystate);
                  }),
                ),
                SizedBox(
                  height: 24,
                ),
                Text(
                    AppLocalizations.of(context).translate('other_filter') +
                        ' 1',
                    style: GlobalStyle.filterTitle),
                Wrap(
                  children: List.generate(_otherFilterOneList.length, (index) {
                    return _otherFilterOneSort(
                        _otherFilterOneList[index], index, mystate);
                  }),
                ),
                SizedBox(
                  height: 24,
                ),
                Text(
                    AppLocalizations.of(context).translate('other_filter') +
                        ' 2',
                    style: GlobalStyle.filterTitle),
                Wrap(
                  children: List.generate(_otherFilterTwoList.length, (index) {
                    return _otherFilterTwoSort(
                        _otherFilterTwoList[index], index, mystate);
                  }),
                ),
                SizedBox(
                  height: 24,
                ),
                Text(
                    AppLocalizations.of(context).translate('other_filter') +
                        ' 3',
                    style: GlobalStyle.filterTitle),
                Wrap(
                  children:
                      List.generate(_otherFilterThreeList.length, (index) {
                    return _otherFilterThreeSort(
                        _otherFilterThreeList[index], index, mystate);
                  }),
                ),
              ],
            ),
          ),
        ],
      );
    });
  }

  Widget _radioSort(String txt, int index, mystate) {
    return GestureDetector(
      onTap: () {
        mystate(() {
          _sortIndex = index;
        });
      },
      child: Container(
        padding: EdgeInsets.fromLTRB(12, 8, 12, 8),
        margin: EdgeInsets.only(right: 8, top: 8),
        decoration: BoxDecoration(
            color: _sortIndex == index ? SOFT_BLUE : Colors.white,
            border: Border.all(
                width: 1,
                color: _sortIndex == index ? SOFT_BLUE : Colors.grey[300]),
            borderRadius: BorderRadius.all(
                Radius.circular(10) //         <--- border radius here
                )),
        child: Text(txt,
            style: TextStyle(
                color: _sortIndex == index ? Colors.white : CHARCOAL)),
      ),
    );
  }

  Widget _otherFilterOneSort(String txt, int index, mystate) {
    return GestureDetector(
      onTap: () {
        mystate(() {
          _otherFilterOneIndex = index;
        });
      },
      child: Container(
        padding: EdgeInsets.fromLTRB(12, 8, 12, 8),
        margin: EdgeInsets.only(right: 8, top: 8),
        decoration: BoxDecoration(
            color: _otherFilterOneIndex == index ? SOFT_BLUE : Colors.white,
            border: Border.all(
                width: 1,
                color: _otherFilterOneIndex == index
                    ? SOFT_BLUE
                    : Colors.grey[300]),
            borderRadius: BorderRadius.all(
                Radius.circular(10) //         <--- border radius here
                )),
        child: Text(txt,
            style: TextStyle(
                color:
                    _otherFilterOneIndex == index ? Colors.white : CHARCOAL)),
      ),
    );
  }

  Widget _otherFilterTwoSort(String txt, int index, mystate) {
    return GestureDetector(
      onTap: () {
        mystate(() {
          _otherFilterTwoIndex = index;
        });
      },
      child: Container(
        padding: EdgeInsets.fromLTRB(12, 8, 12, 8),
        margin: EdgeInsets.only(right: 8, top: 8),
        decoration: BoxDecoration(
            color: _otherFilterTwoIndex == index ? SOFT_BLUE : Colors.white,
            border: Border.all(
                width: 1,
                color: _otherFilterTwoIndex == index
                    ? SOFT_BLUE
                    : Colors.grey[300]),
            borderRadius: BorderRadius.all(
                Radius.circular(10) //         <--- border radius here
                )),
        child: Text(txt,
            style: TextStyle(
                color:
                    _otherFilterTwoIndex == index ? Colors.white : CHARCOAL)),
      ),
    );
  }

  Widget _otherFilterThreeSort(String txt, int index, mystate) {
    return GestureDetector(
      onTap: () {
        mystate(() {
          _otherFilterThreeIndex = index;
        });
      },
      child: Container(
        padding: EdgeInsets.fromLTRB(12, 8, 12, 8),
        margin: EdgeInsets.only(right: 8, top: 8),
        decoration: BoxDecoration(
            color: _otherFilterThreeIndex == index ? SOFT_BLUE : Colors.white,
            border: Border.all(
                width: 1,
                color: _otherFilterThreeIndex == index
                    ? SOFT_BLUE
                    : Colors.grey[300]),
            borderRadius: BorderRadius.all(Radius.circular(10))),
        child: Text(txt,
            style: TextStyle(
                color:
                    _otherFilterThreeIndex == index ? Colors.white : CHARCOAL)),
      ),
    );
  }

  Widget _buildSearchProductCard(index) {
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
                          name: searchProductData[index].name,
                          image: searchProductData[index].image,
                          price: searchProductData[index].price,
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
                              searchProductData[index].image)),
              Container(
                margin: EdgeInsets.fromLTRB(8, 8, 8, 8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      searchProductData[index].name,
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
                              '\₦' +
                                  _globalFunction.removeDecimalZeroFormat(
                                      searchProductData[index].price),
                              style: GlobalStyle.productPrice),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 5),
                      child: Row(
                        children: [
                          //Icon(Icons.location_on, color: SOFT_GREY, size: 12),
                          //Text(' ' + searchProductData[index].location,
                          //    style: GlobalStyle.productLocation)
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 5),
                      child: Row(
                        children: [
                          _globalWidget.createRatingBar(0),
                          Text('(0)', style: GlobalStyle.productTotalReview)
                        ],
                      ),
                    )
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
