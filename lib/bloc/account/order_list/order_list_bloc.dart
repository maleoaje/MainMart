import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:ijshopflutter/model/account/order_list_model.dart';
import 'package:ijshopflutter/network/api_provider.dart';
import './bloc.dart';

class OrderListBloc extends Bloc<OrderListEvent, OrderListState> {
  OrderListBloc() : super(InitialOrderListState());

  @override
  Stream<OrderListState> mapEventToState(
    OrderListEvent event,
  ) async* {
    if(event is GetOrderList){
      yield* _getOrderList(event.sessionId, event.status, event.skip, event.limit, event.apiToken);
    }
  }
}

Stream<OrderListState> _getOrderList(String sessionId, String status, String skip, String limit, apiToken) async* {
  ApiProvider _apiProvider = ApiProvider();

  yield OrderListWaiting();
  try {
    List<OrderListModel> data = await _apiProvider.getOrderList(sessionId, status, skip, limit, apiToken);
    yield GetOrderListSuccess(orderListData: data);
  } catch (ex){
    if(ex.message != 'cancel'){
      yield OrderListError(errorMessage: ex.message.toString());
    }
  }
}