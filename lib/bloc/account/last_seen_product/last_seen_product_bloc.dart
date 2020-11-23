import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:ijshopflutter/model/account/last_seen_model.dart';
import 'package:ijshopflutter/network/api_provider.dart';
import './bloc.dart';

class LastSeenProductBloc extends Bloc<LastSeenProductEvent, LastSeenProductState> {
  LastSeenProductBloc() : super(InitialLastSeenProductState());

  @override
  Stream<LastSeenProductState> mapEventToState(
    LastSeenProductEvent event,
  ) async* {
    if(event is GetLastSeenProduct){
      yield* _getLastSeenProduct(event.sessionId, event.skip, event.limit, event.apiToken);
    }
  }
}

Stream<LastSeenProductState> _getLastSeenProduct(String sessionId, String skip, String limit, apiToken) async* {
  ApiProvider _apiProvider = ApiProvider();

  yield LastSeenProductWaiting();
  try {
    List<LastSeenModel> data = await _apiProvider.getLastSeenProduct(sessionId, skip, limit, apiToken);
    yield GetLastSeenProductSuccess(lastSeenData: data);
  } catch (ex){
    if(ex.message != 'cancel'){
      yield LastSeenProductError(errorMessage: ex.message.toString());
    }
  }
}