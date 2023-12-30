import 'package:delayed_widget/delayed_widget.dart';
import 'package:flutter/material.dart';
import 'package:pipeline/configs/components/buttons/main_button.dart';
import 'package:pipeline/configs/components/long_textfield.dart';
import 'package:pipeline/configs/components/snack_bars.dart';
import 'package:pipeline/configs/consts/image_path.dart';
import 'package:pipeline/configs/consts/text_consts.dart';
import 'package:pipeline/configs/extensions/custome_extensetion.dart';
import 'package:pipeline/configs/extensions/email_validation.dart';
import 'package:pipeline/configs/routings/rountings.dart';
import 'package:pipeline/configs/theme/color_pallet.dart';
import 'package:pipeline/configs/theme/icons_path.dart';
import 'package:pipeline/configs/theme/text_styles.dart';
import 'package:pipeline/features/authentication/data/auth_provider.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({super.key});

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //! logo and welcoming----------------------------------------------
            60.0.sizedBoxheightExtention,
            DelayedWidget(
                animationDuration: const Duration(milliseconds: 400),
                delayDuration: const Duration(milliseconds: 400),
                animation: DelayedAnimations.SLIDE_FROM_BOTTOM,
                child: const Image(image: AssetImage(Images.logo))),
            10.0.sizedBoxheightExtention,
            DelayedWidget(
              animationDuration: const Duration(milliseconds: 200),
              delayDuration: const Duration(milliseconds: 800),
              animation: DelayedAnimations.SLIDE_FROM_RIGHT,
              child: const Text(
                TextConsts.loginWelcoming,
                style: TextStyles.appbarHeading,
              ),
            ),
            //!text fields------------------------------------------------------
            Expanded(
                child: DelayedWidget(
              animationDuration: const Duration(milliseconds: 400),
              delayDuration: const Duration(milliseconds: 1100),
              animation: DelayedAnimations.SLIDE_FROM_BOTTOM,
              child: Center(
                child: Stack(
                  children: [
                    _loginBackGroungContainer(),
                    //! username------------------------------------------
                    Positioned(
                        left: 0,
                        right: 0,
                        child: LongTextfied(
                            title: TextConsts.enterEmail,
                            isPassword: false,
                            hint: "",
                            iconPath: IconsPath.person,
                            controller: emailController)),
                    //! pasword------------------------------------------
                    Positioned(
                        top: 85,
                        left: 0,
                        right: 0,
                        child: LongTextfied(
                            title: TextConsts.enterPassword,
                            isPassword: true,
                            hint: "",
                            iconPath: IconsPath.lock,
                            controller: passController)),
                    //! APPLY BOTTON------------------------------------------
                    Positioned(
                        bottom: 20,
                        left: 90,
                        right: 90,
                        child: MainButton(
                          action: () async {
                            /* parameter will check then navigate to main wrapper */
                             
                            List<String> parameters = [
                              emailController.text,
                              passController.text
                            ];
                            if (await _validateAuthenticationParams(parameters)) {
                              if (mounted) {
                                showSuccessSnackBar(context);
                                Navigator.pushReplacementNamed(context, Routs.mainWrapper);
                              }
                            } else {
                              if (mounted) {
                                showFailedSnackBar(context);
                              }
                            }
                          },
                          title: TextConsts.signInButton,
                        )),
                  ],
                ),
              ),
            )),
          ],
        ),
      ),
    );
  }

  Widget _loginBackGroungContainer() {
    return Container(
      width: MediaQuery.of(context).size.width * 0.78,
      height: MediaQuery.of(context).size.height * 0.39,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: ColorPallet.actionContainer,
          boxShadow: const [
            BoxShadow(
              spreadRadius: 0,
              color: ColorPallet.shadowBox,
              blurRadius: 4,
              offset: Offset(0, 4),
              blurStyle: BlurStyle.normal,
            )
          ]),
    );
  }

  Future<bool> _validateAuthenticationParams(List<String> parameters) async {
    if (parameters[0].isValidEmail()) {
      bool autResponse = await signInWithPasswordAndEmail(
          email: parameters[0], password: parameters[1], context: context);
      return autResponse;
    } else {
      return false;
    }
  }
}
