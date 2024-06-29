import 'package:electrokimo/features/auth/screens/login.dart';
import 'package:electrokimo/features/auth/screens/widgets/signup_form.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 70),
              Text(
                "Créer votre compte",
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              Text(
                "Enregistrer vos informations personnelles",
                style: Theme.of(context)
                    .textTheme
                    .labelMedium!
                    .apply(color: Colors.grey),
              ),
              const SizedBox(height: 24),
              const SignupForm(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("vous avez un compte?"),
                  TextButton(
                    onPressed: () => Get.off(
                      () => const LoginScreen(),
                    ),
                    child: Text(
                      "Connectez-vous",
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium!
                          .apply(color: Colors.blue.shade800),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
