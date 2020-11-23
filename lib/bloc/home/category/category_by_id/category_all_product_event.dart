import 'package:meta/meta.dart';

@immutable
abstract class CategoryByIdEvent {}

class GetCategoryById extends CategoryByIdEvent {
  final String sessionId, skip, limit;
  final int categoryId;
  final apiToken;
  GetCategoryById(
      {@required this.sessionId,
      @required this.categoryId,
      @required this.skip,
      @required this.limit,
      @required this.apiToken});
}
