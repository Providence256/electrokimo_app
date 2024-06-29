import 'package:country_code_picker/country_code_picker.dart';
import 'package:electrokimo/features/auth/controllers/signup/signup_controller.dart';
import 'package:electrokimo/features/auth/controllers/verification/verification_controller.dart';
import 'package:electrokimo/utils/validators/validators.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class SignupForm extends StatelessWidget {
  const SignupForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignUpController());
    final verifController = Get.find<VerificationController>();
    final GlobalKey<FormState> signupFormKey = GlobalKey<FormState>();

    return Form(
        key: signupFormKey,
        child: Column(
          children: [
            TextFormField(
              controller: verifController.pa,
              validator: (value) =>
                  TValidators.validateInput("Police Abonnement", value),
              readOnly: true,
              decoration: const InputDecoration(
                errorStyle: TextStyle(fontSize: 14),
                prefixIcon: Icon(Iconsax.note),
                labelText: "Police Abonnement",
              ),
            ),
            const SizedBox(height: 15),
            TextFormField(
              controller: controller.telephone,
              validator: (value) => TValidators.validateCodeCountry(
                  "Telephone", controller.countryCode.value + value!),
              decoration: InputDecoration(
                errorStyle: const TextStyle(fontSize: 14),
                prefixIcon: CountryCodePicker(
                  onChanged: (value) {
                    controller.countryCode.value = value.dialCode!;
                  },
                  favorite: const ["CD"],
                  initialSelection: "CD",
                  flagWidth: 25,
                  padding: const EdgeInsets.all(0),
                  flagDecoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(3)),
                ),
                labelText: "Telephone",
              ),
            ),
            const SizedBox(height: 15),
            TextFormField(
              controller: controller.email,
              decoration: const InputDecoration(
                prefixIcon: Icon(Iconsax.message),
                labelText: "Email",
              ),
            ),
            const SizedBox(height: 15),
            Obx(
              () => TextFormField(
                controller: controller.password,
                validator: (value) => TValidators.validatePassword(value),
                obscureText: controller.hidePassword.value,
                decoration: InputDecoration(
                  errorStyle: const TextStyle(fontSize: 14),
                  prefixIcon: const Icon(Iconsax.lock),
                  labelText: "Mot de Passe",
                  suffixIcon: IconButton(
                    onPressed: () => controller.hidePassword.value =
                        !controller.hidePassword.value,
                    icon: controller.hidePassword.value
                        ? const Icon(Iconsax.eye_slash)
                        : const Icon(
                            Iconsax.eye,
                            color: Colors.black,
                          ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 15),
            Obx(
              () => TextFormField(
                controller: controller.confirmPassword,
                validator: (value) => TValidators.checkPassword(
                    value, controller.password.text.trim()),
                obscureText: controller.confirmHidePassword.value,
                decoration: InputDecoration(
                  errorStyle: const TextStyle(fontSize: 14),
                  prefixIcon: const Icon(Iconsax.lock),
                  labelText: "Confirmer Mot de Passe",
                  suffixIcon: IconButton(
                    onPressed: () => controller.confirmHidePassword.value =
                        !controller.confirmHidePassword.value,
                    icon: controller.confirmHidePassword.value
                        ? const Icon(Iconsax.eye_slash)
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
                  if (signupFormKey.currentState!.validate()) {
                    controller.signup();
                  }
                },
                child: const Text("Créer Compte"),
              ),
            ),
          ],
        ));
  }
}
