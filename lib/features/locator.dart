import 'package:get_it/get_it.dart';
import 'package:pipeline/features/brand_settings/data/brand_api_provider.dart';

var locator = GetIt.instance;

Future<void> initLocator() async {
  
  locator.registerSingleton<BrandsApiProvider>(BrandsApiProvider());
}
