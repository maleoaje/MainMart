import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:ijshopflutter/model/home/recomended_product_model.dart';
import 'package:ijshopflutter/network/api_provider.dart';
import './bloc.dart';

class RecomendedProductBloc
    extends Bloc<RecomendedProductEvent, RecomendedProductState> {
  RecomendedProductBloc() : super(InitialRecomendedProductState());

  @override
  Stream<RecomendedProductState> mapEventToState(
    RecomendedProductEvent event,
  ) async* {
    if (event is GetRecomendedProduct) {
      yield* _getRecomendedProduct(
          event.sessionId, event.skip, event.limit, event.apiToken);
    }
  }
}

Stream<RecomendedProductState> _getRecomendedProduct(
    String sessionId, String skip, String limit, apiToken) async* {
  ApiProvider _apiProvider = ApiProvider();

  yield RecomendedProductWaiting();
  List<RecomendedProductModel> data =
      await _apiProvider.getRecomendedProduct(sessionId, skip, limit, apiToken);
  yield GetRecomendedProductSuccess(recomendedProductData: data);
}
