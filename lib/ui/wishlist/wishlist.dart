/*
This is wishlist page
we used AutomaticKeepAliveClientMixin to keep the state when moving from 1 navbar to another navbar, so the page is not refresh overtime

include file in reuseable/global_function.dart to call function from GlobalFunction
include file in reuseable/global_widget.dart to call function from GlobalWidget
include file in reuseable/cache_image_network.dart to use cache image network
include file in reuseable/shimmer_loading.dart to use shimmer loading
include file in model/wishlist/wishlist_model.dart to get wishlistData

install plugin in pubspec.yaml
- fluttertoast => to show toast (https://pub.dev/packages/fluttertoast)

Don't forget to add all images and sound used in this pages at the pubspec.yaml
 */

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ijshopflutter/bloc/home/category_page/category_page_bloc.dart';
import 'package:ijshopflutter/bloc/home/category_page/category_page_event.dart';
import 'package:ijshopflutter/bloc/home/category_page/category_page_state.dart';
import 'package:ijshopflutter/bloc/wishlist/bloc.dart';
import 'package:ijshopflutter/config/constants.dart';
import 'package:ijshopflutter/config/global_style.dart';
import 'package:ijshopflutter/model/home/category/category_page_model.dart';
import 'package:ijshopflutter/model/wishlist/wishlist_model.dart';
import 'package:ijshopflutter/ui/general/chat_us.dart';
import 'package:ijshopflutter/ui/general/product_detail/product_detail.dart';
import 'package:ijshopflutter/ui/general/notification.dart';
import 'package:ijshopflutter/ui/home/category/product_category.dart';
import 'package:ijshopflutter/ui/reuseable/app_localizations.dart';
import 'package:ijshopflutter/ui/reuseable/cache_image_network.dart';
import 'package:ijshopflutter/ui/reuseable/global_function.dart';
import 'package:ijshopflutter/ui/reuseable/global_widget.dart';
import 'package:ijshopflutter/ui/reuseable/shimmer_loading.dart';
import 'dart:async';

class WishlistPage extends StatefulWidget {
  @override
  _WishlistPageState createState() => _WishlistPageState();
}

