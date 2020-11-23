import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:ijshopflutter/model/home/search/search_product_model.dart';
import 'package:ijshopflutter/network/api_provider.dart';
import './bloc.dart';

class SearchProductBloc extends Bloc<SearchProductEvent, SearchProductState> {
  SearchProductBloc() : super(InitialSearchProductState());

  @override
  Stream<SearchProductState> mapEventToState(
    SearchProductEvent event,
  ) async* {
    if (event is GetSearchProduct) {
      yield* _getSearchProduct(event.sessionId, event.search, event.skip,
          event.limit, event.apiToken);
    }
  }
}

Stream<SearchProductState> _getSearchProduct(String sessionId, String search,
    String skip, String limit, apiToken) async* {
  ApiProvider _apiProvider = ApiProvider();

  yield SearchProductWaiting();
  List<SearchProductModel> data = await _apiProvider.getSearchProduct(
      sessionId, search, skip, limit, apiToken);
  yield GetSearchProductSuccess(searchProductData: data);
}
