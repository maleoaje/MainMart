import 'package:meta/meta.dart';

@immutable
abstract class CategoryForYouEvent {}

class GetCategoryForYou extends CategoryForYouEvent {
  final String sessionId;
  final apiToken;
  GetCategoryForYou({@required this.sessionId, @required this.apiToken});
}