import 'package:ijshopflutter/model/home/category/category_all_product_model.dart';
import 'package:meta/meta.dart';

@immutable
abstract class CategoryAllProductState {}

class InitialCategoryAllProductState extends CategoryAllProductState {}

class CategoryAllProductError extends CategoryAllProductState {
  final String errorMessage;

  CategoryAllProductError({
    this.errorMessage,
  });
}

class CategoryAllProductWaiting extends CategoryAllProductState {}

class GetCategoryAllProductSuccess extends CategoryAllProductState {
  final List<CategoryAllProductModel> categoryAllProductData;
  GetCategoryAllProductSuccess({@required this.categoryAllProductData});
}