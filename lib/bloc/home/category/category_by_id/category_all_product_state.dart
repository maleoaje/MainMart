import 'package:ijshopflutter/model/home/category/category_by_id.dart';
import 'package:meta/meta.dart';

@immutable
abstract class CategoryByIdState {}

class InitialCategoryByIdState extends CategoryByIdState {}

class CategoryByIdError extends CategoryByIdState {
  final String errorMessage;

  CategoryByIdError({
    this.errorMessage,
  });
}

class CategoryByIdWaiting extends CategoryByIdState {}

class GetCategoryByIdSuccess extends CategoryByIdState {
  final List<CategoryByIdModel> categoryByIdData;
  GetCategoryByIdSuccess({@required this.categoryByIdData});
}
