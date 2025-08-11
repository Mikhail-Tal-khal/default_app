import 'package:flutter/material.dart';
import 'package:default_app/constants/colors.dart';

class HomeFloatingActionButton extends StatelessWidget {
  final VoidCallback onPressed;
  static const _deepBlue = MColors.primary;

  const HomeFloatingActionButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      backgroundColor: _deepBlue,
      onPressed: onPressed,
      child: const Icon(Icons.add_a_photo_outlined, color: Colors.white),
    );
  }
}