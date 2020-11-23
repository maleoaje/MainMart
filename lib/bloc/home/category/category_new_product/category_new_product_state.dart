import 'package:ijshopflutter/model/home/category/category_new_product_model.dart';
import 'package:meta/meta.dart';

@immutable
abstract class CategoryNewProductState {}

class InitialCategoryNewProductState extends CategoryNewProductState {}

class CategoryNewProductError extends CategoryNewProductState {
  final String errorMessage;

  CategoryNewProductError({
    this.errorMessage,
  });
}

class CategoryNewProductWaiting extends CategoryNewProductState {}

class GetCategoryNewProductSuccess extends CategoryNewProductState {
  final List<CategoryNewProductModel> categoryNewProductData;
  GetCategoryNewProductSuccess({@required this.categoryNewProductData});
}