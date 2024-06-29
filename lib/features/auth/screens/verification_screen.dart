import 'package:electrokimo/features/auth/controllers/verification/verification_controller.dart';
import 'package:electrokimo/utils/validators/validators.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class VerificationScreen extends StatelessWidget {
  const VerificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(VerificationController());
    final GlobalKey<FormState> verificationFormKey = GlobalKey<FormState>();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(
            left: 24,
            right: 24,
            top: 0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Vérification Police Abonnement",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              Text(
                "Veuiller renseigner votre police d'abonnement pour Continuer",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.labelMedium!.apply(
                      color: Colors.grey,
                    ),
              ),
              const SizedBox(height: 10),
              const Image(image: AssetImage("assets/images/verification.png")),
              const SizedBox(height: 10),
              Form(
                key: verificationFormKey,
                child: TextFormField(
                  controller: controller.pa,
                  validator: (value) =>
                      TValidators.checkPaformat("Police Abonnement", value),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Iconsax.note),
                    labelText: "Police Abonnement",
                  ),
                ),
              ),
              const SizedBox(height: 15),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (verificationFormKey.currentState!.validate()) {
                      controller.verifiyPa();
                    }
                  },
                  child: const Text("Continuer"),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
