import 'package:ijshopflutter/model/shopping_cart/shopping_cart_model.dart';
import 'package:meta/meta.dart';

@immutable
abstract class ShoppingCartState {}

class InitialShoppingCartState extends ShoppingCartState {}

class ShoppingCartError extends ShoppingCartState {
  final String errorMessage;

  ShoppingCartError({
    this.errorMessage,
  });
}

class ShoppingCartWaiting extends ShoppingCartState {}

class GetShoppingCartSuccess extends ShoppingCartState {
  final List<ShoppingCartModel> shoppingCartData;
  GetShoppingCartSuccess({@required this.shoppingCartData});
}