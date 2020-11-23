import 'package:meta/meta.dart';

@immutable
abstract class CategoryBannerEvent {}

class GetCategoryBanner extends CategoryBannerEvent {
  final String sessionId;
  final int categoryId;
  final apiToken;
  GetCategoryBanner({@required this.sessionId, @required this.categoryId, @required this.apiToken});
}