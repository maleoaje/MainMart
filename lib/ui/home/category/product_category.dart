/*
This is product category page

include file in reuseable/global_function.dart to call function from GlobalFunction
include file in reuseable/global_widget.dart to call function from GlobalWidget
include file in reuseable/cache_image_network.dart to use cache image network
include file in reuseable/shimmer_loading.dart to use shimmer loading
include file in model/home/category/category_model.dart to get categoryData

install plugin in pubspec.yaml
- carousel_slider => slider images (https://pub.dev/packages/carousel_slider)
- flutter_statusbarcolor => to change status bar color and navigation status bar color (at the very top of the screen) (https://pub.dev/packages/flutter_statusbarcolor)

Don't forget to add all images and sound used in this pages at the pubspec.yaml
 */

import 'dart:async';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:ijshopflutter/bloc/home/category/category_all_product/bloc.dart';
import 'package:ijshopflutter/bloc/home/category/category_by_id/bloc.dart';
import 'package:ijshopflutter/bloc/home/category/category_banner/bloc.dart';
import 'package:ijshopflutter/bloc/home/category/category_new_product/bloc.dart';
import 'package:ijshopflutter/config/constants.dart';
import 'package:ijshopflutter/config/global_style.dart';
import 'package:ijshopflutter/config/static_variable.dart';
import 'package:ijshopflutter/model/home/category/category_all_product_model.dart';
import 'package:ijshopflutter/model/home/category/category_by_id.dart';
import 'package:ijshopflutter/model/home/category/category_banner_model.dart';
import 'package:ijshopflutter/model/home/category/category_new_product_model.dart';
import 'package:ijshopflutter/ui/general/product_detail/product_detail.dart';
import 'package:ijshopflutter/ui/home/homebanner.dart';
import 'package:ijshopflutter/ui/reuseable/app_localizations.dart';
import 'package:ijshopflutter/ui/reuseable/cache_image_network.dart';
import 'package:ijshopflutter/ui/home/search/search.dart';
import 'package:ijshopflutter/ui/reuseable/global_function.dart';
import 'package:ijshopflutter/ui/reuseable/global_widget.dart';
import 'package:ijshopflutter/ui/reuseable/shimmer_loading.dart';

class ProductCategoryPage extends StatefulWidget {
  final int categoryId;
  final String categoryName;
  final Icon categoryIcon;

  const ProductCategoryPage(
      {Key key, this.categoryId, this.categoryName, this.categoryIcon})
      : super(key: key);
  @override
  _ProductCategoryPageState createState() => _ProductCategoryPageState();
}

class _ProductCategoryPageState extends State<ProductCategoryPage> {
  // initialize global function, global widget and shimmer loading
  final _globalFunction = GlobalFunction();
  final _globalWidget = GlobalWidget();
  final _shimmerLoading = ShimmerLoading();

  ScrollController _scrollController = ScrollController();

  List<CategoryBannerModel> categoryBannerData = List();
  CategoryBannerBloc _categoryBannerBloc;
  bool _lastDataCategoryBanner = false;

  List<CategoryNewProductModel> categoryNewProductData = List();
  CategoryNewProductBloc _categoryNewProductBloc;
  bool _lastDataCategoryNewProduct = false;

  List<CategoryAllProductModel> categoryAllProductData = List();
  CategoryAllProductBloc _categoryAllProductBloc;
  int _apiPageCategoryAllProduct = 0;
  bool _lastDataCategoryAllProduct = false;
  bool _processApiCategoryAllProduct = false;

  List<CategoryByIdModel> categoryByIdData = List();
  CategoryByIdBloc _categoryByIdBloc;
  int _apiPageCategoryById = 0;
  bool _lastDataCategoryById = false;
  bool _processApiCategoryById = false;

  CancelToken apiToken = CancelToken(); // used to cancel fetch data from API

  bool _fromWhiteStatusBarForeground = false;

  int _currentImageSlider = 0;

