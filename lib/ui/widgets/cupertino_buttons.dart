// ignore: file_names
import 'package:flutter/cupertino.dart';

class IconTextButton extends StatelessWidget {
  final IconData iconData;
  final String label;
  final Color color;
  final VoidCallback onPressed;

  const IconTextButton({
    Key? key,
    required this.iconData,
    required this.label,
    required this.color,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      pressedOpacity: 0.1,
      padding: const EdgeInsets.symmetric(
        horizontal: 24,
        vertical: 59.5,
      ),
      onPressed: onPressed,
      color: color,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(iconData, color: CupertinoColors.white),
          const SizedBox(width: 3),
          Text(
            label,
            style: const TextStyle(color: CupertinoColors.white),
          ),
        ],
      ),
    );
  }
}
