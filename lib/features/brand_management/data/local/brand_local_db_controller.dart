import 'package:hive_flutter/hive_flutter.dart';
import 'package:pipeline/core/database/hive/hive_boxes.dart';
import 'package:pipeline/features/brand_management/data/model/brand_model.dart';

class BrandLocalDbController {
  Future<void> insertBrand(BrandModel model) async {
    brandBox = await Hive.openBox<BrandModel>(brandBoxName);
    brandBox.put('$model.name', model);
    brandBox.close();
  }

  Future<void> insertBrandIfNotExist(List<BrandModel> brandsList) async {
    brandBox = await Hive.openBox<BrandModel>(brandBoxName);
    for (int index = 0; index < brandsList.length; index++) {
      if (!brandBox.containsKey(brandsList[index].name)) {
        brandBox.put(brandsList[index].name, brandsList[index]);
      }
    }
    brandBox.close();
  }

  Future<List<BrandModel>> getBrands() async {
    List<BrandModel> brands = [];
    brandBox = await Hive.openBox(brandBoxName);
    for (int index = 0; index < brandBox.length; index++) {
      brands.add(brandBox.getAt(index));
    }
    brandBox.close();
    return brands;
  }
}
