import 'package:ijshopflutter/model/wishlist/wishlist_model.dart';
import 'package:meta/meta.dart';

@immutable
abstract class WishlistState {}

class InitialWishlistState extends WishlistState {}

class WishlistError extends WishlistState {
  final String errorMessage;

  WishlistError({
    this.errorMessage,
  });
}

class WishlistWaiting extends WishlistState {}

class GetWishlistSuccess extends WishlistState {
  final List<WishlistModel> wishlistData;
  GetWishlistSuccess({@required this.wishlistData});
}