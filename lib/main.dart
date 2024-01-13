import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pipeline/configs/consts/database_consts.dart';
import 'package:pipeline/configs/routings/rountings.dart';
import 'package:pipeline/configs/theme/color_pallet.dart';
import 'package:pipeline/features/brand_management/data/model/brand_model.dart';
import 'package:pipeline/features/introduction/bloc/splash_cubit.dart';
import 'package:pipeline/features/order_managment/repository/blocs/cubit/order_cubit.dart';
import 'package:pipeline/locator.dart';
import 'package:pipeline/features/product_management/data/models/pants_model.dart';
import 'package:pipeline/features/product_management/data/models/scarf_model.dart';
import 'package:pipeline/features/product_management/data/models/shirt_model.dart';
import 'package:pipeline/features/product_management/repository/product_type_cubit.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  //? widget bindings
  WidgetsFlutterBinding.ensureInitialized();
  //? initializing supa
  await Supabase.initialize(
      url: AppConsts.supaBaseURL,
      anonKey: AppConsts.anonKey,
      authFlowType: AuthFlowType.pkce);

  //? define system chrome for whole app
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  //? locator make instanse of api providers as singleton pattern .
  await initLocator();
  //? initialzing hive local data base for products and brands : see the docs for more details
  await Hive.initFlutter();
  //? initializ  model adaptor for hive
  Hive.registerAdapter(BrandModelAdapter());
  Hive.registerAdapter(PantsModelAdapter());
  Hive.registerAdapter(ShirtModelAdapter());
  Hive.registerAdapter(ScarfModelAdapter());
  //? run app
  runApp(MultiBlocProvider(providers: [
    BlocProvider(
      create: (context) => SplashCubit(),
    ), 
    BlocProvider(
      create: (context) => OrderCubit(locator()),
    ),
    BlocProvider(
      create: (context) => ProductTypeCubit(),
    ),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('fa'), // farsi
        ],
        initialRoute: '/',
        routes: routs,
        title: 'Pipeline',
        //onGenerateRoute: RouteGenerator.generateRoute,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: ColorPallet.primary),
          useMaterial3: true,
        ));
  }
}
