import 'package:flutter/material.dart';
import 'package:pipeline/core/database/supabase/supabase.dart';
import 'package:pipeline/features/product_management/data/local/pants_local_db_controller.dart';
import 'package:pipeline/features/product_management/data/models/pants_model.dart';

import 'package:supabase_flutter/supabase_flutter.dart';

class PantsApiProvider {
  PantsLocalDbController hiveController = PantsLocalDbController();
  Future<List<PantsModel>> getPants() async {
    List<PantsModel> data = [];
    try {
      var response = await supabase.from('pants').select();
      data = (response as List).map((e) => PantsModel.fromJson(e)).toList();
      hiveController.insertPantsIfNotExist(data);
    } catch (e) {
      if (e is PostgrestException && e.code == 'PGRST301') {
        try {
          await supabase.auth.refreshSession();
          var response = await supabase.from('pants').select();
          data = (response as List).map((e) => PantsModel.fromJson(e)).toList();
          hiveController.insertPantsIfNotExist(data);
        } catch (e) {
          debugPrint(e.toString());
        }
      }
    }
    return data;
  }

  Future<bool> isExistPants({
    required String name,
  }) async {
    List<PantsModel> data = [];
    bool isExistAny = false;
    try {
      var response = await supabase.from('pants').select().eq('size', name);
      data = (response as List).map((e) => PantsModel.fromJson(e)).toList();
      data.isEmpty ? isExistAny = false : isExistAny = true;
    } catch (e) {
      if (e is PostgrestException && e.code == 'PGRST301') {
        try {
          await supabase.auth.refreshSession();
          var response = await supabase.from('pants').select().eq('size', name);
          data = (response as List).map((e) => PantsModel.fromJson(e)).toList();
          data.isEmpty ? isExistAny = false : isExistAny = true;
        } catch (e) {
          return true;
        }
      }
    }
    return isExistAny;
  }

  Future<void> addPants({required PantsModel product}) async {
    try {
      await supabase.from('pants').upsert(product.toMap());
    } catch (e) {
      if (e is PostgrestException && e.code == 'PGRST301') {
        try {
          await supabase.auth.refreshSession();
          await supabase.from('pants').upsert(product.toMap());
        } catch (e) {
          debugPrint(e.toString());
        }
      }
    }
  }

  Future<void> deletePants({required String name}) async {
    try {
      await supabase.from('pants').delete().eq('size', name);
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
