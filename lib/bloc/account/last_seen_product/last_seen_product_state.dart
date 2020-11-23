import 'package:ijshopflutter/model/account/last_seen_model.dart';
import 'package:meta/meta.dart';

@immutable
abstract class LastSeenProductState {}

class InitialLastSeenProductState extends LastSeenProductState {}

class LastSeenProductError extends LastSeenProductState {
  final String errorMessage;

  LastSeenProductError({
    this.errorMessage,
  });
}

class LastSeenProductWaiting extends LastSeenProductState {}

class GetLastSeenProductSuccess extends LastSeenProductState {
  final List<LastSeenModel> lastSeenData;
  GetLastSeenProductSuccess({@required this.lastSeenData});
}