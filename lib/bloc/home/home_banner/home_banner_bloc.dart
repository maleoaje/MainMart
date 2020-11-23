import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:ijshopflutter/model/home/home_banner_model.dart';
import 'package:ijshopflutter/network/api_provider.dart';
import './bloc.dart';

class HomeBannerBloc extends Bloc<HomeBannerEvent, HomeBannerState> {
  HomeBannerBloc() : super(InitialHomeBannerState());

  @override
  Stream<HomeBannerState> mapEventToState(
    HomeBannerEvent event,
  ) async* {
    if(event is GetHomeBanner){
      yield* _getHomeBanner(event.sessionId, event.apiToken);
    }
  }
}

Stream<HomeBannerState> _getHomeBanner(String sessionId, apiToken) async* {
  ApiProvider _apiProvider = ApiProvider();

  yield HomeBannerWaiting();
  try {
    List<HomeBannerModel> data = await _apiProvider.getHomeBanner(sessionId, apiToken);
    yield GetHomeBannerSuccess(homeBannerData: data);
  } catch (ex){
    if(ex.message != 'cancel'){
      yield HomeBannerError(errorMessage: ex.message.toString());
    }
  }
}