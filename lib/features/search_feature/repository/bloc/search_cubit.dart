import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pipeline/core/database/supabase/order/order_api_provider.dart';
import 'package:pipeline/core/model/order_model.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit(this.orderApiProvider) : super(InitialSearchState());
  OrderApiProvider orderApiProvider;

  void refresh() {
    emit(InitialSearchState());
  }

  void searchForName(String name) async {
    if (state is LoadingSearchState) return;
    final currentState = state;
    if (currentState is SuccessSearchState) {
      currentState.items.clear();
    }

    emit(LoadingSearchState());
    await orderApiProvider.searchByName(customerName: name).then((value) {
      if (value.isEmpty) {
        emit(FailedSearchState());
      } else {
        emit(SuccessSearchState(value));
      }
    });
  }
}
