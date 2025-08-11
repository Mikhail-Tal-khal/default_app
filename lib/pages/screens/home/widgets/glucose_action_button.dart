import 'package:flutter/material.dart';

class GlucoseActionButton extends StatelessWidget {
  final String text;
  final IconData icon;
  final bool isSmallScreen;

  const GlucoseActionButton({super.key, 
    required this.text,
    required this.icon,
    required this.isSmallScreen,
  });

  @override
  Widget build(BuildContext context) {
    final height = isSmallScreen ? 40.0 : 48.0;
    final iconSize = isSmallScreen ? 16.0 : 20.0;
    final fontSize = isSmallScreen ? 12.0 : 14.0;
    final padding = isSmallScreen ? 8.0 : 12.0;

    return Container(
      height: height,
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: padding),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: iconSize, color: Colors.white),
            SizedBox(width: padding),
            Flexible(
              child: Text(
                text,
                style: TextStyle(color: Colors.white, fontSize: fontSize),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AddButton extends StatelessWidget {
  final VoidCallback onPressed;
  final bool isSmallScreen;

  const AddButton({super.key, 
    required this.onPressed,
    required this.isSmallScreen,
  });

  @override
  Widget build(BuildContext context) {
    final buttonSize = isSmallScreen ? 40.0 : 50.0;
    final iconSize = isSmallScreen ? 24.0 : 28.0;

    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.2),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: IconButton(
        onPressed: onPressed,
        icon: Container(
          width: buttonSize,
          height: buttonSize,
          decoration: const BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
          ),
          child: Icon(
            Icons.add,
            color: const Color(0xFF1A237E),
            size: iconSize,
          ),
        ),
      ),
    );
  }
}