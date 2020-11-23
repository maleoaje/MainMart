import 'package:meta/meta.dart';

@immutable
abstract class WishlistEvent {}

class GetWishlist extends WishlistEvent {
  final String sessionId;
  final apiToken;
  GetWishlist({@required this.sessionId, @required this.apiToken});
}