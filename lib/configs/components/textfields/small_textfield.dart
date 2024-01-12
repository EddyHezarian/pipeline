import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pipeline/configs/theme/color_pallet.dart';
import 'package:pipeline/configs/theme/text_styles.dart';

class SmallTextField extends StatelessWidget {
  const SmallTextField({
    super.key,
    required this.controller,
    this.isPassword = false,
    required this.iconPath,
    required this.title,
    required this.hint,
    required this.readOnly,
    this.action,
    this.dropListItem,
  });

  final TextEditingController? controller;
  final bool isPassword;
  final String iconPath;
  final List<DropdownMenuItem<String>>? dropListItem;
  final String title;
  final String hint;
  final bool readOnly;
  final Function? action;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 3, top: 8),
          child: Align(
              alignment: Alignment.centerRight,
              child: Text(
                title,
                style: TextStyles.textFieldTitle,
              )),
        ),
        Container(
          margin: const EdgeInsets.only(top: 8),
          width: MediaQuery.of(context).size.width * 0.4283,
          height: 48,
          decoration: BoxDecoration(
              border: Border.all(color: ColorPallet.shadowBox),
              borderRadius: BorderRadius.circular(10),
              color: ColorPallet.background),
          child: Align(
              alignment: Alignment.center,
              child: TextField(
                keyboardType: TextInputType.number,
                obscureText: isPassword,
                style: TextStyles.insideTextFields,
                controller: controller,
                readOnly: readOnly,
                decoration: InputDecoration(
                  hintText: hint,
                  hintStyle: TextStyles.hints,
                
                  suffixIcon: readOnly
                      ? DropdownButton(
                          hint: null,
                          borderRadius: BorderRadius.circular(10),
                          dropdownColor: ColorPallet.actionContainer,
                          alignment: Alignment.centerLeft,
                          items: dropListItem,
                          onChanged: (String? value) {
                            controller!.text = value.toString();
                          },
                        )
                      : null,
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
