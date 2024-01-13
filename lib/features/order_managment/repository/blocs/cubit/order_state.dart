part of 'order_cubit.dart';

@immutable
sealed class OrderState {}

final class LoadingOrdersState extends OrderState {

}

final class FetchedOrdersState extends OrderState {
  final List<OrderModel> freshOrders;
  FetchedOrdersState(this.freshOrders);
}


class InitialOrderState extends OrderState {}
