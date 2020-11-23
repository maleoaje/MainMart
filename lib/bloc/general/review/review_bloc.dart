import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:ijshopflutter/model/general/review_model.dart';
import 'package:ijshopflutter/network/api_provider.dart';
import './bloc.dart';

class ReviewBloc extends Bloc<ReviewEvent, ReviewState> {
  ReviewBloc() : super(InitialReviewState());

  @override
  Stream<ReviewState> mapEventToState(
    ReviewEvent event,
  ) async* {
    if(event is GetReview){
      yield* _getReview(event.sessionId, event.skip, event.limit, event.apiToken);
    } else if(event is GetReviewProduct){
      yield* _getReviewProduct(event.sessionId, event.skip, event.limit, event.apiToken);
    }
  }
}

Stream<ReviewState> _getReview(String sessionId, String skip, String limit, apiToken) async* {
  ApiProvider _apiProvider = ApiProvider();

  yield ReviewWaiting();
  try {
    List<ReviewModel> data = await _apiProvider.getReview(sessionId, skip, limit, apiToken);
    yield GetReviewSuccess(reviewData: data);
  } catch (ex){
    if(ex.message != 'cancel'){
      yield ReviewError(errorMessage: ex.message.toString());
    }
  }
}

Stream<ReviewState> _getReviewProduct(String sessionId, String skip, String limit, apiToken) async* {
  ApiProvider _apiProvider = ApiProvider();

  yield ReviewProductWaiting();
  try {
    List<ReviewModel> data = await _apiProvider.getReview(sessionId, skip, limit, apiToken);
    yield GetReviewProductSuccess(reviewData: data);
  } catch (ex){
    if(ex.message != 'cancel'){
      yield ReviewProductError(errorMessage: ex.message.toString());
    }
  }
}