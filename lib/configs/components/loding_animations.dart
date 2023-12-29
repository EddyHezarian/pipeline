import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:pipeline/configs/theme/color_pallet.dart';

Widget lodingWidget ()=> LoadingAnimationWidget.staggeredDotsWave(
    color: ColorPallet.primary, size: 40);
