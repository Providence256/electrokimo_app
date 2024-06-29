import 'package:flutter/material.dart';

class PasFactureScreen extends StatelessWidget {
  const PasFactureScreen({super.key, required this.image, required this.text});

  final String image, text;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 200),
          SizedBox(
            height: 95,
            width: 95,
            child: Image(
              image: AssetImage(image),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            text,
            style: Theme.of(context).textTheme.titleMedium,
          )
        ],
      ),
    );
  }
}
