import 'package:flutter/material.dart';

class CustomSnackbar extends SnackBar {
  CustomSnackbar({
    Key? key,
    required String message,
    String btnLabel = 'OK',
    VoidCallback? onPressed,
    Duration duration = const Duration(seconds: 2),
  }) : super(
          key: key,
          content: Text(message),
          duration: duration,
          action: SnackBarAction(
            label: btnLabel,
            onPressed: onPressed ?? () {},
          ),
        );
}
