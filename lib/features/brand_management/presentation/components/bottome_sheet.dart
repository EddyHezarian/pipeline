import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pipeline/configs/components/appbar/section_title.dart';
import 'package:pipeline/configs/components/textfields/long_textfield.dart';
import 'package:pipeline/configs/consts/text_consts.dart';
import 'package:pipeline/configs/extensions/custome_extensetion.dart';
import 'package:pipeline/configs/theme/color_pallet.dart';
import 'package:pipeline/configs/theme/icons_path.dart';
import 'package:pipeline/configs/theme/text_styles.dart';

Future openInsertBrandDialog(
    {required BuildContext context,
    required TextEditingController controller,
    required Function action}) {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          alignment: Alignment.center,

          //icon: const Icon(CupertinoIcons.add),
          actions: [
            TextButton(
                onPressed: () {
                  action();
                  Navigator.pop(context);
                },
                child: const Text(
                  "افزودن",
                  style: TextStyles.actionTextButton,
                ))
          ],
          content: SizedBox(
            height: 100,
            child: LongTextfied(
                controller: controller,
                iconPath: IconsPath.brand,
                title: TextConsts.addBrandName,
                hint: ""),
          ),
          title: const SectionTitle(title: TextConsts.addBrand),
        );
      });
}

Future openDeleteBrandDialog(
    {required BuildContext context,
    required TextEditingController controller,
    required Function action}) {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          icon: const Icon(
            CupertinoIcons.exclamationmark_shield_fill,
            color: ColorPallet.error,
          ),
          backgroundColor: ColorPallet.errorHover,
          alignment: Alignment.center,

          //icon: const Icon(CupertinoIcons.add),
          actions: [
            Row(
              children: [
                InkWell(
                  onTap: () {
                    action();
                    Navigator.pop(context);
                  },
                  child: const Text(
                    "حذف",
                    style: TextStyles.redWarning,
                  )
                ),
                14.0.sizedBoxWidthExtension,
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    "بیخیال",
                    style: TextStyles.forgetit,
                  )
                ),
              ],
            )
          ],
          content: const SizedBox(
              height: 60,
              child: Text(
                TextConsts.deleteBrandWarning,
                style: TextStyles.textFieldTitle,
              )),
          title: const SectionTitle(title: TextConsts.deleteBrand),
        );
      });
}
