import 'package:meta/meta.dart';

@immutable
abstract class CategoryEvent {}

class GetCategory extends CategoryEvent {
  final String sessionId;
  final apiToken;
  GetCategory({@required this.sessionId, @required this.apiToken});
}