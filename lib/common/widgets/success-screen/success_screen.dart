import 'package:electrokimo/features/auth/screens/login.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class SuccessScreen extends StatelessWidget {
  const SuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(
            top: 56,
            left: 24,
            right: 24,
            bottom: 24,
          ),
          child: Column(
            children: [
              Lottie.asset("assets/animations/72462-check-register.json",
                  width: MediaQuery.of(context).size.width * 0.6),
              const SizedBox(height: 36),
              Text(
                "L'enregistrement s'est effectué avec succès",
                style: Theme.of(context).textTheme.headlineMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Text(
                "Clicker sur continuer pour se connecter",
                style: Theme.of(context).textTheme.labelMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 36),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Get.offAll(
                    () => const LoginScreen(),
                  ),
                  child: const Text(
                    ("Continuer"),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
