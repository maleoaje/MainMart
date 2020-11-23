import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:ijshopflutter/model/home/category/category_banner_model.dart';
import 'package:ijshopflutter/network/api_provider.dart';
import './bloc.dart';

class CategoryBannerBloc extends Bloc<CategoryBannerEvent, CategoryBannerState> {
  CategoryBannerBloc() : super(InitialCategoryBannerState());

  @override
  Stream<CategoryBannerState> mapEventToState(
    CategoryBannerEvent event,
  ) async* {
    if(event is GetCategoryBanner){
      yield* _getCategoryBanner(event.sessionId, event.categoryId, event.apiToken);
    }
  }
}

Stream<CategoryBannerState> _getCategoryBanner(String sessionId, int categoryId, apiToken) async* {
  ApiProvider _apiProvider = ApiProvider();

  yield CategoryBannerWaiting();
  try {
    List<CategoryBannerModel> data = await _apiProvider.getCategoryBanner(sessionId, categoryId, apiToken);
    yield GetCategoryBannerSuccess(categoryBannerData: data);
  } catch (ex){
    if(ex.message != 'cancel'){
      yield CategoryBannerError(errorMessage: ex.message.toString());
    }
  }
}