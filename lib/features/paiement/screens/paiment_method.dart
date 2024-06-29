import 'package:electrokimo/features/paiement/controllers/paiement_controller.dart';
import 'package:electrokimo/features/paiement/screens/widgets/paiement_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class PaiementMethod extends StatelessWidget {
  const PaiementMethod({super.key});

  @override
  Widget build(BuildContext context) {
    final PaiementController controller = Get.find();
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Total  \$${controller.totalAmount}",
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                IconButton(
                  onPressed: () => Get.back(),
                  icon: const Icon(Iconsax.close_circle),
                ),
              ],
            ),
            const Divider(),
            const SizedBox(height: 20),
            const PaiementCard(
              text: 'Airtel Money',
              image: 'assets/images/images.png',
            ),
            const SizedBox(height: 20),
            const PaiementCard(
              text: "Orange Money",
              image: "assets/images/Orange_logo.svg.png",
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue[800],
                ),
                onPressed: () {},
                child: const Text("Payer"),
              ),
            )
          ],
        ),
      ),
    );
  }
}
