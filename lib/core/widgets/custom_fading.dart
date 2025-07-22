import 'package:flutter/material.dart';

class CustomFading extends StatefulWidget {
  const CustomFading({super.key, required this.child});
  final Widget child;

  @override
  State<CustomFading> createState() => _CustomFadingState();
}

class _CustomFadingState extends State<CustomFading>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation animation;
  @override
  void initState() {
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    animation = Tween<double>(
      begin: 0.2,
      end: 0.8,
    ).animate(animationController);
    animationController.addListener(() {
      setState(() {});
      animationController.repeat(reverse: true);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Opacity(opacity: animation.value, child: widget.child);
  }
}
