import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:ijshopflutter/model/home/coupon_model.dart';
import 'package:ijshopflutter/network/api_provider.dart';
import './bloc.dart';

class CouponBloc extends Bloc<CouponEvent, CouponState> {
  CouponBloc() : super(InitialCouponState());

  @override
  Stream<CouponState> mapEventToState(
    CouponEvent event,
  ) async* {
    if(event is GetCoupon){
      yield* _getCoupon(event.sessionId, event.skip, event.limit, event.apiToken);
    } else if(event is GetCouponDetail){
      yield* _getCouponDetail(event.sessionId, event.id, event.apiToken);
    }
  }
}

Stream<CouponState> _getCoupon(String sessionId, String skip, String limit, apiToken) async* {
  ApiProvider _apiProvider = ApiProvider();

  yield CouponWaiting();
  try {
    List<CouponModel> data = await _apiProvider.getCoupon(sessionId, skip, limit, apiToken);
    yield GetCouponSuccess(couponData: data);
  } catch (ex){
    if(ex.message != 'cancel'){
      yield CouponError(errorMessage: ex.message.toString());
    }
  }
}

Stream<CouponState> _getCouponDetail(String sessionId, int id, apiToken) async* {
  ApiProvider _apiProvider = ApiProvider();

  yield CouponDetailWaiting();
  try {
    CouponModel data = await _apiProvider.getCouponDetail(sessionId, id, apiToken);
    yield GetCouponDetailSuccess(couponData: data);
  } catch (ex){
    if(ex.message != 'cancel'){
      yield CouponDetailError(errorMessage: ex.message.toString());
    }
  }
}