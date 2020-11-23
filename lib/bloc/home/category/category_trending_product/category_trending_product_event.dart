import 'package:meta/meta.dart';

@immutable
abstract class CategoryTrendingProductEvent {}

class GetCategoryTrendingProduct extends CategoryTrendingProductEvent {
  final String sessionId, skip, limit;
  final int categoryId;
  final apiToken;
  GetCategoryTrendingProduct({@required this.sessionId, @required this.categoryId, @required this.skip, @required this.limit, @required this.apiToken});
}