import 'package:flutter/material.dart';

class AppIcon extends StatelessWidget {
  final double height;
  final double width;

  const AppIcon({super.key, this.width = 32, this.height = 32});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            theme.primaryColor,
            theme.primaryColor.withValues(alpha: 0.7),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: const Icon(Icons.flash_on, color: Colors.white, size: 20),
    );
  }
}
