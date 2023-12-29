import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pipeline/configs/consts/database_consts.dart';
import 'package:pipeline/configs/routings/rountings.dart';
import 'package:pipeline/configs/theme/color_pallet.dart';
import 'package:pipeline/features/introduction/bloc/splash_cubit.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  //? widget bindings
  WidgetsFlutterBinding.ensureInitialized();
  //? initializing supa
  await Supabase.initialize(
    authFlowType: AuthFlowType.pkce,
      url: AppConsts.supaBaseURL, anonKey: AppConsts.anonKey);

  //? define system chrome for whole app
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  //?
  runApp(MultiBlocProvider(providers: [
    BlocProvider(
      create: (context) => SplashCubit(),
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
      title: 'MyStore',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: ColorPallet.primary),
        useMaterial3: false,
      ),
     
    );
  }
}
