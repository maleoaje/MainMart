import 'package:meta/meta.dart';

@immutable
abstract class LastSeenProductEvent {}

class GetLastSeenProduct extends LastSeenProductEvent {
  final String sessionId, skip, limit;
  final apiToken;
  GetLastSeenProduct({@required this.sessionId, @required this.skip, @required this.limit, @required this.apiToken});
}