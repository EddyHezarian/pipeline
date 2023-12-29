import 'package:delayed_widget/delayed_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pipeline/configs/components/loding_animations.dart';
import 'package:pipeline/configs/consts/image_path.dart';
import 'package:pipeline/configs/consts/text_consts.dart';
import 'package:pipeline/configs/extensions/custome_extensetion.dart';
import 'package:pipeline/configs/routings/rountings.dart';
import 'package:pipeline/configs/theme/color_pallet.dart';
import 'package:pipeline/core/supabase/supabase.dart';
import 'package:pipeline/features/introduction/bloc/splash_cubit.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<SplashCubit>(context).eventConnectionChecker();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorPallet.background,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //!logo ------------------------------------
            100.0.sizedBoxheightExtention,
            DelayedWidget(
                animation: DelayedAnimations.SLIDE_FROM_BOTTOM,
                animationDuration: const Duration(milliseconds: 400),
                delayDuration: const Duration(milliseconds: 400),
                child:
                    const Center(child: Image(image: AssetImage(Images.logo)))),
            //!loding bar -------------------------------
            300.0.sizedBoxheightExtention,
            Center(
              child: lodingWidget(),
            ),
            20.0.sizedBoxheightExtention,
            BlocConsumer<SplashCubit, SplashState>(
              listener: (context, state) {
                if (state.connectionStatus is SuccessConnection) {
                  Future.delayed(const Duration(seconds: 3))
                      .then((value) => _navigateToNextPage());
                }
              },
              builder: (context, state) {
                if (state.connectionStatus is FailedConnection) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        TextConsts.noConnection,
                        style: TextStyle(
                            color: ColorPallet.maintext,
                            fontFamily: "dana",
                            fontWeight: FontWeight.w700),
                      ),
                      IconButton(
                          onPressed: () {
                            setState(() {
                              BlocProvider.of<SplashCubit>(context)
                                  .eventConnectionChecker();
                            });
                          },
                          icon: const Icon(
                            Icons.refresh,
                            color: ColorPallet.primary,
                          ))
                    ],
                  );
                } else if (state.connectionStatus is SuccessConnection) {
                  return Container();
                }
                return Container();
              },
            )
          ],
        ));
  }

  void _navigateToNextPage() async{
  
    await Future.delayed(Duration.zero);
    if (!mounted) {
      return;
    }

    final session = supabase.auth.currentSession;
    if (session != null) {
      Navigator.of(context).pushReplacementNamed(Routs.mainWrapper);
    } else {
      Navigator.of(context).pushReplacementNamed(Routs.login);
    }
  }
}
