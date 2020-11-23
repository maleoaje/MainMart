import 'package:meta/meta.dart';

@immutable
abstract class RecomendedProductEvent {}

class GetRecomendedProduct extends RecomendedProductEvent {
  final String sessionId, skip, limit;
  final apiToken;
  GetRecomendedProduct({@required this.sessionId, @required this.skip, @required this.limit, @required this.apiToken});
}