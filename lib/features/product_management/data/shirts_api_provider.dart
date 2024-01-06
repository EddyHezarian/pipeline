import 'package:flutter/material.dart';
import 'package:pipeline/core/models/product_model.dart';
import 'package:pipeline/core/supabase/supabase.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ShirtsApiProvider {
  Future<List<ShirtModel>> getShirts() async {
    List<ShirtModel> data = [];
    try {
      var response = await supabase.from('shirt').select();
      data = (response as List).map((e) => ShirtModel.fromJson(e)).toList();
    } catch (e) {
      if (e is PostgrestException && e.code == 'PGRST301') {
        try {
          await supabase.auth.refreshSession();
          var response = await supabase.from('shirt').select();
          data = (response as List).map((e) => ShirtModel.fromJson(e)).toList();
        } catch (e) {
          debugPrint(e.toString());
        }
      }
    }
    return data;
  }

  Future<bool> isExistShirt({
    required String name,
  }) async {
    List<ShirtModel> data = [];
    bool isExistAny = false;
    try {
      var response = await supabase.from('shirt').select().eq('size', name);
      data = (response as List).map((e) => ShirtModel.fromJson(e)).toList();
      data.isEmpty ? isExistAny = false : isExistAny = true;
    } catch (e) {
      if (e is PostgrestException && e.code == 'PGRST301') {
        try {
          await supabase.auth.refreshSession();
          var response =
              await supabase.from('shirt').select().eq('size', name);
          data = (response as List).map((e) => ShirtModel.fromJson(e)).toList();
          data.isEmpty ? isExistAny = false : isExistAny = true;
        } catch (e) {
          return true;
        }
      }
    }
    return isExistAny;
  }

  Future<void> addShirt({required ShirtModel product}) async {
    try {
      await supabase.from('shirt').upsert(product.toMap());
    } catch (e) {
      if (e is PostgrestException && e.code == 'PGRST301') {
        try {
          await supabase.auth.refreshSession();
          await supabase.from('shirt').upsert(product.toMap());
        } catch (e) {
          debugPrint(e.toString());
        }
      }
    }
  }

  Future<void> deleteShirt({required String name}) async {
    try {
       await supabase.from('shirt').delete().eq('size', name);
    } catch (e) {
      debugPrint(e.toString());

    }
  }
}
