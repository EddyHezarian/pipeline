import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:pipeline/configs/theme/color_pallet.dart';
import 'package:pipeline/configs/theme/text_styles.dart';

class MainButton extends StatefulWidget {
  const MainButton({super.key, required this.action, required this.title});
  final Function action;
  final String title;

  @override
  State<MainButton> createState() => _MainButtonState();
}

class _MainButtonState extends State<MainButton> {
  @override
  Widget build(BuildContext context) {
    bool isloading = false;
    return InkWell(
      onTap: () {
        setState(() {
          isloading = true;
        });
        widget.action();
        setState(() {
          isloading = false;
        });
      },
      child: Container(
        //width: 100,
        height: 48,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: ColorPallet.primary,
        ),
        child: Center(
            child: isloading==true ? 
            LoadingAnimationWidget.staggeredDotsWave(color: ColorPallet.lightText, size: 30):
            Text(
          widget.title,
          style: TextStyles.mainButtons,
        )
            ),
      ),
    );
  }
}
