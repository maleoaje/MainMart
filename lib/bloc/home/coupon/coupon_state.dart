import 'package:ijshopflutter/model/home/coupon_model.dart';
import 'package:meta/meta.dart';

@immutable
abstract class CouponState {}

class InitialCouponState extends CouponState {}

class CouponWaiting extends CouponState {}
class CouponError extends CouponState {
  final String errorMessage;

  CouponError({
    this.errorMessage,
  });
}
class GetCouponSuccess extends CouponState {
  final List<CouponModel> couponData;
  GetCouponSuccess({@required this.couponData});
}

class CouponDetailWaiting extends CouponState {}
class CouponDetailError extends CouponState {
  final String errorMessage;

  CouponDetailError({
    this.errorMessage,
  });
}
class GetCouponDetailSuccess extends CouponState {
  final CouponModel couponData;
  GetCouponDetailSuccess({@required this.couponData});
}