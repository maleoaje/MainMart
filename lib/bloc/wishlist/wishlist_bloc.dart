import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:ijshopflutter/model/wishlist/wishlist_model.dart';
import 'package:ijshopflutter/network/api_provider.dart';
import './bloc.dart';

class WishlistBloc extends Bloc<WishlistEvent, WishlistState> {
  WishlistBloc() : super(InitialWishlistState());

  @override
  Stream<WishlistState> mapEventToState(
    WishlistEvent event,
  ) async* {
    if(event is GetWishlist){
      yield* _getWishlist(event.sessionId, event.apiToken);
    }
  }
}

Stream<WishlistState> _getWishlist(String sessionId, apiToken) async* {
  ApiProvider _apiProvider = ApiProvider();

  yield WishlistWaiting();
  try {
    List<WishlistModel> data = await _apiProvider.getWishlist(sessionId, apiToken);
    yield GetWishlistSuccess(wishlistData: data);
  } catch (ex){
    if(ex.message != 'cancel'){
      yield WishlistError(errorMessage: ex.message.toString());
    }
  }
}
