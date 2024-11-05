import 'package:flutter/material.dart';

enum SnackBarType { success, error, warning, info }

extension SnackBarTypeEx on SnackBarType {
  IconData get icon {
    switch (this) {
      case SnackBarType.success:
        return Icons.verified;
      case SnackBarType.error:
        return Icons.error;
      case SnackBarType.warning:
        return Icons.warning;
      case SnackBarType.info:
        return Icons.info;
    }
  }

  Color get iconColor {
    return Colors.white;
  }

  Color get snackbarColor {
    switch (this) {
      case SnackBarType.success:
        return Colors.lightGreen;
      case SnackBarType.error:
        return Colors.redAccent;
      case SnackBarType.warning:
        return Colors.yellowAccent;
      case SnackBarType.info:
        return Colors.lightBlue;
    }
  }
}

void showInSnackBar({
  required BuildContext context,
  required SnackBarType type,
  required String text,
  Color? color,
  double fontSize = 18,
  Duration? duration,
}) {
  color ??= type.snackbarColor;

  ScaffoldMessenger.of(context).hideCurrentSnackBar();
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4.0),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      padding: const EdgeInsets.symmetric(horizontal: 24),
      backgroundColor: color,
      behavior: SnackBarBehavior.floating,
      showCloseIcon: true,
      closeIconColor: type.iconColor,
      duration: duration ?? const Duration(seconds: 4),
      content: Row(
        children: [
          Icon(
            type.icon,
            color: type.iconColor,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              maxLines: 1,
              textAlign: TextAlign.start,
              style: TextStyle(fontSize: fontSize, color: type.iconColor),
            ),
          ),
        ],
      ),
    ),
  );
}
