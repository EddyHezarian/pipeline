import 'package:get_it/get_it.dart';
import 'package:pipeline/core/database/supabase/order/order_api_provider.dart';
import 'package:pipeline/features/brand_management/data/local/brand_local_db_controller.dart';
import 'package:pipeline/features/brand_management/data/remote/brand_api_provider.dart';
import 'package:pipeline/features/product_management/data/local/pants_local_db_controller.dart';
import 'package:pipeline/features/product_management/data/local/scarf_local_db_controller.dart';
import 'package:pipeline/features/product_management/data/local/shirt_local_db_controller.dart';
import 'package:pipeline/features/product_management/data/remote/pants_api_provider.dart';
import 'package:pipeline/features/product_management/data/remote/scarf_api_provider.dart';
import 'package:pipeline/features/product_management/data/remote/shirts_api_provider.dart';

var locator = GetIt.instance;

Future<void> initLocator() async {
  
  locator.registerSingleton<BrandsApiProvider>(BrandsApiProvider());

  locator.registerSingleton<OrderApiProvider>(OrderApiProvider());
  
  locator.registerSingleton<BrandLocalDbController>(BrandLocalDbController());

  locator.registerSingleton<ShirtsApiProvider>(ShirtsApiProvider());
  locator.registerSingleton<ShirtLocalDbController>(ShirtLocalDbController());

  locator.registerSingleton<PantsApiProvider>(PantsApiProvider());
  locator.registerSingleton<PantsLocalDbController>(PantsLocalDbController());

  locator.registerSingleton<ScarfApiProvider>(ScarfApiProvider());
  locator.registerSingleton<ScarfLocalDbController>(ScarfLocalDbController());
}
