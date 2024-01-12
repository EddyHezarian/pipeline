import 'package:hive/hive.dart';
import 'package:pipeline/core/database/hive/hive_boxes.dart';
import 'package:pipeline/features/product_management/data/models/shirt_model.dart';

class ShirtLocalDbController {
  Future<void> insertShirt(ShirtModel model) async {
    shirtsBox = await Hive.openBox<ShirtModel>(shirtBoxName);
    shirtsBox.put(model.size, model);
    shirtsBox.close();
  }

  Future<void> insertShirtIfNotExist(List<ShirtModel> shirtList) async {
    shirtsBox = await Hive.openBox<ShirtModel>(shirtBoxName);
    for (int index = 0; index < shirtList.length; index++) {
      if (!shirtsBox.containsKey(shirtList[index].size)) {
        shirtsBox.put(shirtList[index].size, shirtList[index]);
      }
    }
    shirtsBox.close();
  }

  Future<List<ShirtModel>> getShirts() async {
    List<ShirtModel> shirts = [];
    shirtsBox = await Hive.openBox(shirtBoxName);
    for (int index = 0; index < shirtsBox.length; index++) {
      shirts.add(shirtsBox.getAt(index));
    }
    shirtsBox.close();
    return shirts;
  }
}
