
import 'package:flutter/material.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import 'package:pipeline/configs/theme/color_pallet.dart';
import 'package:pipeline/configs/theme/text_styles.dart';

class QuantityContainer extends StatelessWidget {
  const QuantityContainer(
      {super.key,
      required this.increase,
      required this.decrease,
      required this.controller,
      required this.title});
  final Function increase;
  final Function decrease;
  final int controller;
  final String title;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 3, top: 12),
          child: Align(
              alignment: Alignment.centerRight,
              child: Text(
                title,
                style: TextStyles.textFieldTitle,
              )),
        ),
        Container(
          padding: const EdgeInsets.only(bottom: 0),
          width: MediaQuery.of(context).size.width * 0.3,
          height: 30,
          decoration: BoxDecoration(
            color: ColorPallet.background,
            borderRadius: BorderRadius.circular(4),
            border: Border.all(
              color: ColorPallet.error,
            ),
          ),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                InkWell(
                  onTap: () {
                    increase();
                  },
                  child: const SizedBox(
                      width: 48,
                      height: 30,
                      child: Center(
                          child: Icon(
                        Icons.add,
                        color: ColorPallet.error,
                        size: 24,
                      ))),
                ),
                Text(
                  controller.toString().toPersianDigit(),
                  style: TextStyles.quantity,
                ),
                InkWell(
                  onTap: () {
                    decrease();
                  },
                  child: const SizedBox(
                      width: 48,
                      height: 30,
                      child: Center(
                          child: Icon(
                        Icons.remove,
                        color: ColorPallet.error,
                        size: 24,
                      ))),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
