import 'package:meta/meta.dart';

@immutable
abstract class LastSearchEvent {}

class GetLastSearchHome extends LastSearchEvent {
  final String sessionId, skip, limit;
  final apiToken;
  GetLastSearchHome({@required this.sessionId, @required this.skip, @required this.limit, @required this.apiToken});
}

class GetLastSearch extends LastSearchEvent {
  final String sessionId, skip, limit;
  final apiToken;
  GetLastSearch({@required this.sessionId, @required this.skip, @required this.limit, @required this.apiToken});
}