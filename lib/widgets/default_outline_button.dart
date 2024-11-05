import 'package:flutter/material.dart';

// ignore: must_be_immutable
class DefaultOutlineButton extends StatelessWidget {
  final String? text;
  final Widget? child;
  final Color color, backgroundColor;
  final Color? textColor;
  VoidCallback? onPressed, onLongPress;
  final bool setDefaultOnPressed;
  final double borderRadius;
  final double width, height;
  final double fontSize;

  DefaultOutlineButton({
    Key? key,
    this.text,
    this.color = Colors.blue,
    this.backgroundColor = Colors.transparent,
    this.onPressed,
    this.onLongPress,
    this.setDefaultOnPressed = true,
    this.borderRadius = 4,
    this.child,
    this.width = 85,
    this.height = 25,
    this.fontSize = 14,
    this.textColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (setDefaultOnPressed) {
      onPressed ??= () => Navigator.pop(context);
    }
    return SizedBox(
      width: width,
      height: height,
      child: GestureDetector(
        onSecondaryTap: onLongPress,
        child: OutlinedButton(
          onPressed: onPressed,
          onLongPress: onLongPress,
          style: OutlinedButton.styleFrom(
            backgroundColor: backgroundColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius),
              side: BorderSide(color: color),
            ),
            side: BorderSide(
              color: onPressed != null ? color : Colors.grey,
              style: BorderStyle.solid,
              width: 1.0,
            ),
          ),
          child: child ??
              Text(
                text ?? "",
                maxLines: 1,
                style: TextStyle(color: textColor ?? color, fontSize: fontSize),
              ),
        ),
      ),
    );
  }
}
