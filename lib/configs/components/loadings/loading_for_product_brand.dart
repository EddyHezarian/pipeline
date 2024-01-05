
import 'package:flutter/material.dart';
import 'package:pipeline/configs/theme/color_pallet.dart';
import 'package:shimmer/shimmer.dart';

class LoadingForProductAndBrandCard extends StatelessWidget {
  const LoadingForProductAndBrandCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 8,
      itemBuilder: (context, index) {
      return Center(
          child: Shimmer.fromColors(
        baseColor: const Color.fromARGB(255, 223, 223, 223),
        highlightColor:
            const Color.fromARGB(255, 200, 199, 199),
        child: Container(
          margin: const EdgeInsets.only(top: 8,left:40,right: 40),
          height: 60,
          decoration: BoxDecoration(
            color: ColorPallet.actionContainer,
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ));
    });
  }
}
