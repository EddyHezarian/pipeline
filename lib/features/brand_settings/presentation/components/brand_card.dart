import 'package:flutter/material.dart';
import 'package:pipeline/configs/theme/color_pallet.dart';
import 'package:pipeline/configs/theme/text_styles.dart';

class CardForProductAndBrand extends StatelessWidget {
  const CardForProductAndBrand({
    super.key,
    required this.title,
    required this.id,
    required this.isBrand, 
    required this.longPreesAction,
  });

  final String title;
  final int id;
  final bool isBrand;
  final Function longPreesAction;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onLongPress: () {
        longPreesAction();
      },
      child: Container(
        height: 60,
        padding: const EdgeInsets.only(right: 10),
        margin: const EdgeInsets.only(top: 8, right: 40, left: 40),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: ColorPallet.dataContainer,
        ),
        child: Align(
          alignment: Alignment.centerRight,
          child: Text(
            title,
            style: TextStyles.productBrandCard,
          ),
        ),
      ),
    );
  }
}
