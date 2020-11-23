import 'package:meta/meta.dart';

@immutable
abstract class HomeTrendingEvent {}

class GetHomeTrending extends HomeTrendingEvent {
  final String sessionId, skip, limit;
  final apiToken;
  GetHomeTrending({@required this.sessionId, @required this.skip, @required this.limit, @required this.apiToken});
}