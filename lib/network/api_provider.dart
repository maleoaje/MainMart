/*
This is api provider
This page is used to get data from API
 */

import 'package:dio/dio.dart';
import 'package:ijshopflutter/bloc/home/category/category_by_id/category_all_product_event.dart';
import 'package:ijshopflutter/config/constants.dart';
import 'package:ijshopflutter/model/account/address_model.dart';
import 'package:ijshopflutter/model/account/last_seen_model.dart';
import 'package:ijshopflutter/model/account/order_list_model.dart';
import 'package:ijshopflutter/model/general/related_product_model.dart';
import 'package:ijshopflutter/model/general/review_model.dart';
import 'package:ijshopflutter/model/home/category/category_all_product_model.dart';
import 'package:ijshopflutter/model/home/category/category_by_id.dart';
import 'package:ijshopflutter/model/home/category/category_banner_model.dart';
import 'package:ijshopflutter/model/home/category/category_for_you_model.dart';
import 'package:ijshopflutter/model/home/category/category_model.dart';
import 'package:ijshopflutter/model/home/category/category_new_product_model.dart';
import 'package:ijshopflutter/model/home/category/category_page_model.dart';
import 'package:ijshopflutter/model/home/category/category_trending_product_model.dart';
import 'package:ijshopflutter/model/home/coupon_model.dart';
import 'package:ijshopflutter/model/home/flashsale_model.dart';
import 'package:ijshopflutter/model/home/home_banner_model.dart';
import 'package:ijshopflutter/model/home/last_search_model.dart';
import 'package:ijshopflutter/model/home/recomended_product_model.dart';
import 'package:ijshopflutter/model/home/search/search_model.dart';
import 'package:ijshopflutter/model/home/search/search_product_model.dart';
import 'package:ijshopflutter/model/home/trending_model.dart';
import 'package:ijshopflutter/model/shopping_cart/shopping_cart_model.dart';
import 'package:ijshopflutter/model/wishlist/wishlist_model.dart';

class ApiProvider {
  Dio dio = Dio();
  Response response;
  String connErr = 'Please check your internet connection and try again';

  Future<Response> dioConnect(url, data, apiToken) async {
    //print('url : ' + url.toString());
    //print('postData : ' + data.toString());
    try {
      dio.options.headers['content-Type'] = 'application/x-www-form-urlencoded';
      dio.options.connectTimeout = 30000; //5s
      dio.options.receiveTimeout = 25000;

      return await dio.post(url, data: data, cancelToken: apiToken);
    } on DioError catch (e) {
      //print(e.toString()+' | '+url.toString());
      if (e.type == DioErrorType.RESPONSE) {
        int statusCode = e.response.statusCode;
        if (statusCode == STATUS_NOT_FOUND) {
          throw Exception("Api not found");
        } else if (statusCode == STATUS_INTERNAL_ERROR) {
          throw Exception("Internal Server Error");
        } else {
          throw Exception(e.error.message.toString());
        }
      } else if (e.type == DioErrorType.CONNECT_TIMEOUT) {
        throw Exception(e.message.toString());
      } else if (e.type == DioErrorType.CANCEL) {
        throw Exception('cancel');
      }
      throw Exception(connErr);
    } finally {
      dio.close();
    }
  }

  Future<Response> dioConnectGet(url, apiToken) async {
    print('url : ' + url.toString());
    try {
      dio.options.headers['content-Type'] = 'application/x-www-form-urlencoded';
      dio.options.connectTimeout = 30000; //5s
      dio.options.receiveTimeout = 25000;

      return await dio.get(url, cancelToken: apiToken);
    } on DioError catch (e) {
      //print(e.toString()+' | '+url.toString());
      if (e.type == DioErrorType.RESPONSE) {
        int statusCode = e.response.statusCode;
        if (statusCode == STATUS_NOT_FOUND) {
          throw Exception("Api not found");
        } else if (statusCode == STATUS_INTERNAL_ERROR) {
          throw Exception("Internal Server Error");
        } else {
          throw Exception(e.error.message.toString());
        }
      } else if (e.type == DioErrorType.CONNECT_TIMEOUT) {
        throw Exception(e.message.toString());
      } else if (e.type == DioErrorType.CANCEL) {
        throw Exception('cancel');
      }
      throw Exception(connErr);
    } finally {
      dio.close();
    }
  }

