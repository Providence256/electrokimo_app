import 'package:electrokimo/size_config.dart';
import 'package:flutter/material.dart';

class CircularContainer extends StatelessWidget {
  const CircularContainer({super.key, this.child});

  final Widget? child;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: getProportionateScreenHeight(200),
      width: getProportionateScreenWidth(200),
      padding: const EdgeInsets.all(0),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(200),
      ),
      child: child,
    );
  }
}
