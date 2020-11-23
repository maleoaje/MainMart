import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:ijshopflutter/model/home/category/category_for_you_model.dart';
import 'package:ijshopflutter/network/api_provider.dart';
import './bloc.dart';

class CategoryForYouBloc extends Bloc<CategoryForYouEvent, CategoryForYouState> {
  CategoryForYouBloc() : super(InitialCategoryForYouState());

  @override
  Stream<CategoryForYouState> mapEventToState(
    CategoryForYouEvent event,
  ) async* {
    if(event is GetCategoryForYou){
      yield* _getCategoryForYou(event.sessionId, event.apiToken);
    }
  }
}

Stream<CategoryForYouState> _getCategoryForYou(String sessionId, apiToken) async* {
  ApiProvider _apiProvider = ApiProvider();

  yield CategoryForYouWaiting();
  try {
    List<CategoryForYouModel> data = await _apiProvider.getCategoryForYou(sessionId, apiToken);
    yield GetCategoryForYouSuccess(categoryForYouData: data);
  } catch (ex){
    if(ex.message != 'cancel'){
      yield CategoryForYouError(errorMessage: ex.message.toString());
    }
  }
}