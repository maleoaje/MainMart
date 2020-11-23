import 'package:meta/meta.dart';

@immutable
abstract class FlashsaleEvent {}

class GetFlashsaleHome extends FlashsaleEvent {
  final String sessionId, skip, limit;
  final apiToken;
  GetFlashsaleHome({@required this.sessionId, @required this.skip, @required this.limit, @required this.apiToken});
}

class GetFlashsale extends FlashsaleEvent {
  final String sessionId, skip, limit;
  final apiToken;
  GetFlashsale({@required this.sessionId, @required this.skip, @required this.limit, @required this.apiToken});
}