import 'package:ijshopflutter/model/home/trending_model.dart';
import 'package:meta/meta.dart';

@immutable
abstract class HomeTrendingState {}

class InitialHomeTrendingState extends HomeTrendingState {}

class HomeTrendingError extends HomeTrendingState {
  final String errorMessage;

  HomeTrendingError({
    this.errorMessage,
  });
}

class HomeTrendingWaiting extends HomeTrendingState {}

class GetHomeTrendingSuccess extends HomeTrendingState {
  final List<HomeTrendingModel> homeTrendingData;
  GetHomeTrendingSuccess({@required this.homeTrendingData});
}