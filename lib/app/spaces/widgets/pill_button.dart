import 'package:flutter/material.dart';
import '../../../core/color_constants.dart';

class PillButton extends StatelessWidget {
  const PillButton({super.key, required this.child, this.onTap});

  final Widget child;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 12),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.border),
          borderRadius: BorderRadius.circular(100),
        ),
        child: child,
      ),
    );
  }
}
