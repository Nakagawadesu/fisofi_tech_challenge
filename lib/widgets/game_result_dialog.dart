import 'package:flutter/material.dart';

class GameResultDialog extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color iconColor;
  final Widget content;
  final List<Widget> actions;

  const GameResultDialog({
    super.key,
    required this.title,
    required this.icon,
    required this.iconColor,
    required this.content,
    required this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      title: Text(
        title,
        textAlign: TextAlign.center,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 60, color: iconColor),
          const SizedBox(height: 16),
          content, // The dynamic content injected from the screen
        ],
      ),
      actionsAlignment: MainAxisAlignment.center,
      actions: actions, // The dynamic buttons injected from the screen
    );
  }
}
