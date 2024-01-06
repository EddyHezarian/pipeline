import 'package:flutter/material.dart';
import 'package:pipeline/core/models/brand_model.dart';
import 'package:pipeline/core/supabase/supabase.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class BrandsApiProvider {
  Future<List<BrandModel>> getBrands() async {
    List<BrandModel> data = [];
    try {
      var response = await supabase.from('brand').select();
      data = (response as List).map((e) => BrandModel.fromJson(e)).toList();
    } catch (e) {
      if (e is PostgrestException && e.code == 'PGRST301') {
        try {
          await supabase.auth.refreshSession();
          var response = await supabase.from('brand').select();
          data = (response as List).map((e) => BrandModel.fromJson(e)).toList();
        } catch (e) {
          debugPrint(e.toString());
        }
      }
    }
    return data;
  }

  Future<bool> isExistBrand({
    required String name,
  }) async {
    List<BrandModel> data = [];
    bool isExistAny = false;
    try {
      var response = await supabase.from('brand').select().eq('name', name);
      data = (response as List).map((e) => BrandModel.fromJson(e)).toList();
      data.isEmpty ? isExistAny = false : isExistAny = true;
    } catch (e) {
      if (e is PostgrestException && e.code == 'PGRST301') {
        try {
          await supabase.auth.refreshSession();
          var response =
              await supabase.from('brand').select().eq('brand', name);
          data = (response as List).map((e) => BrandModel.fromJson(e)).toList();
          data.isEmpty ? isExistAny = false : isExistAny = true;
        } catch (e) {
          return true;
        }
      }
    }
    return isExistAny;
  }

  Future<void> addBrand({required BrandModel brand}) async {
    try {
      await supabase.from('brand').upsert(brand.toMap());
    } catch (e) {
      if (e is PostgrestException && e.code == 'PGRST301') {
        try {
          await supabase.auth.refreshSession();
          await supabase.from('brand').upsert(brand.toMap());
        } catch (e) {
          debugPrint(e.toString());
        }
      }
    }
  }

  Future<void> deletBrand({required String name}) async {
    try {
       await supabase.from('brand').delete().eq('name', name);
    } catch (e) {
      debugPrint(e.toString());

    }
  }
}
