import 'package:meta/meta.dart';

@immutable
abstract class CategoryPageEvent {}

class GetCategoryPage extends CategoryPageEvent {
  final String sessionId;
  final apiToken;
  GetCategoryPage({@required this.sessionId, @required this.apiToken});
}
