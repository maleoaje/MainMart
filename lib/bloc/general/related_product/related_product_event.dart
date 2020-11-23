import 'package:meta/meta.dart';

@immutable
abstract class RelatedProductEvent {}

class GetRelatedProduct extends RelatedProductEvent {
  final String sessionId;
  final apiToken;
  GetRelatedProduct({@required this.sessionId, @required this.apiToken});
}