  Future<List<WishlistModel>> getWishlist(String sessionId, apiToken) async {
    var postData = {'session_id': sessionId};
    response = await dioConnect(WISHLIST_API, postData, apiToken);
    List responseList = response.data['data'];
    if (response.data['status'] == STATUS_OK) {
      List<WishlistModel> listData =
          responseList.map((f) => WishlistModel.fromJson(f)).toList();
      return listData;
    } else {
      throw Exception(response.data['msg']);
    }
  }

  Future<List<LastSeenModel>> getLastSeenProduct(
      String sessionId, String skip, String limit, apiToken) async {
    var postData = {'session_id': sessionId, 'skip': skip, 'limit': limit};
    response = await dioConnect(LAST_SEEN_PRODUCT_API, postData, apiToken);
    List responseList = response.data['data'];
    if (response.data['status'] == STATUS_OK) {
      //print('data : '+responseList.toString());
      List<LastSeenModel> listData =
          responseList.map((f) => LastSeenModel.fromJson(f)).toList();
      return listData;
    } else {
      throw Exception(response.data['msg']);
    }
  }

  Future<List<AddressModel>> getAddress(String sessionId, apiToken) async {
    var postData = {'session_id': sessionId};
    response = await dioConnect(ADDRESS_API, postData, apiToken);
    List responseList = response.data['data'];
    if (response.data['status'] == STATUS_OK) {
      List<AddressModel> listData =
          responseList.map((f) => AddressModel.fromJson(f)).toList();
      return listData;
    } else {
      throw Exception(response.data['msg']);
    }
  }

  Future<List<OrderListModel>> getOrderList(String sessionId, String status,
      String skip, String limit, apiToken) async {
    var postData = {
      'session_id': sessionId,
      'status': status,
      'skip': skip,
      'limit': limit
    };
    response = await dioConnect(ORDER_LIST_API, postData, apiToken);
    List responseList = response.data['data'];
    if (response.data['status'] == STATUS_OK) {
      //print('data : '+responseList.toString());
      List<OrderListModel> listData =
          responseList.map((f) => OrderListModel.fromJson(f)).toList();
      return listData;
    } else {
      throw Exception(response.data['msg']);
    }
  }

  Future<List<RelatedProductModel>> getRelatedProduct(
      String sessionId, apiToken) async {
    response = await dioConnectGet(RELATED_PRODUCT_API, apiToken);
    List responseList = response.data;
    print('data: ' + responseList.toString());
    List<RelatedProductModel> listData =
        responseList.map((f) => RelatedProductModel.fromJson(f)).toList();
    return listData;
  }

  Future<List<ReviewModel>> getReview(
      String sessionId, String skip, String limit, apiToken) async {
    var postData = {'session_id': sessionId, 'skip': skip, 'limit': limit};
    response = await dioConnect(REVIEW_API, postData, apiToken);
    List responseList = response.data['data'];
    if (response.data['status'] == STATUS_OK) {
      //print('data : '+responseList.toString());
      List<ReviewModel> listData =
          responseList.map((f) => ReviewModel.fromJson(f)).toList();
      return listData;
    } else {
      throw Exception(response.data['msg']);
    }
  }

  Future<List<CouponModel>> getCoupon(
      String sessionId, String skip, String limit, apiToken) async {
    var postData = {'session_id': sessionId, 'skip': skip, 'limit': limit};
    response = await dioConnect(COUPON_API, postData, apiToken);
    List responseList = response.data['data'];
    if (response.data['status'] == STATUS_OK) {
      //print('data : ' + responseList.toString());
      List<CouponModel> listData =
          responseList.map((f) => CouponModel.fromJson(f)).toList();
      return listData;
    } else {
      throw Exception(response.data['msg']);
    }
  }

