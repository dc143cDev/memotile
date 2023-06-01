import 'package:flutter/material.dart';
import 'package:memotile/app/modules/home/controllers/home_controller.dart';

class ColorPickerDot extends StatelessWidget {
  const ColorPickerDot(
    this.text, {
    Key? key,
    // required this.getColor,
    //     required this.valueChange,
    required this.backgroundColor,
  }) : super(key: key);

  // final Function getColor;
  // final Function valueChange;
  final Color backgroundColor;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: 38,
          child: MaterialButton(
            onPressed: () {
              HomeController().getRed();
              HomeController().isColorChanged;
            },
            color: Colors.red,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
            ),
          ),
        ),
        SizedBox(
          height: 5,
        ),
        SizedBox(
          width: 52,
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                  fontWeight: FontWeight.w600, fontSize: 11),
            ),
          ),
        ),
      ],
    );
  }
}
