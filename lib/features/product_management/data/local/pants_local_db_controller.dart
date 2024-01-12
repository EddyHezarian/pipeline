
import 'package:hive/hive.dart';
import 'package:pipeline/core/database/hive/hive_boxes.dart';
import 'package:pipeline/features/product_management/data/models/pants_model.dart';

class PantsLocalDbController {
  Future<void> insertPants(PantsModel model) async {
    pantsBox = await Hive.openBox<PantsModel>(pantsBoxName);
    pantsBox.put(model.size, model);
    pantsBox.close();
  }

  Future<void> insertPantsIfNotExist(List<PantsModel> pantsList) async {
    pantsBox = await Hive.openBox<PantsModel>(pantsBoxName);
    for (int index = 0; index < pantsList.length; index++) {
      if (!pantsBox.containsKey(pantsList[index].size)) {
        pantsBox.put(pantsList[index].size, pantsList[index]);
      }
    }
    pantsBox.close();
  }

  Future<List<PantsModel>> getPants() async {
    List<PantsModel> pants = [];
    pantsBox = await Hive.openBox(pantsBoxName);
    for (int index = 0; index < pantsBox.length; index++) {
      pants.add(pantsBox.getAt(index));
    }
    pantsBox.close();
    return pants;
  }
}
