import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:ijshopflutter/model/home/category/category_page_model.dart';
import 'package:ijshopflutter/network/api_provider.dart';
import 'bloc.dart';

class CategoryPageBloc extends Bloc<CategoryPageEvent, CategoryPageState> {
  CategoryPageBloc() : super(InitialCategoryPageState());

  @override
  Stream<CategoryPageState> mapEventToState(
    CategoryPageEvent event,
  ) async* {
    if (event is GetCategoryPage) {
      yield* _getCategory(event.sessionId, event.apiToken);
    }
  }
}

Stream<CategoryPageState> _getCategory(String sessionId, apiToken) async* {
  ApiProvider _apiProvider = ApiProvider();

  yield CategoryPageWaiting();
  List<CategoryPageModel> data =
      await _apiProvider.getCategoryPage(sessionId, apiToken);
  yield GetCategoryPageSuccess(categoryData: data);
}
