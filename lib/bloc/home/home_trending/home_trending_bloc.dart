import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:ijshopflutter/model/home/trending_model.dart';
import 'package:ijshopflutter/network/api_provider.dart';
import './bloc.dart';

class HomeTrendingBloc extends Bloc<HomeTrendingEvent, HomeTrendingState> {
  HomeTrendingBloc() : super(InitialHomeTrendingState());

  @override
  Stream<HomeTrendingState> mapEventToState(
    HomeTrendingEvent event,
  ) async* {
    if (event is GetHomeTrending) {
      yield* _getHomeTrending(
          event.sessionId, event.skip, event.limit, event.apiToken);
    }
  }
}

Stream<HomeTrendingState> _getHomeTrending(
    String sessionId, String skip, String limit, apiToken) async* {
  ApiProvider _apiProvider = ApiProvider();

  yield HomeTrendingWaiting();
  List<HomeTrendingModel> data =
      await _apiProvider.getHomeTrending(sessionId, skip, limit, apiToken);
  yield GetHomeTrendingSuccess(homeTrendingData: data);
}
