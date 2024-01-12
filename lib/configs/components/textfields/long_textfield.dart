import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pipeline/configs/theme/color_pallet.dart';
import 'package:pipeline/configs/theme/text_styles.dart';

class LongTextfied extends StatelessWidget {
  const LongTextfied(
      {super.key, required this.controller, 
       this.isPassword=false,
      required this.iconPath,
      required this.title,
      required this.hint,
      });

  final TextEditingController? controller;
  final bool isPassword;
  final String iconPath;
  final String title;
  final String hint;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
         Padding(
          padding: const EdgeInsets.only(right: 12, top: 8),
          child: Align(
              alignment: Alignment.centerRight,
              child: Text(
               title,
                style: TextStyles.textFieldTitle,
              )),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          margin: const EdgeInsets.all(8),
          width: MediaQuery.of(context).size.width * 0.8,
          height: 48,
          decoration: BoxDecoration(
              border: Border.all(color: ColorPallet.shadowBox),
              borderRadius: BorderRadius.circular(10),
              color: ColorPallet.background),
          child: Align(
              alignment: Alignment.center,
              child: TextField(

                obscureText: isPassword,
                style: const TextStyle(
                    fontFamily: "dana",
                    fontSize: 18,
                    fontWeight: FontWeight.w200,
                    color: ColorPallet.maintext),
                controller:controller,
                decoration: InputDecoration(
                  prefixIcon: SvgPicture.asset(
                    iconPath,
                    fit: BoxFit.scaleDown,
                  ),
                  border: InputBorder.none,
                ),
              )),
        ),
      ],
    );
  }
}