class _WishlistPageState extends State<WishlistPage>
    with AutomaticKeepAliveClientMixin {
  // initialize global function, global widget and shimmer loading
  final _globalFunction = GlobalFunction();
  final _globalWidget = GlobalWidget();
  final _shimmerLoading = ShimmerLoading();

  List<WishlistModel> wishlistData = List();
  List<CategoryPageModel> categoryData = List();
  CategoryPageBloc _categoryBloc;
  bool _lastDataCategory = false;
  ScrollController _scrollController;

  WishlistBloc _wishlistBloc;
  bool _lastData = false;

  CancelToken apiToken = CancelToken(); // used to cancel fetch data from API

  // _listKey is used for AnimatedList
  final GlobalKey<AnimatedListState> _listKey = GlobalKey();

  TextEditingController _etSearch = TextEditingController();

  // keep the state to do not refresh when switch navbar
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    // get data when initState
    _wishlistBloc = BlocProvider.of<WishlistBloc>(context);
    _wishlistBloc.add(GetWishlist(sessionId: SESSION_ID, apiToken: apiToken));

    _categoryBloc = BlocProvider.of<CategoryPageBloc>(context);
    _categoryBloc
        .add(GetCategoryPage(sessionId: SESSION_ID, apiToken: apiToken));

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
    // if we used AutomaticKeepAliveClientMixin, we must call super.build(context);
    super.build(context);
    final double boxImageSize = (MediaQuery.of(context).size.width / 4);
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        title: Text('CATEGORIES', style: TextStyle(color: Colors.white)),
        backgroundColor: PRIMARY_COLOR,
        actions: [
          GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ChatUsPage()));
              },
              child: Icon(Icons.email, color: Colors.white)),
          IconButton(
              icon: _globalWidget.customNotifIcon(0, Colors.white),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => NotificationPage()));
              }),
        ],
        // create search text field in the app bar
        bottom: PreferredSize(
          child: Container(
            padding: EdgeInsets.fromLTRB(16, 0, 16, 12),
            height: 2,
          ),
          preferredSize: Size.fromHeight(2),
        ),
      ),
      body: MultiBlocListener(
        listeners: [
          BlocListener<CategoryPageBloc, CategoryPageState>(
            listener: (context, state) {
              print('1');
              if (state is CategoryPageError) {
                _globalFunction.showToast(
                    type: 'error', message: state.errorMessage);
              }
              if (state is GetCategoryPageSuccess) {
                print('2');
                if (state.categoryData.length == 0) {
                  _lastDataCategory = true;
                } else {
                  print('3');
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
                    delegate: SliverChildListDelegate(
                      [
                        _createGridCategory(),
                      ],
                    ),
                  ),
                ],
              ),
              // Create AppBar with Animation
            ],
          ),
        ),
      ),
    );
  }

  Future refreshData() async {
    setState(() {
      categoryData.clear();
      _categoryBloc
          .add(GetCategoryPage(sessionId: SESSION_ID, apiToken: apiToken));
    });
  }

  Widget _createGridCategory() {
    return BlocBuilder<CategoryPageBloc, CategoryPageState>(
      builder: (context, state) {
        if (state is CategoryPageError) {
          print('1');
          return Container(
              child: Center(
                  child: Text(ERROR_OCCURED,
                      style: TextStyle(fontSize: 14, color: BLACK_GREY))));
        } else {
          print('2');
          if (_lastDataCategory) {
            return Wrap();
          } else {
            print('3');
            if (categoryData.length == 0) {
              return _shimmerLoading.buildShimmerCategory();
            } else {
              print('4');
              return GridView.count(
                padding: EdgeInsets.fromLTRB(16, 16, 16, 0),
                primary: false,
                childAspectRatio: 1.1,
                shrinkWrap: true,
                crossAxisSpacing: 0,
                mainAxisSpacing: 0,
                crossAxisCount: 3,
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

  Widget _buildWishlistCard(index, boxImageSize, animation) {
    return SizeTransition(
      sizeFactor: animation,
      child: Container(
        margin: EdgeInsets.fromLTRB(12, 6, 12, 0),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          elevation: 2,
          color: Colors.white,
          child: Container(
            margin: EdgeInsets.all(8),
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ProductDetailPage(
                                fromWhite: null,
                                name: wishlistData[index].name,
                                image: wishlistData[index].image,
                                price: wishlistData[index].price,
                                rating: wishlistData[index].rating,
                                review: wishlistData[index].review,
                                sale: wishlistData[index].sale)));
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          child: buildCacheNetworkImage(
                              width: boxImageSize,
                              height: boxImageSize,
                              url: wishlistData[index].image)),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              wishlistData[index].name,
                              style: GlobalStyle.productName
                                  .copyWith(fontSize: 13),
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 5),
                              child: Text(
                                  '\₦ ' +
                                      _globalFunction.removeDecimalZeroFormat(
                                          wishlistData[index].price),
                                  style: GlobalStyle.productPrice),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 5),
                              child: Row(
                                children: [
                                  Icon(Icons.location_on,
                                      color: SOFT_GREY, size: 12),
                                  Text(' ' + wishlistData[index].location,
                                      style: GlobalStyle.productLocation)
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 5),
                              child: Row(
                                children: [
                                  _globalWidget.createRatingBar(
                                      wishlistData[index].rating),
                                  Text(
                                      '(' +
                                          wishlistData[index]
                                              .review
                                              .toString() +
                                          ')',
                                      style: GlobalStyle.productTotalReview)
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 5),
                              child: Text(
                                  wishlistData[index].sale.toString() +
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
                Container(
                  margin: EdgeInsets.only(top: 12),
                  child: Row(
                    children: [
                      GestureDetector(
                        behavior: HitTestBehavior.translucent,
                        onTap: () {
                          showPopupDeleteWishlist(index, boxImageSize);
                        },
                        child: Container(
                          padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                          height: 30,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                  width: 1, color: Colors.grey[300])),
                          child:
                              Icon(Icons.delete, color: BLACK_GREY, size: 20),
                        ),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Expanded(
                        child: ButtonTheme(
                          height: 30,
                          child: FlatButton(
                              onPressed: () {
                                if (wishlistData[index].stock != 0) {
                                  Fluttertoast.showToast(
                                      msg: AppLocalizations.of(context)
                                          .translate('shopping_cart_added'),
                                      toastLength: Toast.LENGTH_LONG);
                                }
                              },
                              padding: EdgeInsets.all(0),
                              splashColor: (wishlistData[index].stock == 0)
                                  ? Colors.grey[300]
                                  : Colors.grey[50],
                              color: (wishlistData[index].stock == 0)
                                  ? Colors.grey[300]
                                  : Colors.transparent,
                              highlightColor: (wishlistData[index].stock == 0)
                                  ? Colors.grey[300]
                                  : Colors.grey[50],
                              materialTapTargetSize:
                                  MaterialTapTargetSize.shrinkWrap,
                              child: Text(
                                (wishlistData[index].stock == 0)
                                    ? AppLocalizations.of(context)
                                        .translate('out_of_stock')
                                    : AppLocalizations.of(context)
                                        .translate('add_to_shopping_cart'),
                                style: TextStyle(
                                    color: (wishlistData[index].stock == 0)
                                        ? Colors.grey[600]
                                        : SOFT_BLUE,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13),
                                textAlign: TextAlign.center,
                              ),
                              shape: new RoundedRectangleBorder(
                                side: BorderSide(
                                    color: (wishlistData[index].stock == 0)
                                        ? Colors.grey[300]
                                        : SOFT_BLUE,
                                    width: 1.0),
                                borderRadius: new BorderRadius.circular(5.0),
                              )),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void showPopupDeleteWishlist(index, boxImageSize) {
    // set up the buttons
    Widget cancelButton = FlatButton(
      child: Text(AppLocalizations.of(context).translate('no'),
          style: TextStyle(color: SOFT_BLUE)),
      onPressed: () {
        Navigator.pop(context);
      },
    );
    Widget continueButton = FlatButton(
      child: Text(AppLocalizations.of(context).translate('yes'),
          style: TextStyle(color: SOFT_BLUE)),
      onPressed: () {
        setState(() {
          wishlistData.removeAt(index);
          AnimatedListRemovedItemBuilder builder = (context, animation) {
            return _buildWishlistCard(index, boxImageSize, animation);
          };
          _listKey.currentState.removeItem(index, builder);
        });
        Navigator.pop(context);
        Fluttertoast.showToast(
            msg:
                AppLocalizations.of(context).translate('item_deleted_wishlist'),
            toastLength: Toast.LENGTH_LONG);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      title: Text(
        AppLocalizations.of(context).translate('delete_wishlist'),
        style: TextStyle(fontSize: 18),
      ),
      content: Text(
          AppLocalizations.of(context)
              .translate('are_you_sure_delete_wishlist'),
          style: TextStyle(fontSize: 13, color: BLACK_GREY)),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
