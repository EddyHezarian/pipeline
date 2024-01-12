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
      } else {
        print(e.toString());
      }
    }
  }
}
