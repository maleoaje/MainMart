import 'package:meta/meta.dart';

@immutable
abstract class SearchProductEvent {}

class GetSearchProduct extends SearchProductEvent {
  final String sessionId, search, skip, limit;
  final apiToken;
  GetSearchProduct({@required this.sessionId, @required this.search, @required this.skip, @required this.limit, @required this.apiToken});
}