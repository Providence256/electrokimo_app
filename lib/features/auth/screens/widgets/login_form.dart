import 'package:electrokimo/features/auth/controllers/login/login_controller.dart';
import 'package:electrokimo/features/auth/screens/verification_screen.dart';
import 'package:electrokimo/utils/validators/validators.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());
    final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
    return Form(
        key: loginFormKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 32),
          child: Column(
            children: [
              TextFormField(
                controller: controller.policeAbonnement,
                validator: (value) =>
                    TValidators.checkPaformat("Police abonnement", value),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                decoration: const InputDecoration(
                  errorStyle: TextStyle(fontSize: 14),
                  prefixIcon: Icon(Iconsax.user),
                  labelText: "Police Abonnement",
                ),
              ),
              const SizedBox(height: 15),
              Obx(
                () => TextFormField(
                  obscureText: controller.hidePassword.value,
                  controller: controller.password,
                  validator: (value) => TValidators.validatePassword(value),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: InputDecoration(
                    errorStyle: const TextStyle(fontSize: 14),
                    prefixIcon: const Icon(Iconsax.lock),
                    labelText: "Mot de Passe",
                    suffixIcon: IconButton(
                      onPressed: () => controller.hidePassword.value =
                          !controller.hidePassword.value,
                      icon: controller.hidePassword.value
                          ? const Icon(
                              Iconsax.eye_slash,
                            )
                          : const Icon(
                              Iconsax.eye,
                              color: Colors.black,
                            ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (loginFormKey.currentState!.validate()) {
                      controller.login();
                    }
                  },
                  child: Text(
                    "Se Connecter",
                    style: Theme.of(context).textTheme.labelLarge!.apply(
                          color: Colors.white,
                        ),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              const Text("vous n'avez pas de compte ?"),
              const SizedBox(height: 15),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () => Get.to(() => const VerificationScreen()),
                  child: Text(
                    "Créer Compte",
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
