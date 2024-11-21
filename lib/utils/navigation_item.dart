import 'package:flutter/material.dart';

import 'colors.dart';

class NavigationItem extends StatelessWidget {
  final Widget icon;
  final String label;
  final bool labelDisable;
  final Function() onPressed;

  const NavigationItem(
      {super.key, required this.icon, required this.label, required this.onPressed, this.labelDisable = false});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: ConstrainedBox(
        constraints: const BoxConstraints(minWidth: 50),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              icon,
              const SizedBox(height: 6),
              Text(label,
                  style: labelDisable
                      ? const TextStyle(color: AppColors.kDisableButton, fontWeight: FontWeight.w400, fontSize: 10)
                      : TextStyle(color: AppColors.kTextColor, fontWeight: FontWeight.w400, fontSize: 10)),
            ],
          ),
        ),
      ),
    );
  }
}
