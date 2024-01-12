import 'package:hive/hive.dart';
import 'package:pipeline/core/database/hive/hive_boxes.dart';
import 'package:pipeline/features/product_management/data/models/scarf_model.dart';

class ScarfLocalDbController {
  Future<void> insertScarf(ScarfModel model) async {
    scarfBox = await Hive.openBox<ScarfModel>(scarfBoxName);
    scarfBox.put(model.size, model);
    scarfBox.close();
  }

  Future<void> insertScarfIfNotExist(List<ScarfModel> pantsList) async {
    scarfBox = await Hive.openBox<ScarfModel>(scarfBoxName);
    for (int index = 0; index < pantsList.length; index++) {
      if (!scarfBox.containsKey(pantsList[index].size)) {
        scarfBox.put(pantsList[index].size, pantsList[index]);
      }
    }
    scarfBox.close();
  }

  Future<List<ScarfModel>> getScarf() async {
    List<ScarfModel> scarfs = [];
    scarfBox = await Hive.openBox(scarfBoxName);
    for (int index = 0; index < scarfBox.length; index++) {
      scarfs.add(scarfBox.getAt(index));
    }
    scarfBox.close();
    return scarfs;
  }
}
