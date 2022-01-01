import 'package:flutter/material.dart';

class AddToCardAnimation extends StatelessWidget {
  final Widget childWidget;
  final double width;
  final double height;
  final AnimationController controller;
  final Animation<Offset> offset;
  final Animation<Offset> size;
  final Animation<double> opacity;
  AddToCardAnimation(
      {Key? key,
      required this.childWidget,
      required this.width,
      required this.height,
      required this.controller})
      : size = Tween(
                begin: Offset(width * 0.4, width * 0.55),
                end: const Offset(0, 0))
            .animate(
          CurvedAnimation(
            parent: controller,
            curve: const Interval(0.0, 1.0, curve: Curves.ease),
          ),
        ),
        offset = Tween<Offset>(
          begin: const Offset(20, 20),
          end: Offset(width - 100, height - 100),
        ).animate(
          CurvedAnimation(
            parent: controller,
            curve: const Interval(0.0, 1.0, curve: Curves.ease),
          ),
        ),
        opacity = Tween(begin: 0.0, end: 1.0).animate(
          CurvedAnimation(
            parent: controller,
            curve: const Interval(0.0, 0.0, curve: Curves.ease),
          ),
        ),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        return Positioned(
          top: offset.value.dy,
          right: offset.value.dx,
          child: SizedBox(
            width: size.value.dx,
            height: size.value.dy,
            child: Opacity(
              opacity: opacity.value,
              child: childWidget,
            ),
          ),
        );
      },
    );
  }
}
