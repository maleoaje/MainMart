import 'package:meta/meta.dart';

@immutable
abstract class CategoryNewProductEvent {}

class GetCategoryNewProduct extends CategoryNewProductEvent {
  final String sessionId, skip, limit;
  final int categoryId;
  final apiToken;
  GetCategoryNewProduct({@required this.sessionId, @required this.categoryId, @required this.skip, @required this.limit, @required this.apiToken});
}