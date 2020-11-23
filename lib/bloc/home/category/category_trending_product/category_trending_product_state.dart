import 'package:ijshopflutter/model/home/category/category_trending_product_model.dart';
import 'package:meta/meta.dart';

@immutable
abstract class CategoryTrendingProductState {}

class InitialCategoryTrendingProductState extends CategoryTrendingProductState {}

class CategoryTrendingProductError extends CategoryTrendingProductState {
  final String errorMessage;

  CategoryTrendingProductError({
    this.errorMessage,
  });
}

class CategoryTrendingProductWaiting extends CategoryTrendingProductState {}

class GetCategoryTrendingProductSuccess extends CategoryTrendingProductState {
  final List<CategoryTrendingProductModel> categoryTrendingProductData;
  GetCategoryTrendingProductSuccess({@required this.categoryTrendingProductData});
}