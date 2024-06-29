import 'package:electrokimo/features/home/screen/factures.dart';
import 'package:electrokimo/features/home/screen/home.dart';
import 'package:electrokimo/features/paiement/screens/paiement.dart';
import 'package:electrokimo/features/home/screen/profile.dart';
import 'package:electrokimo/size_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class NavigationMenu extends StatelessWidget {
  const NavigationMenu({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NavigationController());
    SizeConfig().init(context);
    return Scaffold(
      bottomNavigationBar: Obx(
        () => NavigationBarTheme(
          data: NavigationBarThemeData(
            labelTextStyle: WidgetStateProperty.resolveWith<TextStyle?>(
              (states) {
                if (states.contains(WidgetState.selected)) {
                  return TextStyle(
                    color: Colors.blue.shade800,
                    fontSize: 12,
                  );
                }
                return const TextStyle(
                  fontSize: 12,
                );
              },
            ),
          ),
          child: NavigationBar(
            height: 80,
            backgroundColor: Colors.grey[100],
            selectedIndex: controller.selectedIndex.value,
            elevation: 0,
            indicatorColor: Colors.blue.shade800.withOpacity(0.1),
            onDestinationSelected: (index) =>
                controller.selectedIndex.value = index,
            destinations: [
              NavigationDestination(
                selectedIcon: Icon(
                  Iconsax.home_15,
                  color: Colors.blue.shade800,
                ),
                icon: const Icon(
                  Iconsax.home,
                ),
                label: "Accueil",
              ),
              NavigationDestination(
                selectedIcon: Icon(
                  Iconsax.document,
                  color: Colors.blue.shade800,
                ),
                icon: const Icon(Iconsax.document),
                label: "Factures",
              ),
              NavigationDestination(
                selectedIcon: Icon(
                  Iconsax.empty_wallet5,
                  color: Colors.blue.shade800,
                ),
                icon: const Icon(Iconsax.empty_wallet),
                label: "Paiement",
              ),
              NavigationDestination(
                selectedIcon: Icon(
                  Iconsax.user,
                  color: Colors.blue.shade800,
                ),
                icon: const Icon(Iconsax.user),
                label: "Profile",
              )
            ],
          ),
        ),
      ),
      body: Obx(
        () => controller.screens[controller.selectedIndex.value],
      ),
    );
  }
}

class NavigationController extends GetxController {
  final Rx<int> selectedIndex = 0.obs;

  final screens = [
    const HomeScreen(),
    const FacturesScreen(),
    const PaiementScreen(),
    const ProfileScreen(),
  ];
}
