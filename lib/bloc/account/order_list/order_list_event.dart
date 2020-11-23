import 'package:meta/meta.dart';

@immutable
abstract class OrderListEvent {}

class GetOrderList extends OrderListEvent {
  final String sessionId, status, skip, limit;
  final apiToken;
  GetOrderList({@required this.sessionId, @required this.status, @required this.skip, @required this.limit, @required this.apiToken});
}