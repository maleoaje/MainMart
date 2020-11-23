import 'package:meta/meta.dart';

@immutable
abstract class ShoppingCartEvent {}

class GetShoppingCart extends ShoppingCartEvent {
  final String sessionId;
  final apiToken;
  GetShoppingCart({@required this.sessionId, @required this.apiToken});
}