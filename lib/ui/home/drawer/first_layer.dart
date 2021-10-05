import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:revisor/res/AppColors.dart';

class FirstLayer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.colorSecondaryDark,
      body: SafeArea(
        child: Container(),
      ),
    );
  }
}
