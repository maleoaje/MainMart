/*
This is home page

For this homepage, appBar is created at the bottom after CustomScrollView
we used AutomaticKeepAliveClientMixin to keep the state when moving from 1 navbar to another navbar, so the page is not refresh overtime

include file in reuseable/global_function.dart to call function from GlobalFunction
include file in reuseable/global_widget.dart to call function from GlobalWidget
include file in reuseable/cache_image_network.dart to use cache image network
include file in reuseable/shimmer_loading.dart to use shimmer loading
include file in model/home/category/category_for_you_model.dart to get categoryForYouData
include file in model/home/category/category_model.dart to get categoryData
include file in model/home/coupon_model.dart to get couponData
include file in model/home/flashsale_model.dart to get flashsaleData
include file in model/home/home_banner_model.dart to get homeBannerData
include file in model/home/last_search_model.dart to get lastSearchData
include file in model/home/trending_model.dart to get homeTrendingData
include file in model/home/recomended_product_model.dart to get recomendedProductData

install plugin in pubspec.yaml
- carousel_slider => slider images (https://pub.dev/packages/carousel_slider)
- flutter_statusbarcolor => to change status bar color and navigation status bar color (at the very top of the screen) (https://pub.dev/packages/flutter_statusbarcolor)
- fluttertoast => to show toast (https://pub.dev/packages/fluttertoast)

Don't forget to add all images and sound used in this pages at the pubspec.yaml
 */

