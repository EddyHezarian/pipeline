import 'package:flutter/material.dart';
import 'package:pipeline/configs/components/appbar/app_bar.dart';
import 'package:pipeline/configs/components/drawer/custome_drawer.dart';
import 'package:pipeline/configs/theme/color_pallet.dart';

class OpenOrderScreen extends StatefulWidget {
  const OpenOrderScreen({super.key});

  @override
  State<OpenOrderScreen> createState() => _OpenOrderScreenState();
}

class _OpenOrderScreenState extends State<OpenOrderScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      drawer: const CustomeDrawer(),
      backgroundColor: ColorPallet.background,
      appBar: customeMainAppBar(),
    ));
  }
}