  Future<CouponModel> getCouponDetail(
      String sessionId, int id, apiToken) async {
    var postData = {'session_id': sessionId, 'id': id};
    response = await dioConnect(COUPON_DETAIL_API, postData, apiToken);
    if (response.data['status'] == STATUS_OK) {
      //print('data : ' + response.toString());
      CouponModel data = new CouponModel(
          id: id,
          name: response.data['data']['name'],
          day: response.data['data']['day'],
          term: response.data['data']['term']);
      return data;
    } else {
      throw Exception(response.data['msg']);
    }
  }

  Future<List<HomeBannerModel>> getHomeBanner(
      String sessionId, apiToken) async {
    var postData = {'session_id': sessionId};
    response = await dioConnect(HOME_BANNER_API, postData, apiToken);
    List responseList = response.data['data'];
    if (response.data['status'] == STATUS_OK) {
      List<HomeBannerModel> listData =
          responseList.map((f) => HomeBannerModel.fromJson(f)).toList();
      return listData;
    } else {
      throw Exception(response.data['msg']);
    }
  }

  Future<List<LastSearchModel>> getLastSearch(
      String sessionId, String skip, String limit, apiToken) async {
    response = await dioConnectGet(LAST_SEARCH_API, apiToken);
    List responseList = response.data;
    //print('data : ' + responseList.toString());
    List<LastSearchModel> listData =
        responseList.map((f) => LastSearchModel.fromJson(f)).toList();
    return listData;
  }

  Future<List<LastSearchModel>> getLastSearchInfinite(
      String sessionId, String skip, String limit, apiToken) async {
    response = await dioConnectGet(LAST_SEARCH_INFINITE_API, apiToken);
    List responseList = response.data;
    //print('data : ' + responseList.toString());
    List<LastSearchModel> listData =
        responseList.map((f) => LastSearchModel.fromJson(f)).toList();
    return listData;
  }

  Future<List<HomeTrendingModel>> getHomeTrending(
      String sessionId, String skip, String limit, apiToken) async {
    response = await dioConnectGet(HOME_TRENDING_API, apiToken);
    List responseList = response.data;
    //print('data : ' + responseList.toString());
    List<HomeTrendingModel> listData =
        responseList.map((f) => HomeTrendingModel.fromJson(f)).toList();
    return listData;
  }

  Future<List<FlashsaleModel>> getFlashsale(
      String sessionId, String skip, String limit, apiToken) async {
    response = await dioConnectGet(FLASHSALE_API, apiToken);
    List responseList = response.data;
    //print('data : ' + responseList.toString());
    List<FlashsaleModel> listData =
        responseList.map((f) => FlashsaleModel.fromJson(f)).toList();
    return listData;
  }

  Future<List<CategoryForYouModel>> getCategoryForYou(
      String sessionId, apiToken) async {
    var postData = {'session_id': sessionId};
    response = await dioConnect(CATEGORY_FOR_YOU_API, postData, apiToken);
    List responseList = response.data['data'];
    if (response.data['status'] == STATUS_OK) {
      List<CategoryForYouModel> listData =
          responseList.map((f) => CategoryForYouModel.fromJson(f)).toList();
      return listData;
    } else {
      throw Exception(response.data['msg']);
    }
  }

  Future<List<RecomendedProductModel>> getRecomendedProduct(
      String sessionId, String skip, String limit, apiToken) async {
    response = await dioConnectGet(RECOMENDED_PRODUCT_API, apiToken);
    List responseList = response.data;
    //print('data : ' + responseList.toString());
    List<RecomendedProductModel> listData =
        responseList.map((f) => RecomendedProductModel.fromJson(f)).toList();
    return listData;
  }

  /*Future<List<SearchModel>> getSearch(String sessionId, apiToken) async {
    response = await dioConnectGet(SEARCH_API, apiToken);
    List responseList = response.data;
    //print('data : ' + responseList.toString());
    List<SearchModel> listData =
        responseList.map((f) => SearchModel.fromJson(f)).toList();
    return listData;
  }*/

