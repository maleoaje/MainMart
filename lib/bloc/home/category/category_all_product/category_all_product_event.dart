import 'package:meta/meta.dart';

@immutable
abstract class CategoryAllProductEvent {}

class GetCategoryAllProduct extends CategoryAllProductEvent {
  final String sessionId, skip, limit;
  final int categoryId;
  final apiToken;
  GetCategoryAllProduct(
      {@required this.sessionId,
      @required this.categoryId,
      @required this.skip,
      @required this.limit,
      @required this.apiToken});
}
