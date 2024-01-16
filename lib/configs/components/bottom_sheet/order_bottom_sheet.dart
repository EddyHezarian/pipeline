import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import 'package:pipeline/configs/extensions/custome_extensetion.dart';
import 'package:pipeline/configs/theme/color_pallet.dart';
import 'package:pipeline/configs/theme/icons_path.dart';
import 'package:pipeline/core/model/order_model.dart';
import 'package:pipeline/features/order_managment/repository/blocs/cubit/order_cubit.dart';

bottomSheet({required BuildContext context,required OrderModel model}) {
  return showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
            padding: const EdgeInsets.only(right: 16, left: 16),
            height: 350,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  bottomSheetDataSection(model: model, action: (){}),
                  //! buttoms
                  Column(
                    children: [
                      bottomSheetButton(
                          context: context,
                          isCancel: false,
                          action: () {
                            //! update to
                            //todo smsSender(model);
                            model.status == "OPEN"
                                ? BlocProvider.of<OrderCubit>(context)
                                    .markAsReady(model: model)
                                : BlocProvider.of<OrderCubit>(context)
                                    .markAsDelivered(model: model);
                          },
                          status: model.status),
                      bottomSheetButton(
                        context: context,
                        isCancel: true,
                        action: () {},
                      ),
                    ],
                  )
                ],
              ),
            ));
      });
}

bottomSheetButton(
    {required BuildContext context,
    required bool isCancel,
    String? status,
    required Function action}) {
  return InkWell(
    onTap: () {
      action();
      Navigator.pop(context);
    },
    child: Container(
      margin: const EdgeInsets.only(right: 30, left: 30, bottom: 4),
      height: 48,
      decoration: BoxDecoration(
          color: isCancel
              ? ColorPallet.actionContainer
              : status == "OPEN"
                  ? ColorPallet.hover
                  : ColorPallet.actionContainer,
          border: Border.all(
            color: isCancel
                ? ColorPallet.shadowBox
                : status == "OPEN"
                    ? ColorPallet.primary
                    : ColorPallet.deliveredBlue,
          ),
          borderRadius: BorderRadius.circular(10)),
      child: Center(
          child: Text(
        isCancel
            ? "بیخیال"
            : status == "OPEN"
                ? "سفارش آماده شد"
                : "تحویل سفارش",
        style: isCancel
            ? const TextStyle(
                fontFamily: "dana",
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: ColorPallet.shadowBox)
            : status == "OPEN"
                ? const TextStyle(
                    fontFamily: "dana",
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: ColorPallet.primary)
                : const TextStyle(
                    fontFamily: "dana",
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: ColorPallet.deliveredBlue),
      )),
    ),
  );
}

Column bottomSheetDataSection({required OrderModel model , required Function action}) {
  return Column(
    children: [
      //! badge
      Container(
        margin: const EdgeInsets.only(top: 8),
        width: 55,
        height: 4,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color: ColorPallet.shadowBox),
      ),
      //! code and action
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 15, right: 13, bottom: 20),
            child: Row(
              children: [
                const Text(
                  "کد تحویل : ",
                  style: TextStyle(
                    fontFamily: "dana",
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  model.id!.toString().toPersianDigit(),
                  style: const TextStyle(
                    fontFamily: "dana",
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
          InkWell(
            onTap: () {
              // ! delete order
              action();
            },
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Icon(
                    CupertinoIcons.delete,
                    color: ColorPallet.error,
                  ),
                  Text(
                    "حذف سفارش",
                    style: TextStyle(
                        fontFamily: "dana",
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: ColorPallet.error),
                  )
                ],
              ),
            ),
          )
        ],
      )
      //! details
      ,
      Row(
        children: [
          //! name
          SvgPicture.asset(IconsPath.person),
          4.0.sizedBoxWidthExtension,
          const Text(
            "نام",
            style: TextStyle(
              fontFamily: "dana",
              fontSize: 15,
              fontWeight: FontWeight.w700,
            ),
          ),
          8.0.sizedBoxWidthExtension,
          Text(
            model.customerName,
            style: const TextStyle(
              fontFamily: "dana",
              fontSize: 14,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
      8.0.sizedBoxheightExtention,
      Row(
        children: [
          //! name
          SvgPicture.asset(IconsPath.phone),
          4.0.sizedBoxWidthExtension,
          const Text(
            "تلفن",
            style: TextStyle(
              fontFamily: "dana",
              fontSize: 15,
              fontWeight: FontWeight.w700,
            ),
          ),
          8.0.sizedBoxWidthExtension,
          Text(
            model.customerPhone,
            style: const TextStyle(
              fontFamily: "dana",
              fontSize: 14,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
      8.0.sizedBoxheightExtention,
      Row(
        children: [
          //! name
          SvgPicture.asset(IconsPath.brand),
          4.0.sizedBoxWidthExtension,
          const Text(
            "برند",
            style: TextStyle(
              fontFamily: "dana",
              fontSize: 14,
              fontWeight: FontWeight.w700,
            ),
          ),
          8.0.sizedBoxWidthExtension,
          Text(
            model.brandName,
            style: const TextStyle(
              fontFamily: "dana",
              fontSize: 14,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
      8.0.sizedBoxheightExtention,
      const Align(
          alignment: Alignment.centerRight,
          child: Text(
            "توضیحات:",
            style: TextStyle(
              fontFamily: "dana",
              fontSize: 14,
              fontWeight: FontWeight.w700,
            ),
          )),
      Align(
          alignment: Alignment.centerRight,
          child: Text(
            model.description,
            style: const TextStyle(
              fontFamily: "dana",
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          )),
    ],
  );
}
