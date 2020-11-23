import 'package:ijshopflutter/model/account/order_list_model.dart';
import 'package:meta/meta.dart';

@immutable
abstract class OrderListState {}

class InitialOrderListState extends OrderListState {}

class OrderListError extends OrderListState {
  final String errorMessage;

  OrderListError({
    this.errorMessage,
  });
}

class OrderListWaiting extends OrderListState {}

class GetOrderListSuccess extends OrderListState {
  final List<OrderListModel> orderListData;
  GetOrderListSuccess({@required this.orderListData});
}