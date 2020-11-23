import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:ijshopflutter/model/home/category/category_new_product_model.dart';
import 'package:ijshopflutter/network/api_provider.dart';
import './bloc.dart';

class CategoryNewProductBloc extends Bloc<CategoryNewProductEvent, CategoryNewProductState> {
  CategoryNewProductBloc() : super(InitialCategoryNewProductState());

  @override
  Stream<CategoryNewProductState> mapEventToState(
    CategoryNewProductEvent event,
  ) async* {
    if(event is GetCategoryNewProduct){
      yield* _getCategoryNewProduct(event.sessionId, event.categoryId, event.skip, event.limit, event.apiToken);
    }
  }
}

Stream<CategoryNewProductState> _getCategoryNewProduct(String sessionId, int categoryId, String skip, String limit, apiToken) async* {
  ApiProvider _apiProvider = ApiProvider();

  yield CategoryNewProductWaiting();
  try {
    List<CategoryNewProductModel> data = await _apiProvider.getCategoryNewProduct(sessionId, categoryId, skip, limit, apiToken);
    yield GetCategoryNewProductSuccess(categoryNewProductData: data);
  } catch (ex){
    if(ex.message != 'cancel'){
      yield CategoryNewProductError(errorMessage: ex.message.toString());
    }
  }
}