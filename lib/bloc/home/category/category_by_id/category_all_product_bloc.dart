import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:ijshopflutter/model/home/category/category_by_id.dart';
import 'package:ijshopflutter/network/api_provider.dart';
import './bloc.dart';

class CategoryByIdBloc extends Bloc<CategoryByIdEvent, CategoryByIdState> {
  CategoryByIdBloc() : super(InitialCategoryByIdState());

  @override
  Stream<CategoryByIdState> mapEventToState(
    CategoryByIdEvent event,
  ) async* {
    if (event is GetCategoryById) {
      yield* _getCategoryById(event.sessionId, event.categoryId, event.skip,
          event.limit, event.apiToken);
    }
  }
}

Stream<CategoryByIdState> _getCategoryById(String sessionId, int categoryId,
    String skip, String limit, apiToken) async* {
  ApiProvider _apiProvider = ApiProvider();

  yield CategoryByIdWaiting();
  List<CategoryByIdModel> data = await _apiProvider.getCategoryById(
      sessionId, categoryId, skip, limit, apiToken);
  yield GetCategoryByIdSuccess(categoryByIdData: data);
}
