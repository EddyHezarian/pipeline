import 'package:get_it/get_it.dart';
import 'package:pipeline/features/brand_management/data/brand_api_provider.dart';
import 'package:pipeline/features/product_management/data/pants_api_provider.dart';
import 'package:pipeline/features/product_management/data/scarf_api_provider.dart';
import 'package:pipeline/features/product_management/data/shirts_api_provider.dart';

var locator = GetIt.instance;

Future<void> initLocator() async {
  
  locator.registerSingleton<BrandsApiProvider>(BrandsApiProvider());

  locator.registerSingleton<ShirtsApiProvider>(ShirtsApiProvider());

  locator.registerSingleton<PantsApiProvider>(PantsApiProvider());

  locator.registerSingleton<ScarfApiProvider>(ScarfApiProvider());
}
