import 'package:flutter/material.dart';

class UpToDownFade extends StatelessWidget {
  final Widget childWidget;
  final AnimationController controller;
  final double delay;
  final Animation<double> opacity;
  final Animation<double> trasitionY;
  UpToDownFade(
      {Key? key,
      required this.childWidget,
      required this.controller,
      required this.delay})
      : opacity = Tween(begin: 0.0, end: 1.0)
            .animate(CurvedAnimation(parent: controller, curve: Curves.ease)),
        trasitionY = Tween(begin: -40.0, end: 0.0)
            .animate(CurvedAnimation(parent: controller, curve: Curves.ease)),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        return Opacity(
          opacity: opacity.value,
          child: Transform.translate(
            offset: Offset(0, trasitionY.value),
            child: childWidget,
          ),
        );
      },
    );
  }

  // Future<Widget> starter() async {
  //   await Future.delayed(const Duration(seconds: 1));
  //   return Opacity(
  //     opacity: opacity.value,
  //     child: Transform.translate(
  //       offset: Offset(0, trasitionY.value),
  //       child: childWidget,
  //     ),
  //   );
  // }
}

// class UpToDownFade extends StatefulWidget {
//   final Widget childWidget;
//   final AnimationController controller;
//   final double delay;
//   const UpToDownFade(
//       {Key? key,
//       required this.childWidget,
//       required this.controller,
//       required this.delay})
//       : super(key: key);

//   @override
//   _UpToDownFadeState createState() => _UpToDownFadeState();
// }

// class _UpToDownFadeState extends State<UpToDownFade>
//     with SingleTickerProviderStateMixin {
//   late AnimationController autoController;
//   late Animation<double> opacity;
//   late Animation<double> trasitionY;
//   late Animation<double> autoOpacity;
//   late Animation<double> autoTrasitionY;

//   @override
//   void initState() {
//     autoController =
//         AnimationController(vsync: this, duration: const Duration(seconds: 2));
//     autoOpacity = Tween(begin: 0.0, end: 1.0).animate(
//         CurvedAnimation(parent: widget.controller, curve: Curves.ease));
//     autoTrasitionY = Tween(begin: -40.0, end: 0.0).animate(
//         CurvedAnimation(parent: widget.controller, curve: Curves.ease));
//     opacity = Tween(begin: 0.0, end: 1.0).animate(
//         CurvedAnimation(parent: widget.controller, curve: Curves.ease));
//     trasitionY = Tween(begin: 0.0, end: -40.0).animate(
//         CurvedAnimation(parent: widget.controller, curve: Curves.ease));
//     autoPlay();
//     super.initState();
//   }

//   autoPlay() async {
//     await Future.delayed(Duration(milliseconds: widget.delay.round() * 1000),
//         () {
//       autoController.forward();
//     });
//   }

//   @override
//   void dispose() {
//     autoController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return AnimatedBuilder(
//       animation: autoController,
//       builder: (context, child) {
//         return Opacity(
//           opacity: autoOpacity.value,
//           child: Transform.translate(
//             offset: Offset(0, autoTrasitionY.value),
//             child: widget.childWidget,
//           ),
//         );
//       },
//     );
//   }
// }
