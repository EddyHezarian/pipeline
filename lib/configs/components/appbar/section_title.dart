
import 'package:flutter/material.dart';
import 'package:pipeline/configs/theme/text_styles.dart';

class SectionTitle extends StatelessWidget {
  const SectionTitle({
    
    super.key, required this.title,
  });
  final String title; 

  @override
  Widget build(BuildContext context) {
    return  Align(
        alignment: Alignment.centerRight,
        child: Text(
          title,
          style: TextStyles.heading,
        ));
  }
}