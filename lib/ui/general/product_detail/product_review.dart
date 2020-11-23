/*
This is product review page

include file in reuseable/global_function.dart to call function from GlobalFunction
include file in reuseable/global_widget.dart to call function from GlobalWidget
include file in reuseable/shimmer_loading.dart to use shimmer loading
include file in model/general/review_model.dart to get reviewData
 */

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ijshopflutter/bloc/general/review/bloc.dart';
import 'package:ijshopflutter/config/constants.dart';
import 'package:ijshopflutter/config/global_style.dart';
import 'package:ijshopflutter/model/general/review_model.dart';
import 'package:ijshopflutter/ui/reuseable/app_localizations.dart';
import 'package:ijshopflutter/ui/reuseable/global_function.dart';
import 'package:ijshopflutter/ui/reuseable/global_widget.dart';
import 'package:ijshopflutter/ui/reuseable/shimmer_loading.dart';

class ProductReviewPage extends StatefulWidget {
  @override
  _ProductReviewPageState createState() => _ProductReviewPageState();
}

class _ProductReviewPageState extends State<ProductReviewPage> {
  // initialize global function, global widget and shimmer loading
  final _globalFunction = GlobalFunction();
  final _globalWidget = GlobalWidget();
  final _shimmerLoading = ShimmerLoading();

  List<ReviewModel> reviewData = List();

  ReviewBloc _reviewBloc;
  int _apiPage = 0;
  ScrollController _scrollController = ScrollController();
  bool _lastData = false;
  bool _processApi = false;

  CancelToken apiToken = CancelToken(); // used to cancel fetch data from API

  List<String> starList;
  int starIndex = 0;

  @override
  void initState() {
    // get data when initState
    _reviewBloc = BlocProvider.of<ReviewBloc>(context);
    _reviewBloc.add(GetReview(
        sessionId: SESSION_ID,
        skip: _apiPage.toString(),
        limit: LIMIT_PAGE.toString(),
        apiToken: apiToken));

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      _initForLang();
    });

    super.initState();
  }

  void _initForLang() {
    setState(() {
      starList = [
        AppLocalizations.of(context).translate('all_review'),
        '1',
        '2',
        '3',
        '4',
        '5'
      ];
    });
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
        _reviewBloc.add(GetReview(
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
    _scrollController.addListener(_onScroll);
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: Colors.black, //change your color here
          ),
          elevation: 0,
          title: Text(
            AppLocalizations.of(context).translate('product_review'),
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
        body: BlocListener<ReviewBloc, ReviewState>(
          listener: (context, state) {
            if (state is ReviewError) {
              _globalFunction.showToast(
                  type: 'error', message: state.errorMessage);
            }
            if (state is GetReviewSuccess) {
              if (state.reviewData.length == 0) {
                _lastData = true;
              } else {
                _apiPage += LIMIT_PAGE;
                reviewData.addAll(state.reviewData);
              }
              _processApi = false;
            }
          },
          child: ListView(
            controller: _scrollController,
            padding: EdgeInsets.all(16),
            children: [
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: List.generate(starList.length, (index) {
                    return radioStar(starList[index], index);
                  }),
                ),
              ),
              SizedBox(height: 16),
              Container(
                child: BlocBuilder<ReviewBloc, ReviewState>(
                  builder: (context, state) {
                    if (state is ReviewError) {
                      return Container(
                          child: Center(
                              child: Text(ERROR_OCCURED,
                                  style: TextStyle(
                                      fontSize: 14, color: BLACK_GREY))));
                    } else {
                      if (_lastData && _apiPage == 0) {
                        return Container(
                            child: Center(
                                child: Text(
                                    AppLocalizations.of(context)
                                        .translate('no_product_review'),
                                    style: TextStyle(
                                        fontSize: 14, color: BLACK_GREY))));
                      } else {
                        if (reviewData.length == 0) {
                          return _shimmerLoading.buildShimmerReview();
                        } else {
                          return ListView.builder(
                            shrinkWrap: true,
                            physics: ScrollPhysics(),
                            itemCount: (state is ReviewWaiting)
                                ? reviewData.length + 1
                                : reviewData.length,
                            // Add one more item for progress indicator
                            itemBuilder: (BuildContext context, int index) {
                              if (index == reviewData.length) {
                                return _globalWidget
                                    .buildProgressIndicator(_lastData);
                              } else {
                                return _buildReviewCard(index);
                              }
                            },
                          );
                        }
                      }
                    }
                  },
                ),
              ),
            ],
          ),
        ));
  }

  Widget radioStar(String txt, int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          starIndex = index;
        });
      },
      child: Container(
          padding: EdgeInsets.fromLTRB(12, 8, 12, 8),
          margin: EdgeInsets.only(right: 10),
          decoration: BoxDecoration(
              color: starIndex == index ? SOFT_BLUE : Colors.white,
              border: Border.all(
                  width: 1,
                  color: starIndex == index ? SOFT_BLUE : Colors.grey[300]),
              borderRadius: BorderRadius.all(Radius.circular(10))),
          child: index == 0
              ? Text(txt,
                  style: TextStyle(
                      color: starIndex == index ? Colors.white : CHARCOAL))
              : Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    Text(txt,
                        style: TextStyle(
                            color:
                                starIndex == index ? Colors.white : CHARCOAL)),
                    SizedBox(width: 2),
                    Icon(Icons.star,
                        color: starIndex == index
                            ? Colors.white
                            : Colors.yellow[700],
                        size: 12),
                  ],
                )),
    );
  }

  Widget _buildReviewCard(index) {
    return Card(
      margin: EdgeInsets.only(top: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 2,
      color: Colors.white,
      child: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(reviewData[index].date,
                style: TextStyle(fontSize: 13, color: SOFT_GREY)),
            SizedBox(height: 4),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(reviewData[index].name,
                    style:
                        TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                _globalWidget.createRatingBar(reviewData[index].rating)
              ],
            ),
            SizedBox(height: 4),
            Text(reviewData[index].review)
          ],
        ),
      ),
    );
  }
}