import 'dart:async';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:ijshopflutter/bloc/home/category/category/bloc.dart';
import 'package:ijshopflutter/bloc/home/flashsale/bloc.dart';
import 'package:ijshopflutter/bloc/home/home_banner/bloc.dart';
import 'package:ijshopflutter/bloc/home/home_trending/bloc.dart';
import 'package:ijshopflutter/bloc/home/last_search/bloc.dart';
import 'package:ijshopflutter/bloc/home/recomended_product/bloc.dart';
import 'package:ijshopflutter/config/constants.dart';
import 'package:ijshopflutter/config/global_style.dart';
import 'package:ijshopflutter/config/static_variable.dart';
import 'package:ijshopflutter/model/home/category/category_model.dart';
import 'package:ijshopflutter/model/home/flashsale_model.dart';
import 'package:ijshopflutter/model/home/home_banner_model.dart';
import 'package:ijshopflutter/model/home/last_search_model.dart';
import 'package:ijshopflutter/model/home/trending_model.dart';
import 'package:ijshopflutter/model/home/recomended_product_model.dart';
import 'package:ijshopflutter/ui/general/chat_us.dart';
import 'package:ijshopflutter/ui/home/flashsale.dart';
import 'package:ijshopflutter/ui/home/homebanner.dart';
import 'package:ijshopflutter/ui/home/last_search.dart';
import 'package:ijshopflutter/ui/general/product_detail/product_detail.dart';
import 'package:ijshopflutter/ui/general/notification.dart';
import 'package:ijshopflutter/ui/home/category/product_category.dart';
import 'package:ijshopflutter/ui/home/search/search_product.dart';
import 'package:ijshopflutter/ui/reuseable/app_localizations.dart';
import 'package:ijshopflutter/ui/reuseable/cache_image_network.dart';
import 'package:ijshopflutter/ui/home/search/search.dart';
import 'package:ijshopflutter/ui/reuseable/global_function.dart';
import 'package:ijshopflutter/ui/reuseable/global_widget.dart';
import 'package:ijshopflutter/ui/reuseable/shimmer_loading.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  // initialize global function, global widget and shimmer loading
  final _globalFunction = GlobalFunction();
  final _globalWidget = GlobalWidget();
  final _shimmerLoading = ShimmerLoading();

  List<HomeBannerModel> homeBannerData = List();
  List<FlashsaleModel> flashsaleData = List();
  List<LastSearchModel> lastSearchData = List();
  List<HomeTrendingModel> homeTrendingData = List();

  List<CategoryModel> categoryData = List();

  HomeBannerBloc _homeBannerBloc;

  FlashsaleBloc _flashsaleBloc;
  bool _lastDataFlashsale = false;

  LastSearchBloc _lastSearchBloc;
  bool _lastDataSeach = false;

  HomeTrendingBloc _homeTrendingBloc;
  bool _lastDataTrending = false;
  CategoryBloc _categoryBloc;
  bool _lastDataCategory = false;

  List<RecomendedProductModel> recomendedProductData = List();
  RecomendedProductBloc _recomendedProductBloc;
  int _apiPageRecomended = 0;
  bool _lastDataRecomended = false;
  bool _processApiRecomended = false;

  CancelToken apiToken = CancelToken(); // used to cancel fetch data from API

  int _currentImageSlider = 0;

  ScrollController _scrollController;
  Color _topIconColor = Colors.white;
  Color _topSearchColor = Colors.white;
  AnimationController _topColorAnimationController;
  Animation _appBarColor;

  // keep the state to do not refresh when switch navbar
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    // get data when initState
    _homeBannerBloc = BlocProvider.of<HomeBannerBloc>(context);
    _homeBannerBloc
        .add(GetHomeBanner(sessionId: SESSION_ID, apiToken: apiToken));

    _flashsaleBloc = BlocProvider.of<FlashsaleBloc>(context);
    _flashsaleBloc.add(GetFlashsaleHome(
        sessionId: SESSION_ID, skip: '0', limit: '8', apiToken: apiToken));

    _lastSearchBloc = BlocProvider.of<LastSearchBloc>(context);
    _lastSearchBloc.add(GetLastSearchHome(
        sessionId: SESSION_ID, skip: '0', limit: '8', apiToken: apiToken));

    _homeTrendingBloc = BlocProvider.of<HomeTrendingBloc>(context);
    _homeTrendingBloc.add(GetHomeTrending(
        sessionId: SESSION_ID, skip: '0', limit: '8', apiToken: apiToken));

    _categoryBloc = BlocProvider.of<CategoryBloc>(context);
    _categoryBloc.add(GetCategory(sessionId: SESSION_ID, apiToken: apiToken));

    _recomendedProductBloc = BlocProvider.of<RecomendedProductBloc>(context);
    _recomendedProductBloc.add(GetRecomendedProduct(
        sessionId: SESSION_ID,
        skip: _apiPageRecomended.toString(),
        limit: LIMIT_PAGE.toString(),
        apiToken: apiToken));

    setupAnimateAppbar();

    super.initState();
  }

  @override
  void dispose() {
    apiToken.cancel("cancelled"); // cancel fetch data from API

    _scrollController.dispose();
    _topColorAnimationController.dispose();

    super.dispose();
  }

  void setupAnimateAppbar() {
    // use this function and paramater to animate top bar
    _topColorAnimationController =
        AnimationController(vsync: this, duration: Duration(seconds: 0));
    _appBarColor = ColorTween(begin: Colors.transparent, end: Colors.white)
        .animate(_topColorAnimationController);
    _scrollController = ScrollController()
      ..addListener(() {
        _topColorAnimationController.animateTo(_scrollController.offset / 120);
        // if scroll for above 150, then change app bar color to white, search button to dark, and top icon color to dark
        // if scroll for below 150, then change app bar color to transparent, search button to white and top icon color to light
        if (_scrollController.hasClients &&
            _scrollController.offset > (150 - kToolbarHeight)) {
          if (_topIconColor != BLACK_GREY) {
            StaticVariable.homeIsScroll = true;
            StaticVariable.useWhiteStatusBarForeground = false;
            FlutterStatusbarcolor.setStatusBarWhiteForeground(false);
            _topIconColor = BLACK_GREY;
            _topSearchColor = Colors.grey[100];
          }
        } else {
          if (_topIconColor != Colors.white) {
            StaticVariable.homeIsScroll = false;
            StaticVariable.useWhiteStatusBarForeground = true;
            FlutterStatusbarcolor.setStatusBarWhiteForeground(true);
            _topIconColor = Colors.white;
            _topSearchColor = Colors.white;
          }
        }

        // this function used to fetch data from API if we scroll to the bottom of the page
        double maxScroll = _scrollController.position.maxScrollExtent;
        double currentScroll = _scrollController.position.pixels;

        /*
      only for home.dart, flashsale.dart and product_category.dart
      you need to check if the skip == 0, use timer
     */
        if (_apiPageRecomended == 0) {
          Timer(Duration(milliseconds: 3000), () {
            if (currentScroll == maxScroll) {
              if (_lastDataRecomended == false && !_processApiRecomended) {
                _recomendedProductBloc.add(GetRecomendedProduct(
                    sessionId: SESSION_ID,
                    skip: _apiPageRecomended.toString(),
                    limit: LIMIT_PAGE.toString(),
                    apiToken: apiToken));
                _processApiRecomended = true;
              }
            }
          });
        } else {
          if (currentScroll == maxScroll) {
            if (_lastDataRecomended == false && !_processApiRecomended) {
              _recomendedProductBloc.add(GetRecomendedProduct(
                  sessionId: SESSION_ID,
                  skip: _apiPageRecomended.toString(),
                  limit: LIMIT_PAGE.toString(),
                  apiToken: apiToken));
              _processApiRecomended = true;
            }
          }
        }
      });
  }

  @override
  Widget build(BuildContext context) {
    // if we used AutomaticKeepAliveClientMixin, we must call super.build(context);
    super.build(context);

    final double boxImageSize = (MediaQuery.of(context).size.width / 3);

    return Scaffold(
      body: MultiBlocListener(
        listeners: [
          BlocListener<FlashsaleBloc, FlashsaleState>(
            listener: (context, state) {
              if (state is FlashsaleHomeError) {
                _globalFunction.showToast(
                    type: 'error', message: state.errorMessage);
              }
              if (state is GetFlashsaleHomeSuccess) {
                if (state.flashsaleData.length == 0) {
                  _lastDataFlashsale = true;
                } else {
                  flashsaleData.addAll(state.flashsaleData);
                }
              }
            },
          ),
          BlocListener<LastSearchBloc, LastSearchState>(
            listener: (context, state) {
              if (state is LastSearchHomeError) {
                _globalFunction.showToast(
                    type: 'error', message: state.errorMessage);
              }
              if (state is GetLastSearchHomeSuccess) {
                if (state.lastSearchData.length == 0) {
                  _lastDataSeach = true;
                } else {
                  lastSearchData.addAll(state.lastSearchData);
                }
              }
            },
          ),
          BlocListener<HomeTrendingBloc, HomeTrendingState>(
            listener: (context, state) {
              if (state is HomeTrendingError) {
                _globalFunction.showToast(
                    type: 'error', message: state.errorMessage);
              }
              if (state is GetHomeTrendingSuccess) {
                homeTrendingData.addAll(state.homeTrendingData);
              }
            },
          ),
          BlocListener<RecomendedProductBloc, RecomendedProductState>(
            listener: (context, state) {
              if (state is RecomendedProductError) {
                _globalFunction.showToast(
                    type: 'error', message: state.errorMessage);
              }
              if (state is GetRecomendedProductSuccess) {
                if (state.recomendedProductData.length == 0) {
                  _lastDataRecomended = true;
                } else {
                  _apiPageRecomended += LIMIT_PAGE;
                  recomendedProductData.addAll(state.recomendedProductData);
                }
                _processApiRecomended = false;
              }
            },
          ),
          BlocListener<CategoryBloc, CategoryState>(
            listener: (context, state) {
              if (state is CategoryError) {
                _globalFunction.showToast(
                    type: 'error', message: state.errorMessage);
              }
              if (state is GetCategorySuccess) {
                if (state.categoryData.length == 0) {
                  _lastDataCategory = true;
                } else {
                  categoryData.addAll(state.categoryData);
                }
              }
            },
          ),
        ],
        child: RefreshIndicator(
          onRefresh: refreshData,
          child: Stack(
            children: [
              CustomScrollView(
                controller: _scrollController,
                slivers: [
                  SliverList(
                      delegate: SliverChildListDelegate([
                    _createHomeBannerSlider(),
                    Container(
                        margin: EdgeInsets.only(top: 10, left: 16, right: 16),
                        child: Text('Categories',
                            textAlign: TextAlign.left,
                            style: GlobalStyle.sectionTitle)),
                    _createGridCategory(),
                    Container(
                      margin: EdgeInsets.only(top: 10, left: 16, right: 16),
                      child:
                          Text('Hot Deals!', style: GlobalStyle.sectionTitle),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 4, left: 16, right: 16),
                      child: Row(
                        children: [
                          Text('Deals of the day!',
                              style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  fontSize: 13,
                                  color: CHARCOAL)),
                          //_buildFlashsaleTime(),
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => FlashSalePage(
                                          //seconds: _flashsaleSecond
                                          ),
                                    ));
                              },
                              child: Text(
                                  AppLocalizations.of(context)
                                      .translate('view_all'),
                                  style: GlobalStyle.viewAll,
                                  textAlign: TextAlign.end),
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 16),
                      height: boxImageSize *
                          GlobalStyle.horizontalProductHeightMultiplication,
                      child: BlocBuilder<FlashsaleBloc, FlashsaleState>(
                        builder: (context, state) {
                          if (state is FlashsaleHomeError) {
                            return Container(
                                child: Center(
                                    child: Text(ERROR_OCCURED,
                                        style: TextStyle(
                                            fontSize: 14, color: BLACK_GREY))));
                          } else {
                            if (_lastDataFlashsale) {
                              return Container(
                                  child: Center(
                                      child: Text(
                                          AppLocalizations.of(context)
                                              .translate('no_flash_sale'),
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: BLACK_GREY))));
                            } else {
                              if (flashsaleData.length == 0) {
                                return _shimmerLoading
                                    .buildShimmerHomeFlashsale(boxImageSize);
                              } else {
                                return ListView.builder(
                                  padding: EdgeInsets.only(left: 12, right: 12),
                                  scrollDirection: Axis.horizontal,
                                  itemCount: flashsaleData.length + 1,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    if (index == flashsaleData.length) {
                                      return _buildLastBox(
                                          boxImageSize, FlashSalePage());
                                    } else {
                                      return _buildFlashsaleCard(
                                          index, boxImageSize);
                                    }
                                  },
                                );
                              }
                            }
                          }
                        },
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 30, left: 16, right: 16),
                      child: Text('Best Selling Products',
                          style: GlobalStyle.sectionTitle),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(12, 0, 12, 0),
                      child: BlocBuilder<HomeTrendingBloc, HomeTrendingState>(
                        builder: (context, state) {
                          if (state is HomeTrendingError) {
                            // print('wahala');
                            return Container(
                                child: Center(
                                    child: Text(ERROR_OCCURED,
                                        style: TextStyle(
                                            fontSize: 14, color: BLACK_GREY))));
                          } else {
                            if (_lastDataTrending) {
                              // print('wahala2');
                              return Container(
                                  child: Center(
                                      child: Text(
                                          AppLocalizations.of(context)
                                              .translate('no_trending_product'),
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: BLACK_GREY))));
                            } else {
                              if (homeTrendingData.length == 0) {
                                //print('wahala3');
                                return _shimmerLoading.buildShimmerTrending(
                                    MediaQuery.of(context).size.width / 2);
                              } else {
                                //print('pass');
                                return GridView.count(
                                  padding: EdgeInsets.fromLTRB(0, 8, 0, 0),
                                  primary: false,
                                  childAspectRatio: 4 / 1.6,
                                  shrinkWrap: true,
                                  crossAxisSpacing: 2,
                                  mainAxisSpacing: 2,
                                  crossAxisCount: 2,
                                  children: List.generate(
                                      homeTrendingData.length, (index) {
                                    return _buildTrendingProductCard(index);
                                  }),
                                );
                              }
                            }
                          }
                        },
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 30, left: 16, right: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Featured Products',
                              style: GlobalStyle.sectionTitle),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => LastSearchPage()));
                            },
                            child: Text(
                                AppLocalizations.of(context)
                                    .translate('view_all'),
                                style: GlobalStyle.viewAll,
                                textAlign: TextAlign.end),
                          )
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 16),
                      height: boxImageSize *
                          GlobalStyle.horizontalProductHeightMultiplication,
                      child: BlocBuilder<LastSearchBloc, LastSearchState>(
                        builder: (context, state) {
                          if (state is LastSearchHomeError) {
                            return Container(
                                child: Center(
                                    child: Text(ERROR_OCCURED,
                                        style: TextStyle(
                                            fontSize: 14, color: BLACK_GREY))));
                          } else {
                            if (_lastDataSeach) {
                              return Container(
                                  child: Center(
                                      child: Text(
                                          AppLocalizations.of(context)
                                              .translate('no_last_search'),
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: BLACK_GREY))));
                            } else {
                              if (lastSearchData.length == 0) {
                                return _shimmerLoading
                                    .buildShimmerHorizontalProduct(
                                        boxImageSize);
                              } else {
                                return ListView.builder(
                                  padding: EdgeInsets.only(left: 12, right: 12),
                                  scrollDirection: Axis.horizontal,
                                  itemCount: lastSearchData.length + 1,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    if (index == lastSearchData.length) {
                                      return _buildLastBox(
                                          boxImageSize, LastSearchPage());
                                    } else {
                                      return _buildLastSearchCard(
                                          index, boxImageSize);
                                    }
                                  },
                                );
                              }
                            }
                          }
                        },
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 30, left: 16, right: 16),
                      child:
                          Text('New Arrivals', style: GlobalStyle.sectionTitle),
                    ),
                    BlocBuilder<RecomendedProductBloc, RecomendedProductState>(
                      builder: (context, state) {
                        if (state is RecomendedProductError) {
                          return Container(
                              child: Center(
                                  child: Text(ERROR_OCCURED,
                                      style: TextStyle(
                                          fontSize: 14, color: BLACK_GREY))));
                        } else {
                          if (_lastDataRecomended && _apiPageRecomended == 0) {
                            return Container(
                                child: Text(
                                    AppLocalizations.of(context)
                                        .translate('no_recomended_product'),
                                    style: TextStyle(
                                        fontSize: 14, color: BLACK_GREY)));
                          } else {
                            if (recomendedProductData.length == 0) {
                              return _shimmerLoading.buildShimmerProduct(
                                  ((MediaQuery.of(context).size.width) - 24) /
                                          2 -
                                      12);
                            } else {
                              return CustomScrollView(
                                  shrinkWrap: true,
                                  primary: false,
                                  slivers: <Widget>[
                                    SliverPadding(
                                      padding:
                                          EdgeInsets.fromLTRB(12, 8, 12, 8),
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
                                            return _buildRecomendedProductCard(
                                                index);
                                          },
                                          childCount:
                                              recomendedProductData.length,
                                        ),
                                      ),
                                    ),
                                    SliverToBoxAdapter(
                                      child:
                                          (_apiPageRecomended == LIMIT_PAGE &&
                                                  recomendedProductData.length <
                                                      LIMIT_PAGE)
                                              ? Wrap()
                                              : _globalWidget
                                                  .buildProgressIndicator(
                                                      _lastDataRecomended),
                                    ),
                                  ]);
                            }
                          }
                        }
                      },
                    ),
                  ])),
                ],
              ),
              // Create AppBar with Animation
              Container(
                height: 80,
                child: AnimatedBuilder(
                  animation: _topColorAnimationController,
                  builder: (context, child) => AppBar(
                    backgroundColor: _appBarColor.value,
                    elevation: 0,
                    title: Container(
                      child: SizedBox(
                          width: double.maxFinite,
                          child: RaisedButton(
                            elevation: 0,
                            splashColor: _topSearchColor,
                            highlightColor: _topSearchColor,
                            shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(5),
                            ),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SearchPage()));
                            },
                            color: _topSearchColor,
                            child: Row(
                              children: [
                                Icon(
                                  Icons.search,
                                  color: Colors.grey[500],
                                  size: 18,
                                ),
                                SizedBox(width: 8),
                                Text(
                                  AppLocalizations.of(context)
                                      .translate('search_product'),
                                  style: TextStyle(
                                      color: Colors.grey[500],
                                      fontWeight: FontWeight.normal),
                                )
                              ],
                            ),
                          )),
                    ),
                    actions: [
                      GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ChatUsPage()));
                          },
                          child: Icon(Icons.email, color: PRIMARY_COLOR)),
                      IconButton(
                          icon: _globalWidget.customNotifIcon(0, PRIMARY_COLOR),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => NotificationPage()));
                          }),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future refreshData() async {
    setState(() {
      _apiPageRecomended = 0;
      homeBannerData.clear();
      flashsaleData.clear();
      lastSearchData.clear();
      homeTrendingData.clear();
      categoryData.clear();
      recomendedProductData.clear();
      _homeBannerBloc
          .add(GetHomeBanner(sessionId: SESSION_ID, apiToken: apiToken));
      _flashsaleBloc.add(GetFlashsaleHome(
          sessionId: SESSION_ID, skip: '0', limit: '8', apiToken: apiToken));
      _lastSearchBloc.add(GetLastSearchHome(
          sessionId: SESSION_ID, skip: '0', limit: '8', apiToken: apiToken));
      _homeTrendingBloc.add(GetHomeTrending(
          sessionId: SESSION_ID, skip: '0', limit: '8', apiToken: apiToken));
      _categoryBloc.add(GetCategory(sessionId: SESSION_ID, apiToken: apiToken));
      _recomendedProductBloc.add(GetRecomendedProduct(
          sessionId: SESSION_ID,
          skip: _apiPageRecomended.toString(),
          limit: LIMIT_PAGE.toString(),
          apiToken: apiToken));
    });
  }

  Widget _createHomeBannerSlider() {
    List cardList = [Item1(), Item2(), Item3()];

    List<T> map<T>(List list, Function handler) {
      List<T> result = [];
      for (var i = 0; i < list.length; i++) {
        result.add(handler(i, list[i]));
      }
      return result;
    }

    return Column(children: [
      Padding(
        padding: const EdgeInsets.only(top: 70),
        child: CarouselSlider(
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

  Widget _createGridCategory() {
    return BlocBuilder<CategoryBloc, CategoryState>(
      builder: (context, state) {
        if (state is CategoryError) {
          return Container(
              child: Center(
                  child: Text(ERROR_OCCURED,
                      style: TextStyle(fontSize: 14, color: BLACK_GREY))));
        } else {
          if (_lastDataCategory) {
            return Wrap();
          } else {
            if (categoryData.length == 0) {
              return _shimmerLoading.buildShimmerCategory();
            } else {
              return GridView.count(
                padding: EdgeInsets.fromLTRB(16, 16, 16, 0),
                primary: false,
                childAspectRatio: 1.1,
                shrinkWrap: true,
                crossAxisSpacing: 0,
                mainAxisSpacing: 0,
                crossAxisCount: 4,
                children: List.generate(categoryData.length, (index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ProductCategoryPage(
                                    categoryId: categoryData[index].id,
                                    categoryName: categoryData[index].name,
                                  )));
                    },
                    child: Column(
                      children: [
                        categoryData[index].getIcon(categoryData[index].name),
                        //buildCacheNetworkImage(width: 40, height: 40, url: categoryData[index].image, plColor: Colors.transparent),
                        Flexible(
                          child: Container(
                            margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                            child: Text(
                              categoryData[index].name,
                              style: TextStyle(
                                color: CHARCOAL,
                                fontWeight: FontWeight.normal,
                                fontSize: 10,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        )
                      ],
                    ),
                  );
                }),
              );
            }
          }
        }
      },
    );
  }

  Widget _buildLastBox(boxImageSize, StatefulWidget page) {
    return Container(
      width: boxImageSize + 10,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        elevation: 0.5,
        color: Colors.white,
        child: GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => page));
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ButtonTheme(
                minWidth: 20,
                child: FlatButton(
                  disabledColor: PRIMARY_COLOR,
                  onPressed: () {
                    Navigator.push(
                        context, MaterialPageRoute(builder: (context) => page));
                  },
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  padding: EdgeInsets.only(left: 16, right: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(3.0),
                  ),
                  color: PRIMARY_COLOR,
                  child: Text(
                    AppLocalizations.of(context).translate('go'),
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                AppLocalizations.of(context).translate('check_another_product'),
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFlashsaleCard(index, boxImageSize) {
    return Container(
      width: boxImageSize + 10,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
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
                          name: flashsaleData[index].name,
                          image: flashsaleData[index].image,
                          price: flashsaleData[index].price,
                          description: flashsaleData[index].description,
                          summary: flashsaleData[index].summary,
                          rating: 4,
                          review: 45,
                        )));
          },
          child: Column(
            children: <Widget>[
              Stack(
                children: [
                  ClipRRect(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10)),
                      child: buildCacheNetworkImage(
                          width: boxImageSize + 10,
                          height: boxImageSize + 10,
                          url:
                              'https://apistore.mainmart.com.ng/Resources/Images/' +
                                  flashsaleData[index].image)),
                  Positioned(
                    right: 0,
                    top: 10,
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(6),
                              bottomLeft: Radius.circular(6))),
                      padding: EdgeInsets.fromLTRB(8, 4, 8, 4),
                      child: Text('0' + '%',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 12)),
                    ),
                  )
                ],
              ),
              Container(
                margin: EdgeInsets.fromLTRB(8, 8, 8, 8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      flashsaleData[index].name,
                      style: GlobalStyle.productName,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 5),
                      child: Text(
                          '\₦ ' +
                              _globalFunction.removeDecimalZeroFormat(
                                  flashsaleData[index].price),
                          style: GlobalStyle.productPriceDiscounted),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 2),
                      child: Text(
                          '\₦ ' +
                              _globalFunction.removeDecimalZeroFormat(
                                  ((100 - 0) *
                                      flashsaleData[index].price /
                                      100)),
                          style: GlobalStyle.productPrice),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTrendingProductCard(index) {
    return GestureDetector(
      onTap: () {
        StatefulWidget menuPage = SearchProductPage(
            fromWhite: StaticVariable.useWhiteStatusBarForeground,
            words: homeTrendingData[index].name);
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => menuPage));
      },
      child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          elevation: 0.5,
          color: Colors.white,
          child: Row(
            children: [
              ClipRRect(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(5),
                      bottomLeft: Radius.circular(5)),
                  child: buildCacheNetworkImage(
                      width:
                          (MediaQuery.of(context).size.width / 2) * (1.6 / 4) -
                              12 -
                              1,
                      height:
                          (MediaQuery.of(context).size.width / 2) * (1.6 / 4) -
                              12 -
                              1,
                      url:
                          'https://apistore.mainmart.com.ng/Resources/Images/' +
                              homeTrendingData[index].image)),
              Expanded(
                child: Container(
                  margin: EdgeInsets.all(3),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(homeTrendingData[index].name,
                          style: TextStyle(
                              fontSize: 10, fontWeight: FontWeight.bold)),
                      SizedBox(height: 1.8),
                    ],
                  ),
                ),
              )
            ],
          )),
    );
  }

  Widget _buildLastSearchCard(index, boxImageSize) {
    return Container(
      width: boxImageSize + 10,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
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
                      width: boxImageSize + 10,
                      height: boxImageSize + 10,
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
                      child: Text(
                          '\₦ ' +
                              _globalFunction.removeDecimalZeroFormat(
                                  lastSearchData[index].price),
                          style: GlobalStyle.productPrice),
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

  Widget _buildRecomendedProductCard(index) {
    final double boxImageSize =
        ((MediaQuery.of(context).size.width) - 22) / 2 - 12;
    return Container(
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
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
                          name: recomendedProductData[index].name,
                          image: recomendedProductData[index].image,
                          price: recomendedProductData[index].price,
                          description: recomendedProductData[index].description,
                          summary: recomendedProductData[index].summary,
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
                              recomendedProductData[index].image)),
              Container(
                margin: EdgeInsets.fromLTRB(5, 5, 5, 5),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      recomendedProductData[index].name,
                      style: GlobalStyle.productName,
                      maxLines: 4,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 4),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                              '\₦ ' +
                                  _globalFunction.removeDecimalZeroFormat(
                                      recomendedProductData[index].price),
                              style: GlobalStyle.productPrice),
                          Text(
                              '0' +
                                  ' ' +
                                  AppLocalizations.of(context)
                                      .translate('sale'),
                              style: TextStyle(fontSize: 11, color: SOFT_GREY))
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 4),
                      child: Row(
                        children: [
                          Icon(Icons.location_on, color: SOFT_GREY, size: 12),
                          Text(' ' 'MainMart Stores',
                              style: GlobalStyle.productSale)
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 3),
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
