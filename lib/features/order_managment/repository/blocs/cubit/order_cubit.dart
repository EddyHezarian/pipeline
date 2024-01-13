import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:pipeline/core/database/supabase/order/order_api_provider.dart';
import 'package:pipeline/core/model/order_model.dart';

part 'order_state.dart';

class OrderCubit extends Cubit<OrderState> {
  OrderCubit(this.orderApiProvider) : super(InitialOrderState());

  OrderApiProvider orderApiProvider;

  void loadOrders({required String brandName, required String status}) {
    if (state is LoadingOrdersState) {
      return;
    }
    final current = state;
    if (current is FetchedOrdersState) {
      current.freshOrders.clear();
    }

    //! refresh list by api
    emit(LoadingOrdersState());
    orderApiProvider
        .getOrders(brandName: brandName, status: status)
        .then((orderList) {
      emit(FetchedOrdersState(orderList));
    });
  }
}
