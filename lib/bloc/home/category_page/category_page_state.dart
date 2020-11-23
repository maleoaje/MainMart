import 'package:ijshopflutter/model/home/category/category_page_model.dart';
import 'package:meta/meta.dart';

@immutable
abstract class CategoryPageState {}

class InitialCategoryPageState extends CategoryPageState {}

class CategoryPageError extends CategoryPageState {
  final String errorMessage;

  CategoryPageError({
    this.errorMessage,
  });
}

class CategoryPageWaiting extends CategoryPageState {}

class GetCategoryPageSuccess extends CategoryPageState {
  final List<CategoryPageModel> categoryData;
  GetCategoryPageSuccess({@required this.categoryData});
}
