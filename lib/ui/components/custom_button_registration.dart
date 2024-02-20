import 'package:flutter/material.dart';

class CustomButtonRegistration extends StatelessWidget {
  const CustomButtonRegistration({
    super.key,
    required this.child,
    required this.onTap,
    required this.height,
    required this.width,
  });
  final Widget child;
  final VoidCallback onTap;
  final double height;
  final double width;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: onTap,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
            color: theme.cardColor, borderRadius: BorderRadius.circular(20)),
        child: Center(
          child: child,
        ),
      ),
    );
  }
}
