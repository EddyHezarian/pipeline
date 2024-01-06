import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pipeline/configs/components/appbar/section_title.dart';
import 'package:pipeline/configs/components/textfields/long_textfield.dart';
import 'package:pipeline/configs/consts/text_consts.dart';
import 'package:pipeline/configs/extensions/custome_extensetion.dart';
import 'package:pipeline/configs/theme/color_pallet.dart';
import 'package:pipeline/configs/theme/icons_path.dart';
import 'package:pipeline/configs/theme/text_styles.dart';
import 'package:pipeline/features/product_management/repository/product_type_cubit.dart';

Future openInsertProductDialog(
    {required BuildContext context,
    required TextEditingController productType,
    required TextEditingController controller,
    required Function action}) {
  return showDialog(
      context: context,
      builder: (context) {
        return BlocBuilder<ProductTypeCubit, int>(
          builder: (context, state) {
            return AlertDialog(
              alignment: Alignment.center,
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
                height: 200,
                child: Column(
                  children: [
                    LongTextfied(
                        controller: controller,
                        iconPath: IconsPath.deliveredOrder,
                        title: TextConsts.addProducttitle,
                        hint: ""),
                    20.0.sizedBoxheightExtention,
                    productTypeTitle(),
                    selectType(context, state, productType)
                  ]
                ),
              ),
              title: const SectionTitle(title: TextConsts.addProduct),
            );
          },
        );
      });
}
selectType(BuildContext context, int state, TextEditingController controller) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    children: [
      InkWell(
          onTap: () {
            BlocProvider.of<ProductTypeCubit>(context).changeState(0);
            controller.text = "PANTS";
          },
          child: state == 0
              ? selectedTypeItem("شلوار")
              : const Text(
                  "شلوار",
                  style: TextStyles.productType,
                )),
      InkWell(
          onTap: () {
            BlocProvider.of<ProductTypeCubit>(context).changeState(1);
            controller.text = "SCARF";
          },
          child: state == 1
              ? selectedTypeItem("مقنعه")
              : const Text(
                  "مقنعه",
                  style: TextStyles.productType,
                )),
      InkWell(
          onTap: () {
            BlocProvider.of<ProductTypeCubit>(context).changeState(2);
            controller.text = "SHIRT";
          },
          child: state == 2
              ? selectedTypeItem("روپوش")
              : const Text(
                  "روپوش",
                  style: TextStyles.productType,
                )),
    ],
  );
}
 selectedTypeItem(String title) {
  return Column(
    children: [
      Text(
        title,
        style: TextStyles.selectedProductType,
      ),
      const SizedBox(
          width: 30,
          height: 3,
          child: Divider(
            thickness: 2,
            color: ColorPallet.primary,
          ))
    ],
  );
}
productTypeTitle() {
  return const Padding(
    padding: EdgeInsets.only(bottom: 12, right: 20),
    child: Align(
        alignment: Alignment.centerRight,
        child: Text(
          "نوع محصول خود را انتخاب کنید.",
          style: TextStyles.textFieldTitle,
        )),
  );
}


