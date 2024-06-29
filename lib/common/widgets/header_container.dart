import 'package:electrokimo/common/custom_shape/curved_edge_widget.dart';
import 'package:flutter/material.dart';

class HeaderContainer extends StatelessWidget {
  const HeaderContainer({super.key, required this.child, required this.height});

  final Widget child;
  final double height;
  @override
  Widget build(BuildContext context) {
    return CurvedEdgeWidget(
      child: Container(
        height: height,
        color: Colors.blue[800],
        child: child,
      ),
    );
  }
}
