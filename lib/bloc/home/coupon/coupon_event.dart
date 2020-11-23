import 'package:meta/meta.dart';

@immutable
abstract class CouponEvent {}

class GetCoupon extends CouponEvent {
  final String sessionId, skip, limit;
  final apiToken;
  GetCoupon({@required this.sessionId, @required this.skip, @required this.limit, @required this.apiToken});
}

class GetCouponDetail extends CouponEvent {
  final String sessionId;
  final int id;
  final apiToken;
  GetCouponDetail({@required this.sessionId, @required this.id, @required this.apiToken});
}