
import 'package:flutter/material.dart';
import 'package:pipeline/core/models/product_model.dart';
import 'package:pipeline/core/supabase/supabase.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ScarfApiProvider {
  Future<List<ScarfModel>> getScarf() async {
    List<ScarfModel> data = [];
    try {
      var response = await supabase.from('scarf').select();
      data = (response as List).map((e) => ScarfModel.fromJson(e)).toList();
    } catch (e) {
      if (e is PostgrestException && e.code == 'PGRST301') {
        try {
          await supabase.auth.refreshSession();
          var response = await supabase.from('scarf').select();
          data = (response as List).map((e) => ScarfModel.fromJson(e)).toList();
        } catch (e) {
          debugPrint(e.toString());
        }
      }
    }
    return data;
  }

  Future<bool> isExistScarf({
    required String name,
  }) async {
    List<ScarfModel> data = [];
    bool isExistAny = false;
    try {
      var response = await supabase.from('scarf').select().eq('size', name);
      data = (response as List).map((e) => ScarfModel.fromJson(e)).toList();
      data.isEmpty ? isExistAny = false : isExistAny = true;
    } catch (e) {
      if (e is PostgrestException && e.code == 'PGRST301') {
        try {
          await supabase.auth.refreshSession();
          var response =
              await supabase.from('scarf').select().eq('size', name);
          data = (response as List).map((e) => ScarfModel.fromJson(e)).toList();
          data.isEmpty ? isExistAny = false : isExistAny = true;
        } catch (e) {
          return true;
        }
      }
    }
    return isExistAny;
  }

  Future<void> addScarf({required ScarfModel product}) async {
    try {
      await supabase.from('scarf').upsert(product.toMap());
    } catch (e) {
      if (e is PostgrestException && e.code == 'PGRST301') {
        try {
          await supabase.auth.refreshSession();
          await supabase.from('scarf').upsert(product.toMap());
        } catch (e) {
          debugPrint(e.toString());
        }
      }
    }
  }

  Future<void> deleteScarf({required String name}) async {
    try {
       await supabase.from('shirt').delete().eq('size', name);
    } catch (e) {
      debugPrint(e.toString());

    }
  }
}
