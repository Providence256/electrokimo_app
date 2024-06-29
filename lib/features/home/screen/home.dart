import 'package:electrokimo/common/widgets/circular_container.dart';
import 'package:electrokimo/common/widgets/header_container.dart';
import 'package:electrokimo/features/home/controller/home_controller.dart';
import 'package:electrokimo/size_config.dart';
import 'package:electrokimo/utils/formatters/formatters.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeController());
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            HeaderContainer(
              height: getProportionateScreenHeight(130),
              child: Padding(
                padding: EdgeInsets.all(getProportionateScreenWidth(24.0)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Obx(
                      () => Text(
                        "${Formatter.getGreetings()}, ${Formatter.getFirstTwoNames(controller.userName.toString())}",
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: Theme.of(context)
                            .textTheme
                            .headlineSmall!
                            .apply(color: Colors.white),
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Iconsax.notification,
                        color: Colors.white,
                      ),
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: getProportionateScreenWidth(24)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: getProportionateScreenHeight(30),
                    width: getProportionateScreenWidth(110),
                    decoration: BoxDecoration(
                      color: Colors.green.shade100,
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(
                        color: const Color.fromARGB(255, 62, 230, 67),
                      ),
                    ),
                    child: Row(
                      children: [
                        Container(
                          height: getProportionateScreenHeight(8),
                          width: getProportionateScreenWidth(8),
                          margin:
                              EdgeInsets.all(getProportionateScreenWidth(10)),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color: Colors.green,
                          ),
                        ),
                        Text(
                          controller.userData.status,
                          style: Theme.of(context).textTheme.labelMedium!.apply(
                                color: Colors.black87,
                              ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 15),
                  Container(
                    height: 160,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.blue.shade300,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Stack(
                      children: [
                        Padding(
                          padding:
                              EdgeInsets.all(getProportionateScreenWidth(10)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Icon(
                                Iconsax.dollar_circle,
                                size: 40,
                                color: Colors.white,
                              ),
                              const SizedBox(height: 10),
                              Expanded(
                                child: Text(
                                  "Consommation totale",
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineMedium!
                                      .apply(color: Colors.white),
                                ),
                              ),
                              const SizedBox(height: 5),
                              Expanded(
                                child: Obx(() {
                                  if (controller.factureRappel.isEmpty) {
                                    return Text(
                                      "USD 0.000",
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineLarge!
                                          .apply(color: Colors.white),
                                    );
                                  }

                                  double montantTotal = controller
                                      .factureRappel['data']['montantTotal'];
                                  String formattedMontant =
                                      montantTotal.toStringAsFixed(3);
                                  return Text(
                                    "${controller.factureRappel['data']['devideCode']}  $formattedMontant",
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineLarge!
                                        .apply(
                                          color: Colors.white,
                                        ),
                                  );
                                }),
                              ),
                            ],
                          ),
                        ),
                        const Positioned(
                          top: -100,
                          right: -50,
                          child: CircularContainer(),
                        ),
                        const Positioned(
                          bottom: -100,
                          left: -30,
                          child: CircularContainer(),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: getProportionateScreenHeight(15)),
                  Container(
                    width: double.infinity,
                    height: getProportionateScreenHeight(400),
                    padding: EdgeInsets.all(getProportionateScreenWidth(15)),
                    decoration: BoxDecoration(
                      boxShadow: const [
                        BoxShadow(
                          offset: Offset(0, 0),
                          blurRadius: 2,
                          spreadRadius: 2,
                          color: Color.fromRGBO(227, 241, 254, 1),
                        )
                      ],
                      color: const Color.fromRGBO(234, 241, 246, 1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Obx(() {
                      if (controller.lastFacture.isEmpty) {
                        return Center(
                          child: Text(
                            "Pas de Facture Disponible",
                            style: Theme.of(context)
                                .textTheme
                                .headlineMedium!
                                .apply(color: Colors.red),
                            textAlign: TextAlign.center,
                          ),
                        );
                      }
                      String periode =
                          controller.lastFacture['data']['periode'];
                      double meMontantDb =
                          controller.lastFacture['data']['meMontantDb'];
                      double redevanceUsd =
                          controller.lastFacture['data']['redevanceUsd'];
                      double tvaUsd = controller.lastFacture['data']['tvaUsd'];
                      double totalPrice = controller.calculateTotalPrice(
                          meMontantDb: meMontantDb,
                          redevanceUsd: redevanceUsd,
                          tvaUsd: tvaUsd);
                      return Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                children: [
                                  const Text("Facture"),
                                  Text(
                                    controller
                                        .convertDate(periode)
                                        .toUpperCase(),
                                    style:
                                        Theme.of(context).textTheme.titleLarge,
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Icon(
                            Icons.receipt_long,
                            size: getProportionateScreenWidth(100),
                            color: const Color.fromRGBO(174, 209, 235, 1),
                          ),
                          const SizedBox(height: 15),
                          Text(
                            "Montant de la Facture",
                            style: Theme.of(context)
                                .textTheme
                                .headlineMedium!
                                .apply(color: Colors.black45),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 10),
                          Text(
                            "USD ${totalPrice.toStringAsFixed(3)}",
                            style: Theme.of(context)
                                .textTheme
                                .headlineLarge!
                                .apply(fontSizeDelta: 10, color: Colors.black),
                          ),
                          const SizedBox(height: 15),
                          TextButton(
                            onPressed: () {},
                            child: SizedBox(
                              width: getProportionateScreenWidth(130),
                              child: Row(
                                children: [
                                  Icon(
                                    Iconsax.receipt,
                                    size: getProportionateScreenWidth(16),
                                    color: Colors.blue.shade900,
                                  ),
                                  const SizedBox(width: 5),
                                  Text(
                                    "Voir Facture",
                                    style: TextStyle(
                                      fontSize: getProportionateScreenWidth(16),
                                      decoration: TextDecoration.underline,
                                      color: Colors.blue.shade900,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      );
                    }),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
