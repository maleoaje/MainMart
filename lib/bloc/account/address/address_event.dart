import 'package:meta/meta.dart';

@immutable
abstract class AddressEvent {}

class GetAddress extends AddressEvent {
  final String sessionId;
  final apiToken;
  GetAddress({@required this.sessionId, @required this.apiToken});
}