
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import 'package:pipeline/configs/extensions/custome_extensetion.dart';
import 'package:pipeline/configs/theme/color_pallet.dart';
import 'package:pipeline/configs/theme/text_styles.dart';
import 'package:pipeline/core/model/order_model.dart';

class OrderCard extends StatelessWidget {
  const OrderCard({super.key, required this.model});
  final OrderModel model;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.only(right: 16, left: 16, top: 14),
      height: MediaQuery.of(context).size.height * 0.269,
      decoration: BoxDecoration(
        color: ColorPallet.dataContainer,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          //!data
          _orderDetails(context),
          //! purchase
          _paymentAndStatusSection()
        ],
      ),
    );
  }

   _paymentAndStatusSection() {
    return Column(
          children: [
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Text(
                      "مبلغ پرداختی:",
                      style: TextStyles.secondaryDataOrderCart,
                    ),
                    Text(
                      model.purchase.toString().toPersianDigit().seRagham(),
                      style: TextStyles.littleDataOrderCart,
                    ),
                    const Text(
                      " تومان",
                      style: TextStyles.toman,
                    ),
                  ],
                ),
                Row(
                  children: [
                    Container(
                      width: 6,
                      height: 6,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: ColorPallet.error),
                    ),
                    const Text(
                      "سفارش جاری",
                      style: TextStyles.openOrderStatuts,
                    ),
                  ],
                )
              ],
            ),
          ],
        );
  }

   _orderDetails(BuildContext context) {
    return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            //*customer details
            _customerInfoInDetailSection(),
            //* cart info
            _cartInfoInDetailSection(context)
          ],
        );
  }

   _cartInfoInDetailSection(BuildContext context) {
    return Column(
            children: [
              //!shirts
              _cartItemContainer(context,model.shirtSize,model.shirtQTY),
              _cartItemContainer(context,model.pantsSize ,model.pantsQTY),
              _cartItemContainer(context, model.scarfSize , model.scarfQTY),
 
            ],
          );
  }

   _cartItemContainer(BuildContext context , String title , int qty) {
    return Container(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              margin: const EdgeInsets.only(top: 4),
              width: MediaQuery.of(context).size.width * 0.4,
              height: 25,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: ColorPallet.background),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Text(
                        "روپوش",
                        style: TextStyles.cartDetailsParameter,
                      ),
                      4.0.sizedBoxWidthExtension,
                      Text(
                      title,
                        style: TextStyles.cartDetailsvalue,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const Text(
                        "|",
                        style: TextStyle(
                            color: ColorPallet.subtext,
                            fontSize: 14,
                            fontWeight: FontWeight.bold),
                      ),
                      const Text("تعداد:",
                          style: TextStyles.cartDetailsParameter2),
                      Text(
                        qty.toString().toPersianDigit(),
                        style: TextStyles.cartDetailsvalue,
                      ),
                    ],
                  )
                ],
              ),
            );
  }

  Column _customerInfoInDetailSection() {
    return Column(
            children: [
              //?name
              SizedBox(
                  height: 100,
                  width: 150,
                  child: Center(
                      child: Text(
                    model.customerName,
                    style: TextStyles.nameOrderCard,
                    textAlign: TextAlign.center,
                  ))),
              //? date
              Row(
                children: [
                  const Text(
                    "تاریخ:",
                    style: TextStyles.secondaryDataOrderCart,
                  ),
                  8.0.sizedBoxWidthExtension,
                  Text(
                    DateFormat(
                      'yyyy-MM-DD',
                    ).format(model.createdAt).toString().toPersianDate(),
                    style: TextStyles.littleDataOrderCart,
                  )
                  //Text(datefor)
                ],
              ),
              //? description
              Column(
                children: [
                  const Text(
                    "توضیحات:",
                    style: TextStyles.secondaryDataOrderCart,
                  ),
                  10.0.sizedBoxWidthExtension,
                  SizedBox(
                    width: 180,
                    child: Text(
                      model.description,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          color: ColorPallet.subtext,
                          fontFamily: "dana",
                          fontWeight: FontWeight.w700,
                          fontSize: 13),
                    ),
                  ),
                ],
              ),
            ],
          );
  }
}
