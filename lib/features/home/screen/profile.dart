import 'package:electrokimo/common/widgets/app_bar.dart';
import 'package:electrokimo/common/widgets/header_container.dart';
import 'package:electrokimo/features/auth/screens/login.dart';
import 'package:electrokimo/features/home/controller/home_controller.dart';
import 'package:electrokimo/features/home/screen/liste_reclamation.dart';
import 'package:electrokimo/features/home/screen/widgets/profile_tile.dart';
import 'package:electrokimo/size_config.dart';
import 'package:electrokimo/utils/formatters/formatters.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeController());
    return Scaffold(
      body: Column(
        children: [
          HeaderContainer(
            height: getProportionateScreenHeight(180),
            child: Column(
              children: [
                TAppBar(
                  title: Text(
                    "Profile",
                    style: Theme.of(context)
                        .textTheme
                        .headlineMedium!
                        .apply(color: Colors.white),
                  ),
                ),
                ListTile(
                  leading: Container(
                    height: getProportionateScreenHeight(50),
                    width: getProportionateScreenWidth(50),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(50),
                      border: Border.all(width: 1, color: Colors.white),
                    ),
                    child: const Icon(
                      Iconsax.user,
                      size: 30,
                    ),
                  ),
                  title: Text(
                    Formatter.getFirstTwoNames(controller.userName.value),
                    style: Theme.of(context)
                        .textTheme
                        .headlineSmall!
                        .apply(color: Colors.white),
                  ),
                  subtitle: Text(
                    controller.email.value,
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .apply(color: Colors.white),
                  ),
                  trailing: IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Iconsax.edit,
                      color: Colors.white,
                    ),
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  height: 255,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 2,
                          color: Colors.grey.withOpacity(0.5),
                        )
                      ]),
                  child: Column(
                    children: [
                      const ProfileTile(
                        title: "Historique Paiement",
                        subTitle: "liste des Paiements",
                        leadingIcon: Icon(
                          Iconsax.money,
                          size: 28,
                          color: Colors.blue,
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.0),
                        child: Divider(
                          thickness: 0.5,
                        ),
                      ),
                      ProfileTile(
                        leadingIcon: const Icon(
                          Iconsax.lock,
                          size: 28,
                          color: Colors.blue,
                        ),
                        title: "Réclamations",
                        subTitle: "Liste des réclamations",
                        onTap: () => Get.to(
                          () => const ListeReclamation(),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.0),
                        child: Divider(
                          thickness: 0.5,
                        ),
                      ),
                      const ProfileTile(
                        leadingIcon: Icon(
                          Iconsax.call,
                          size: 28,
                          color: Colors.blue,
                        ),
                        title: "Service Client",
                        subTitle: "Contacter le service client",
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 15),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    onPressed: () => Get.offAll(
                      () => const LoginScreen(),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Iconsax.logout_1,
                          color: Colors.red,
                        ),
                        SizedBox(width: 5),
                        Text(
                          "Se Déconnecter",
                          style: TextStyle(color: Colors.red),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
