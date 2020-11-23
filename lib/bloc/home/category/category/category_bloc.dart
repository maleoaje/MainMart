import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:ijshopflutter/model/home/category/category_model.dart';
import 'package:ijshopflutter/network/api_provider.dart';
import './bloc.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  CategoryBloc() : super(InitialCategoryState());

  @override
  Stream<CategoryState> mapEventToState(
    CategoryEvent event,
  ) async* {
    if (event is GetCategory) {
      yield* _getCategory(event.sessionId, event.apiToken);
    }
  }
}

Stream<CategoryState> _getCategory(String sessionId, apiToken) async* {
  ApiProvider _apiProvider = ApiProvider();

  yield CategoryWaiting();
  List<CategoryModel> data =
      await _apiProvider.getCategory(sessionId, apiToken);
  yield GetCategorySuccess(categoryData: data);
}
