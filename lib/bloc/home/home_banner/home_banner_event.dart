import 'package:meta/meta.dart';

@immutable
abstract class HomeBannerEvent {}

class GetHomeBanner extends HomeBannerEvent {
  final String sessionId;
  final apiToken;
  GetHomeBanner({@required this.sessionId, @required this.apiToken});
}