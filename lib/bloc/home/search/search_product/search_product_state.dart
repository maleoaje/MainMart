import 'package:ijshopflutter/model/home/search/search_product_model.dart';
import 'package:meta/meta.dart';

@immutable
abstract class SearchProductState {}

class InitialSearchProductState extends SearchProductState {}

class SearchProductError extends SearchProductState {
  final String errorMessage;

  SearchProductError({
    this.errorMessage,
  });
}

class SearchProductWaiting extends SearchProductState {}

class GetSearchProductSuccess extends SearchProductState {
  final List<SearchProductModel> searchProductData;
  GetSearchProductSuccess({@required this.searchProductData});
}