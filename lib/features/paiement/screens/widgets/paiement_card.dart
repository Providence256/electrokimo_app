import 'package:flutter/material.dart';

class PaiementCard extends StatelessWidget {
  const PaiementCard({
    super.key,
    required this.text,
    required this.image,
  });
  final String text, image;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(7),
              child: SizedBox(
                height: 60,
                width: 60,
                child: Image(
                  image: AssetImage(image),
                ),
              ),
            ),
            const SizedBox(width: 20),
            Text(text),
          ],
        ),
        Radio(
          value: true,
          groupValue: true,
          onChanged: (value) {},
        )
      ],
    );
  }
}
