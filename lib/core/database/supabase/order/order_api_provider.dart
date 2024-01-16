import 'package:flutter/material.dart';
import 'package:pipeline/configs/components/snack_bars.dart';
import 'package:pipeline/core/database/supabase/supabase.dart';
import 'package:pipeline/core/model/order_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class OrderApiProvider {
  Future<void> addOrder(
      {required OrderModel order, required BuildContext context}) async {
    try {
      await supabase.from('Orders').upsert(order.toMap());
      if (context.mounted) {
        showSuccessSnackBar(context);
        Navigator.pop(context);
      }
    } catch (e) {
      if (e is PostgrestException && e.code == 'PGRST301') {
        try {
          await supabase.auth.refreshSession();
          await supabase.from('Orders').upsert(order.toMap());
          if (context.mounted) {
            showSuccessSnackBar(context);
            Navigator.pop(context);
          }
        } catch (e) {
          if (context.mounted) {
            showFailedSnackBar(context);
          }
          debugPrint(e.toString());
        }
      }
    }
  }

  Future<List<OrderModel>> getOrders(
      {required String brandName, required String status}) async {
    List<OrderModel> data = [];
    try {
      var response = await supabase
          .from('Orders')
          .select()
          .match({'brand_name': brandName, 'status': status});
      data = (response as List).map((e) => OrderModel.fromJson(e)).toList();
    } catch (error) {
      if (error is PostgrestException && error.code == 'PGRST301') {
        try {
          await supabase.auth.refreshSession();
          var response = await supabase
              .from('Orders')
              .select()
              .match({'brand_name': brandName, 'status': status});
          data = (response as List).map((e) => OrderModel.fromJson(e)).toList();
        } catch (error) {
          debugPrint(error.toString());
        }
      }
    }
    return data;
  }

  Future<bool> deleteOrder(OrderModel model) async {
    bool isSuccessfulDelete = true;
    try {
      await supabase.from('Orders').delete().eq('id', model.id);
    } catch (error) {
      if (error is PostgrestException && error.code == 'PGRST301') {
        try {
          await supabase.from('Orders').delete().eq('id', model.id);
        } catch (e) {
          isSuccessfulDelete = false;
        }
      }
    }

    return isSuccessfulDelete;
  }

  Future<bool> updateOrder(OrderModel model, String status) async {
    bool isSuccessfulUpdate = true;
    try {
      await supabase
          .from('Orders')
          .update({'status': status}).match({'id': model.id});
    } catch (error) {
      if (error is PostgrestException && error.code == 'PGRST301') {
        try {
          await supabase
              .from('Orders')
              .update({'id': model.id}).eq('status', status);
        } catch (e) {
          isSuccessfulUpdate = false;
        }
      }
    }

    return isSuccessfulUpdate;
  }
}
