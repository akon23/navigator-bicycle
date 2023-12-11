import 'package:flutter/material.dart';

class BottomNavigationItem extends StatelessWidget {
  const BottomNavigationItem({
    required this.title,
    required this.icon,
    this.isActive = false,
    this.onItemSelected,
    super.key,
  });

  final String title;
  final bool isActive;
  final IconData icon;
  final VoidCallback? onItemSelected;

  @override
  Widget build(BuildContext context) {
    final color = isActive ? Colors.blue : const Color(0xff938F99);

    return InkWell(
      onTap: onItemSelected,
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: color, size: 32),
          Text(
            title,
            style: TextStyle(
              color: color,
              fontSize: 10,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