  @override
  void initState() {
    // get data when initState
    _categoryBannerBloc = BlocProvider.of<CategoryBannerBloc>(context);
    _categoryBannerBloc.add(GetCategoryBanner(
        sessionId: SESSION_ID,
        categoryId: widget.categoryId,
        apiToken: apiToken));

    _categoryNewProductBloc = BlocProvider.of<CategoryNewProductBloc>(context);
    _categoryNewProductBloc.add(GetCategoryNewProduct(
        sessionId: SESSION_ID,
        categoryId: widget.categoryId,
        skip: '0',
        limit: '1',
        apiToken: apiToken));

    _categoryAllProductBloc = BlocProvider.of<CategoryAllProductBloc>(context);
    _categoryAllProductBloc.add(GetCategoryAllProduct(
        sessionId: SESSION_ID,
        categoryId: widget.categoryId,
        skip: _apiPageCategoryAllProduct.toString(),
        limit: LIMIT_PAGE.toString(),
        apiToken: apiToken));

    _categoryByIdBloc = BlocProvider.of<CategoryByIdBloc>(context);
    _categoryByIdBloc.add(GetCategoryById(
        sessionId: SESSION_ID,
        categoryId: widget.categoryId,
        skip: _apiPageCategoryById.toString(),
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

    super.dispose();
  }

  // this function used to fetch data from API if we scroll to the bottom of the page
  void _onScroll() {
    double maxScroll = _scrollController.position.maxScrollExtent;
    double currentScroll = _scrollController.position.pixels;

    /*
    only for home.dart, flashsale.dart and product_category.dart
    you need to check if the skip == 0, use timer
     */
    if (_apiPageCategoryAllProduct == 0) {
      Timer(Duration(milliseconds: 3000), () {
        if (currentScroll == maxScroll) {
          if (_lastDataCategoryAllProduct == false &&
              !_processApiCategoryAllProduct) {
            _categoryAllProductBloc.add(GetCategoryAllProduct(
                sessionId: SESSION_ID,
                categoryId: widget.categoryId,
                skip: _apiPageCategoryAllProduct.toString(),
                limit: LIMIT_PAGE.toString(),
                apiToken: apiToken));
            _processApiCategoryAllProduct = true;
          }
        }
      });
    } else {
      if (currentScroll == maxScroll) {
        if (_lastDataCategoryAllProduct == false &&
            !_processApiCategoryAllProduct) {
          _categoryAllProductBloc.add(GetCategoryAllProduct(
              sessionId: SESSION_ID,
              categoryId: widget.categoryId,
              skip: _apiPageCategoryAllProduct.toString(),
              limit: LIMIT_PAGE.toString(),
              apiToken: apiToken));
          _processApiCategoryAllProduct = true;
        }
      }
    }

    if (_apiPageCategoryById == 0) {
      Timer(Duration(milliseconds: 3000), () {
        if (currentScroll == maxScroll) {
          if (_lastDataCategoryById == false && !_processApiCategoryById) {
            _categoryByIdBloc.add(GetCategoryById(
                sessionId: SESSION_ID,
                categoryId: widget.categoryId,
                skip: _apiPageCategoryById.toString(),
                limit: LIMIT_PAGE.toString(),
                apiToken: apiToken));
            _processApiCategoryById = true;
          }
        }
      });
    } else {
      if (currentScroll == maxScroll) {
        if (_lastDataCategoryById == false && !_processApiCategoryById) {
          _categoryByIdBloc.add(GetCategoryById(
              sessionId: SESSION_ID,
              categoryId: widget.categoryId,
              skip: _apiPageCategoryById.toString(),
              limit: LIMIT_PAGE.toString(),
              apiToken: apiToken));
          _processApiCategoryById = true;
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final double boxImageSize = (MediaQuery.of(context).size.width / 3);
    _scrollController.addListener(_onScroll);

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        elevation: 0,
        title: Text(
          widget.categoryName.replaceAll('\n', ' '),
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
        child: MultiBlocListener(
          listeners: [
            /*
            BlocListener<CategoryNewProductBloc, CategoryNewProductState>(
              listener: (context, state) {
                if (state is CategoryNewProductError) {
                  _globalFunction.showToast(
                      type: 'error', message: state.errorMessage);
                }
                if (state is GetCategoryNewProductSuccess) {
                  if (state.categoryNewProductData.length == 0) {
                    _lastDataCategoryNewProduct = true;
                  } else {
                    categoryNewProductData.addAll(state.categoryNewProductData);
                  }
                }
              },
            ),
            BlocListener<CategoryAllProductBloc, CategoryAllProductState>(
              listener: (context, state) {
                if (state is CategoryAllProductError) {
                  _globalFunction.showToast(
                      type: 'error', message: state.errorMessage);
                }
                if (state is GetCategoryAllProductSuccess) {
                  if (state.categoryAllProductData.length == 0) {
                    _lastDataCategoryAllProduct = true;
                  } else {
                    _apiPageCategoryAllProduct += LIMIT_PAGE;
                    categoryAllProductData.addAll(state.categoryAllProductData);
                  }
                  _processApiCategoryAllProduct = false;
                }
              },
            ),*/
            BlocListener<CategoryByIdBloc, CategoryByIdState>(
              listener: (context, state) {
                if (state is CategoryByIdError) {
                  _globalFunction.showToast(
                      type: 'error', message: state.errorMessage);
                }
                if (state is GetCategoryByIdSuccess) {
                  if (state.categoryByIdData.length == 0) {
                    _lastDataCategoryById = true;
                  } else {
                    _apiPageCategoryById += LIMIT_PAGE;
                    categoryByIdData.addAll(state.categoryByIdData);
                  }
                  _processApiCategoryById = false;
                }
              },
            )
          ],
          child: ListView(
            controller: _scrollController,
            children: [
              _createCategorySlider(),
              Container(
                margin: EdgeInsets.only(top: 20, left: 16, right: 16),
                child: Text('Products', style: GlobalStyle.sectionTitle),
              ),
              /*BlocBuilder<CategoryAllProductBloc, CategoryAllProductState>(
                builder: (context, state) {
                  if (state is CategoryAllProductError) {
                    return Container(
                        child: Center(
                            child: Text(ERROR_OCCURED,
                                style: TextStyle(
                                    fontSize: 14, color: BLACK_GREY))));
                  } else {
                    if (_lastDataCategoryAllProduct &&
                        _apiPageCategoryAllProduct == 0) {
                      return Container(
                          height: 200,
                          child: Center(
                            child: Text(
                                AppLocalizations.of(context)
                                    .translate('no_product'),
                                style:
                                    TextStyle(fontSize: 14, color: BLACK_GREY)),
                          ));
                    } else {
                      if (categoryAllProductData.length == 0) {
                        //print('e no load o');
                        return _shimmerLoading.buildShimmerProduct(
                            ((MediaQuery.of(context).size.width) - 24) / 2 -
                                12);
                      } else {
                        //print('e load ');
                        return CustomScrollView(
                            shrinkWrap: true,
                            primary: false,
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
                                      return _buildAllProductCard(index);
                                    },
                                    childCount: categoryAllProductData.length,
                                  ),
                                ),
                              ),
                              SliverToBoxAdapter(
                                child: _globalWidget.buildProgressIndicator(
                                    _lastDataCategoryAllProduct),
                              ),
                            ]);
                      }
                    }
                  }
                },
              ),*/
              BlocBuilder<CategoryByIdBloc, CategoryByIdState>(
                builder: (context, state) {
                  if (state is CategoryByIdError) {
                    return Container(
                        child: Center(
                            child: Text(ERROR_OCCURED,
                                style: TextStyle(
                                    fontSize: 14, color: BLACK_GREY))));
                  } else {
                    if (_lastDataCategoryById && _apiPageCategoryById == 0) {
                      return Container(
                          height: 200,
                          child: Center(
                            child: Text(
                                AppLocalizations.of(context)
                                    .translate('no_product'),
                                style:
                                    TextStyle(fontSize: 14, color: BLACK_GREY)),
                          ));
                    } else {
                      if (categoryByIdData.length == 0) {
                        //print('e no load o');
                        return _shimmerLoading.buildShimmerProduct(
                            ((MediaQuery.of(context).size.width) - 24) / 2 -
                                12);
                      } else {
                        //print('e load ');
                        return CustomScrollView(
                            shrinkWrap: true,
                            primary: false,
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
                                      return _buildByIdCard(index);
                                    },
                                    childCount: categoryByIdData.length,
                                  ),
                                ),
                              ),
                              SliverToBoxAdapter(
                                child: _globalWidget.buildProgressIndicator(
                                    _lastDataCategoryById),
                              ),
                            ]);
                      }
                    }
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _createCategorySlider() {
    List cardList = [Item1(), Item2(), Item3()];

    List<T> map<T>(List list, Function handler) {
      List<T> result = [];
      for (var i = 0; i < list.length; i++) {
        result.add(handler(i, list[i]));
      }
      return result;
    }

    return Column(children: [
      CarouselSlider(
        items: cardList.map((card) {
          return Builder(builder: (BuildContext context) {
            return Container(
              //height: MediaQuery.of(context).size.height,
              //width: MediaQuery.of(context).size.width,
              child: Card(
                child: card,
              ),
            );
          });
        }).toList(),
        options: CarouselOptions(
            //aspectRatio: 8 / 6,
            viewportFraction: 1.0,
            autoPlay: true,
            autoPlayInterval: Duration(seconds: 6),
            autoPlayAnimationDuration: Duration(milliseconds: 300),
            enlargeCenterPage: false,
            onPageChanged: (index, reason) {
              setState(() {
                _currentImageSlider = index;
              });
            }),
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: cardList.map((card) {
          int index = cardList.indexOf(card);
          return Container(
            width: 8.0,
            height: 8.0,
            margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: _currentImageSlider == index
                  ? PRIMARY_COLOR
                  : Colors.grey[300],
            ),
          );
        }).toList(),
      ),
    ]);
  }

  Widget _buildAllProductCard(index) {
    final double boxImageSize =
        ((MediaQuery.of(context).size.width) - 30) / 2 - 15;
    return Container(
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        elevation: 0.5,
        color: Colors.white,
        child: GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProductDetailPage(
                  fromWhite: null,
                  name: categoryAllProductData[index].name,
                  price: categoryAllProductData[index].price,
                  image: categoryAllProductData[index].image,
                  description: categoryAllProductData[index].description,
                  summary: categoryAllProductData[index].summary,
                ),
              ),
            );
          },
          child: Column(
            children: <Widget>[
              ClipRRect(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(5),
                      topRight: Radius.circular(5)),
                  child: buildCacheNetworkImage(
                    width: boxImageSize,
                    height: boxImageSize,
                    url: 'https://apistore.mainmart.com.ng/Resources/Images/' +
                        categoryAllProductData[index].image,
                  )),
              Container(
                margin: EdgeInsets.fromLTRB(6, 6, 6, 6),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      categoryAllProductData[index].name,
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
                                      categoryAllProductData[index].price),
                              style: GlobalStyle.productPrice),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 5),
                      child: Row(
                        children: [
                          Icon(Icons.location_on, color: SOFT_GREY, size: 12),
                          Text('MainMart Stores',
                              style: GlobalStyle.productLocation)
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 5),
                      child: Row(
                        children: [
                          _globalWidget.createRatingBar(4.5),
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

  Widget _buildByIdCard(index) {
    final double boxImageSize =
        ((MediaQuery.of(context).size.width) - 30) / 2 - 15;
    return Container(
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        elevation: 0.5,
        color: Colors.white,
        child: GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProductDetailPage(
                  fromWhite: null,
                  name: categoryByIdData[index].name,
                  price: categoryByIdData[index].price,
                  image: categoryByIdData[index].image,
                  description: categoryByIdData[index].description,
                  summary: categoryByIdData[index].summary,
                ),
              ),
            );
          },
          child: Column(
            children: <Widget>[
              ClipRRect(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(5),
                      topRight: Radius.circular(5)),
                  child: buildCacheNetworkImage(
                    width: boxImageSize,
                    height: boxImageSize,
                    url: 'https://apistore.mainmart.com.ng/Resources/Images/' +
                        categoryByIdData[index].image,
                  )),
              Container(
                margin: EdgeInsets.fromLTRB(6, 6, 6, 6),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      categoryByIdData[index].name,
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
                                      categoryByIdData[index].price),
                              style: GlobalStyle.productPrice),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 5),
                      child: Row(
                        children: [
                          Icon(Icons.location_on, color: SOFT_GREY, size: 12),
                          Text('MainMart Stores',
                              style: GlobalStyle.productLocation)
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 5),
                      child: Row(
                        children: [
                          _globalWidget.createRatingBar(4.5),
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
