import 'package:flutter/material.dart';
import 'package:revisor/res/AppColors.dart';
import 'package:revisor/res/Fonts.dart';

class RevOutlineButton extends StatelessWidget {
  final Function onTap;
  final String text;
  final EdgeInsets padding;
  final EdgeInsets margin;
  final TextStyle textStyle;
  final Colors color;
  final double height;

  const RevOutlineButton({
    this.onTap,
    this.text,
    this.padding,
    this.margin,
    this.textStyle,
    this.color,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: height ?? 54.0,
        padding: padding,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          border: Border.all(color: AppColors.colorPrimary, width: 1.5),
        ),
        child: Center(
          child: Text(
            '$text',
            style: textStyle ?? textStyleRedRegular12px,
          ),
        ),
      ),
    );
  }
}
