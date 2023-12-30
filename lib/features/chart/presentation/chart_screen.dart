import 'package:flutter/material.dart';
import 'package:pipeline/configs/theme/color_pallet.dart';

class ChartScreeen extends StatefulWidget {
  const ChartScreeen({super.key});

  @override
  State<ChartScreeen> createState() => _ChartScreeenState();
}

class _ChartScreeenState extends State<ChartScreeen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: ColorPallet.maintext ,
    );
  }
}