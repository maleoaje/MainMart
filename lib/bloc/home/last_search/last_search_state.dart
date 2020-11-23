import 'package:ijshopflutter/model/home/last_search_model.dart';
import 'package:meta/meta.dart';

@immutable
abstract class LastSearchState {}

class InitialLastSearchState extends LastSearchState {}

class LastSearchError extends LastSearchState {
  final String errorMessage;

  LastSearchError({
    this.errorMessage,
  });
}

class LastSearchHomeError extends LastSearchState {
  final String errorMessage;

  LastSearchHomeError({
    this.errorMessage,
  });
}

class LastSearchWaiting extends LastSearchState {}

class LastSearchHomeWaiting extends LastSearchState {}

class GetLastSearchSuccess extends LastSearchState {
  final List<LastSearchModel> lastSearchData;
  GetLastSearchSuccess({@required this.lastSearchData});
}

class GetLastSearchHomeSuccess extends LastSearchState {
  final List<LastSearchModel> lastSearchData;
  GetLastSearchHomeSuccess({@required this.lastSearchData});
}