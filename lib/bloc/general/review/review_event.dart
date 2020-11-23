import 'package:meta/meta.dart';

@immutable
abstract class ReviewEvent {}

class GetReview extends ReviewEvent {
  final String sessionId, skip, limit;
  final apiToken;
  GetReview({@required this.sessionId, @required this.skip, @required this.limit, @required this.apiToken});
}

class GetReviewProduct extends ReviewEvent {
  final String sessionId, skip, limit;
  final apiToken;
  GetReviewProduct({@required this.sessionId, @required this.skip, @required this.limit, @required this.apiToken});
}