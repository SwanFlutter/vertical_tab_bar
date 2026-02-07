import 'package:flutter/material.dart';

/// A logout button widget
class LogoutButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String text;
  final Color? textColor;
  final Color? iconColor;
  final Color? backgroundColor;
  final Color? hoverColor;

  const LogoutButton({
    super.key,
    this.onPressed,
    this.text = 'خروج از سیستم',
    this.textColor,
    this.iconColor,
    this.backgroundColor,
    this.hoverColor,
  });

  @override
  Widget build(BuildContext context) {
    final defaultColor = Colors.red[500] ?? Colors.red;
    final defaultBgColor = Colors.red[50] ?? Colors.red.withValues(alpha: 0.1);
    final defaultHoverColor =
        Colors.red[100] ?? Colors.red.withValues(alpha: 0.2);

    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(8),
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(8),
        hoverColor: hoverColor ?? defaultHoverColor,
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          decoration: BoxDecoration(
            color: backgroundColor ?? defaultBgColor,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.logout,
                color: iconColor ?? defaultColor,
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(
                text,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: textColor ?? defaultColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
