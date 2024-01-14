
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pipeline/configs/theme/color_pallet.dart';
import 'package:pipeline/configs/theme/icons_path.dart';
import 'package:pipeline/configs/theme/text_styles.dart';

class BrandSelectorContainer extends StatelessWidget {
  const BrandSelectorContainer(
      {super.key,
      required this.action,
      required this.activator,
      required this.menuItems,
      required this.controller,
      required this.isAutoFocused});
  final Function action;
  final Function activator;
  final List<DropdownMenuItem> menuItems;
  final String controller;
  final bool isAutoFocused;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: InkWell(
        onTap: () => activator(),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          margin: const EdgeInsets.only(right: 20, top: 20),
          //width: MediaQuery.of(context).size.width * 0.43,
          height: 48,
          
          decoration: BoxDecoration(
              color: ColorPallet.dataContainer,
              borderRadius: BorderRadius.circular(10)),
          child: DropdownButton(
            
            icon: SvgPicture.asset(IconsPath.config),
            hint: Text(
              controller,
              maxLines: 1,
              style: TextStyles.textFieldTitle,
            ),
            borderRadius: BorderRadius.circular(10),
            autofocus: isAutoFocused,
            items: menuItems,
            onChanged: (value) {
              action(value);
            },
          ),
        ),
      ),
    );
  }
}
