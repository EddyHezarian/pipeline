import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:pipeline/core/database/supabase/order/order_api_provider.dart';
import 'package:pipeline/features/product_management/data/local/pants_local_db_controller.dart';
import 'package:pipeline/features/product_management/data/local/scarf_local_db_controller.dart';
import 'package:pipeline/features/product_management/data/local/shirt_local_db_controller.dart';
import 'package:pipeline/features/product_management/data/models/pants_model.dart';
import 'package:pipeline/features/product_management/data/models/scarf_model.dart';
import 'package:pipeline/features/product_management/data/models/shirt_model.dart';
import 'package:pipeline/locator.dart';

part 'chart_state.dart';

class CahrtCubit extends Cubit<ChartState> {
  CahrtCubit(this.orderApiProvider) : super(InitialChartState());
  OrderApiProvider orderApiProvider;

  calculateChartForBrand({required String brandName}) async {
    List<Map<String, int>> finalChart = [];
    if (state is LoadingChartState) return;
    final current = state;
    if (current is FetchedChartState) {
      current.mapdata.clear();
    }
    ShirtLocalDbController shirtsInLocalDB = locator();
    PantsLocalDbController pantsInLocalDB = locator();
    ScarfLocalDbController scarfInLocalDB = locator();

    emit(LoadingChartState());

    //! list of products in list
    List<ShirtModel> shirts = await shirtsInLocalDB.getShirts();
    List<PantsModel> pants = await pantsInLocalDB.getPants();
    List<ScarfModel> scarf = await scarfInLocalDB.getScarf();

    //! convert list into maps

    Map<String, int> shirtMap = {};
    Map<String, int> pantsMap = {};
    Map<String, int> scarfMap = {};
    for (int index = 0; index < shirts.length; index++) {
      shirtMap.addAll({shirts[index].size: 0});
    }
    for (int index = 0; index < pants.length; index++) {
      pantsMap.addAll({pants[index].size: 0});
    }
    for (int index = 0; index < scarf.length; index++) {
      scarfMap.addAll({scarf[index].size: 0});
    }

  await  orderApiProvider
        .getOrders(brandName: brandName, status: "OPEN")
        .then((orders) {
      for (int index = 0; index < orders.length; index++) {
        shirtMap.update(
            orders[index].shirtSize, (value) => value + orders[index].shirtQTY);
        pantsMap.update(
            orders[index].pantsSize, (value) => value + orders[index].pantsQTY);
        scarfMap.update(
            orders[index].scarfSize, (value) => value + orders[index].scarfQTY);
      }
    });
    finalChart.add(shirtMap);
    finalChart.add(pantsMap);
    finalChart.add(scarfMap);

    emit(FetchedChartState(finalChart));
  }
}
