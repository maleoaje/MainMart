import 'package:ijshopflutter/model/home/category/category_banner_model.dart';
import 'package:meta/meta.dart';

@immutable
abstract class CategoryBannerState {}

class InitialCategoryBannerState extends CategoryBannerState {}

class CategoryBannerError extends CategoryBannerState {
  final String errorMessage;

  CategoryBannerError({
    this.errorMessage,
  });
}

class CategoryBannerWaiting extends CategoryBannerState {}

class GetCategoryBannerSuccess extends CategoryBannerState {
  final List<CategoryBannerModel> categoryBannerData;
  GetCategoryBannerSuccess({@required this.categoryBannerData});
}