  Future<List<SearchModel>> getSearch(String sessionId, apiToken) async {
    response = await dioConnectGet(SEARCH_API, apiToken);
    List responseList = response.data;
    //print('data : ' + responseList.toString());
    List<SearchModel> listData =
        responseList.map((f) => SearchModel.fromJson(f)).toList();
    return listData;
  }

  Future<List<SearchProductModel>> getSearchProduct(String sessionId,
      String search, String skip, String limit, apiToken) async {
    response = await dioConnectGet(SEARCH_PRODUCT_API + search, apiToken);
    List responseList = response.data;
    //print('data : ' + responseList.toString());
    List<SearchProductModel> listData =
        responseList.map((f) => SearchProductModel.fromJson(f)).toList();
    return listData;
  }

  Future<List<CategoryBannerModel>> getCategoryBanner(
      String sessionId, int categoryId, apiToken) async {
    var postData = {
      'session_id': sessionId,
      'category_id': categoryId,
    };
    response = await dioConnect(CATEGORY_BANNER_API, postData, apiToken);
    List responseList = response.data['data'];
    if (response.data['status'] == STATUS_OK) {
      List<CategoryBannerModel> listData =
          responseList.map((f) => CategoryBannerModel.fromJson(f)).toList();
      return listData;
    } else {
      throw Exception(response.data['msg']);
    }
  }

  Future<List<CategoryTrendingProductModel>> getCategoryTrendingProduct(
      String sessionId,
      int categoryId,
      String skip,
      String limit,
      apiToken) async {
    response = await dioConnectGet(CATEGORY_TRENDING_PRODUCT_API, apiToken);
    List responseList = response.data;
    //print('data : ' + responseList.toString());
    List<CategoryTrendingProductModel> listData = responseList
        .map((f) => CategoryTrendingProductModel.fromJson(f))
        .toList();
    return listData;
  }

  Future<List<CategoryNewProductModel>> getCategoryNewProduct(String sessionId,
      int categoryId, String skip, String limit, apiToken) async {
    var postData = {
      'session_id': sessionId,
      'category_id': categoryId,
      'skip': skip,
      'limit': limit
    };
    response = await dioConnect(CATEGORY_NEW_PRODUCT_API, postData, apiToken);
    List responseList = response.data['data'];
    if (response.data['status'] == STATUS_OK) {
      //print('data : '+responseList.toString());
      List<CategoryNewProductModel> listData =
          responseList.map((f) => CategoryNewProductModel.fromJson(f)).toList();
      return listData;
    } else {
      throw Exception(response.data['msg']);
    }
  }

  Future<List<CategoryAllProductModel>> getCategoryAllProduct(String sessionId,
      int categoryId, String skip, String limit, apiToken) async {
    response = await dioConnectGet(CATEGORY_All_PRODUCT_API, apiToken);
    List responseList = response.data;
    //print('data : ' + responseList.toString());
    List<CategoryAllProductModel> listData =
        responseList.map((f) => CategoryAllProductModel.fromJson(f)).toList();
    return listData;
  }

  Future<List<CategoryByIdModel>> getCategoryById(String sessionId,
      int categoryId, String skip, String limit, apiToken) async {
    response =
        await dioConnectGet(PRODUCT_BY_CATEGORY_API + '$categoryId', apiToken);
    List responseList = response.data;
    //print('data : ' + responseList.toString());
    List<CategoryByIdModel> listData =
        responseList.map((f) => CategoryByIdModel.fromJson(f)).toList();
    return listData;
  }

  Future<List<CategoryModel>> getCategory(String sessionId, apiToken) async {
    response = await dioConnectGet(CATEGORY_API, apiToken);
    List responseList = response.data;
    //print('data : ' + responseList.toString());
    List<CategoryModel> listData =
        responseList.map((f) => CategoryModel.fromJson(f)).toList();
    return listData;
  }

  Future<List<CategoryPageModel>> getCategoryPage(
      String sessionId, apiToken) async {
    response = await dioConnectGet(CATEGORY_API, apiToken);
    List responseList = response.data;
    //print('data : ' + responseList.toString());
    List<CategoryPageModel> listData =
        responseList.map((f) => CategoryPageModel.fromJson(f)).toList();
    return listData;
  }
}
