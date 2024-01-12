import 'package:flutter/material.dart';

import 'package:pipeline/configs/theme/color_pallet.dart';
import 'package:pipeline/configs/theme/text_styles.dart';

class SelectorContainer extends StatelessWidget {
  const SelectorContainer({
    super.key,
    required this.controller,
    required this.title,
    required this.hint,
    this.dropListItem,
  });

  final TextEditingController? controller;
  final List<DropdownMenuItem<String>>? dropListItem;
  final String title;
  final String hint;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 3, top: 8),
          child: Align(
              alignment: Alignment.centerRight,
              child: Text(
                title,
                style: TextStyles.textFieldTitle,
              )),
        ),
        Container(
          padding: const EdgeInsets.only(right: 8),
          margin: const EdgeInsets.only(top: 8),
          width: MediaQuery.of(context).size.width * 0.4283,
          height: 48,
          decoration: BoxDecoration(
              border: Border.all(color: ColorPallet.shadowBox),
              borderRadius: BorderRadius.circular(10),
              color: ColorPallet.background),
          child: Align(
              alignment: Alignment.center,
              child: TextField(
                keyboardType: TextInputType.number,
                style: TextStyles.insideTextFields,
                controller: controller,
                readOnly: true,
                decoration: InputDecoration(
                  hintText: hint,
                  hintStyle: TextStyles.hints,
                  suffixIcon: DropdownButton(
                    hint: null,
                    borderRadius: BorderRadius.circular(10),
                    dropdownColor: ColorPallet.actionContainer,
                    alignment: Alignment.centerLeft,
                    items: dropListItem,
                    onChanged: (String? value) {
                      controller!.text = value.toString();
                    },
                  ),
                  border: InputBorder.none,
                ),
              )),
        ),
      ],
    );
  }
}
