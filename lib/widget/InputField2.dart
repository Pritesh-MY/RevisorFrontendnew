import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:revisor/res/AppColors.dart';
import 'package:revisor/res/Fonts.dart';
import 'package:revisor/res/Strings.dart';
import 'package:revisor/utils/Utility.dart';

/// Created by Pratik Kataria on 24-02-2021.

class InputField2 extends StatefulWidget {
  final String leftIcon;
  String rightIcon;
  final Function(String val) onTextChange;
  final String errorMessage;
  final String placeHolderText;
  final double radius;
  final InputType inputType;
  final int wordLimit;
  bool isPassword;
  TextCapitalization textCapitalization;

  InputField2(
      {Key key,
      this.leftIcon,
      this.rightIcon,
      this.onTextChange,
      this.placeHolderText,
      this.errorMessage,
      this.radius,
      this.wordLimit,
      this.isPassword,
      this.inputType,
      this.textCapitalization})
      : super(key: key);

  @override
  InputField2State createState() => InputField2State();
}

class InputField2State extends State<InputField2> {
  bool hasError = false;
  bool hasFocused = false;
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FocusScope(
          child: Focus(
            onFocusChange: (focus) => setState(() => hasFocused = focus),
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.colorPrimaryLight,
                borderRadius: BorderRadius.circular(widget.radius ?? 20.0),
                border: Border.all(
                  width: 1.0,
                  color: getBorderColor(),
                ),
              ),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                width: Utility.screenWidth(context),
                height: 52.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(widget.radius),
                ),
                child: Row(
                  children: [
                    if (widget.leftIcon != null)
                      Image.asset(
                        widget.leftIcon,
                        width: 24,
                        height: 24,
                        color: hasError ? AppColors.red : AppColors.colorSecondary,
                      ),
                    if (widget.leftIcon != null) horizontalSpace(12.0),
                    Expanded(
                        child: Text('${widget.placeHolderText}', style: textStyleDarkRegular16px400w,)),
                    if (widget.rightIcon != null)
                      InkWell(
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: checkPasswordObscure,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 12.0),
                          child: Image.asset(
                            widget.rightIcon,
                            width: 24,
                            height: 52,
                            color: hasError ? AppColors.red : AppColors.colorSecondary,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        ),
        if (hasError) verticalSpace(6.0),
        if (hasError)
          Row(
            children: [
              horizontalSpace(12.0),
              Text(
                '${widget.errorMessage ?? kFieldEmptyError}',
                style: textStyleErrorRedRegular12px,
              ),
            ],
          ),
      ],
    );
  }

  Color getBorderColor() {
    return hasError
        ? Colors.red
        : hasFocused
            ? AppColors.colorPrimary
            : Colors.transparent;
  }

  void showError({bool reset}) {
    setState(() {
      hasError = reset ?? true;
    });
  }

  void resetFocus() {
    setState(() => hasFocused = false);
  }

  void resetErrorOnTyping() {
    if (hasError) {
      setState(() {
        hasError = !hasError;
      });
    }
  }

  void checkPasswordObscure() {
    /*  if (widget.placeHolderText.toLowerCase().contains('password')) {
      setState(() {
        widget.isPassword = !widget.isPassword;
        widget.rightIcon = widget.isPassword ? Images.kPasswordEyeEnabled : Images.kPasswordEyeIcon;
      });
    }*/
  }

  TextInputType getInputType() {
    switch (widget.inputType) {
      case InputType.PIN_CODE:
      case InputType.MOBILE:
        return TextInputType.number;
        break;
      case InputType.EMAIL:
        return TextInputType.emailAddress;
        break;
      case InputType.PASSWORD:
        return TextInputType.visiblePassword;
        break;
      default:
        return TextInputType.text;
        break;
    }
  }

/*  void resetText() {
    setState(() => {_controller.clear(), _currentFocus?.unfocus()});
  }*/

  List<TextInputFormatter> getInputFormatter() {
    switch (widget.inputType) {
      case InputType.MOBILE:
        return [LengthLimitingTextInputFormatter(10), FilteringTextInputFormatter.digitsOnly];
        break;
      case InputType.PIN_CODE:
        return [LengthLimitingTextInputFormatter(6), FilteringTextInputFormatter.digitsOnly];
        break;
      case InputType.EMAIL:
      case InputType.PASSWORD:
      default:
        return [LengthLimitingTextInputFormatter(250)];
        break;
    }
  }
}

enum InputType {
  MOBILE,
  EMAIL,
  PASSWORD,
  PIN_CODE,
}
