import 'package:meta/meta.dart';

@immutable
abstract class SearchEvent {}

class GetSearch extends SearchEvent {
  final String sessionId;
  final apiToken;
  GetSearch({@required this.sessionId, @required this.apiToken});
}