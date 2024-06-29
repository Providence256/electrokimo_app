import 'package:electrokimo/features/auth/screens/widgets/login_form.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 30),
              Text(
                "Se Connecter",
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              Text(
                "Connectez vous pour continuer...",
                style: Theme.of(context)
                    .textTheme
                    .labelMedium!
                    .apply(color: Colors.grey),
              ),
              const Image(image: AssetImage("assets/images/login.png")),
              const LoginForm()
            ],
          ),
        ),
      ),
    );
  }
}
