import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:ijshopflutter/model/home/last_search_model.dart';
import 'package:ijshopflutter/network/api_provider.dart';
import './bloc.dart';

class LastSearchBloc extends Bloc<LastSearchEvent, LastSearchState> {
  LastSearchBloc() : super(InitialLastSearchState());

  @override
  Stream<LastSearchState> mapEventToState(
    LastSearchEvent event,
  ) async* {
    if (event is GetLastSearchHome) {
      yield* _getLastSearchHome(
          event.sessionId, event.skip, event.limit, event.apiToken);
    } else if (event is GetLastSearch) {
      yield* _getLastSearch(
          event.sessionId, event.skip, event.limit, event.apiToken);
    }
  }
}

Stream<LastSearchState> _getLastSearchHome(
    String sessionId, String skip, String limit, apiToken) async* {
  ApiProvider _apiProvider = ApiProvider();

  yield LastSearchHomeWaiting();
  List<LastSearchModel> data =
      await _apiProvider.getLastSearch(sessionId, skip, limit, apiToken);
  yield GetLastSearchHomeSuccess(lastSearchData: data);
}

Stream<LastSearchState> _getLastSearch(
    String sessionId, String skip, String limit, apiToken) async* {
  ApiProvider _apiProvider = ApiProvider();

  yield LastSearchWaiting();
  List<LastSearchModel> data = await _apiProvider.getLastSearchInfinite(
      sessionId, skip, limit, apiToken);
  yield GetLastSearchSuccess(lastSearchData: data);
}
