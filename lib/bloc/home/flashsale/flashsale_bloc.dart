import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:ijshopflutter/model/home/flashsale_model.dart';
import 'package:ijshopflutter/network/api_provider.dart';
import './bloc.dart';

class FlashsaleBloc extends Bloc<FlashsaleEvent, FlashsaleState> {
  FlashsaleBloc() : super(InitialFlashsaleState());

  @override
  Stream<FlashsaleState> mapEventToState(
    FlashsaleEvent event,
  ) async* {
    if (event is GetFlashsaleHome) {
      yield* _getFlashsaleHome(
          event.sessionId, event.skip, event.limit, event.apiToken);
    } else if (event is GetFlashsale) {
      yield* _getFlashsale(
          event.sessionId, event.skip, event.limit, event.apiToken);
    }
  }
}

Stream<FlashsaleState> _getFlashsaleHome(
    String sessionId, String skip, String limit, apiToken) async* {
  ApiProvider _apiProvider = ApiProvider();

  yield FlashsaleHomeWaiting();
  List<FlashsaleModel> data =
      await _apiProvider.getFlashsale(sessionId, skip, limit, apiToken);
  yield GetFlashsaleHomeSuccess(flashsaleData: data);
}

Stream<FlashsaleState> _getFlashsale(
    String sessionId, String skip, String limit, apiToken) async* {
  ApiProvider _apiProvider = ApiProvider();

  yield FlashsaleWaiting();
  List<FlashsaleModel> data =
      await _apiProvider.getFlashsale(sessionId, skip, limit, apiToken);
  yield GetFlashsaleSuccess(flashsaleData: data);
}
