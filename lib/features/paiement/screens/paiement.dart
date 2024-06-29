import 'package:electrokimo/common/widgets/app_bar.dart';
import 'package:electrokimo/features/paiement/controllers/paiement_controller.dart';
import 'package:electrokimo/features/paiement/screens/detail_paiement.dart';
import 'package:electrokimo/features/paiement/screens/pas_facture.dart';
import 'package:electrokimo/features/paiement/screens/widgets/single_facture.dart';
import 'package:electrokimo/size_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class PaiementScreen extends StatelessWidget {
  const PaiementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final PaiementController controller = Get.put(PaiementController());
    final factures =
        controller.factureController.factureRappel['data']?['detailItems'];

    return Scaffold(
      appBar: TAppBar(
        title: Text(
          "Paiement Facture",
          style: Theme.of(context)
              .textTheme
              .headlineSmall!
              .apply(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(getProportionateScreenWidth(24)),
          child: factures == null
              ? const PasFactureScreen(
                  image: "assets/images/send-money.png",
                  text: "vous n'avez aucune facture a payée",
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Montant Total",
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    Container(
                        width: double.infinity,
                        height: getProportionateScreenHeight(55),
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 1,
                            color: Colors.blue.withOpacity(0.5),
                          ),
                          color: const Color.fromARGB(255, 223, 240, 253),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Row(
                                children: [
                                  Text(
                                    controller.codeDevise.toString(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineMedium,
                                  ),
                                  const SizedBox(width: 5),
                                  const VerticalDivider(
                                    thickness: 2,
                                    color: Colors.black,
                                  ),
                                ],
                              ),
                              const SizedBox(width: 10),
                              Text(
                                controller.montantTotal.toString(),
                                style:
                                    Theme.of(context).textTheme.headlineMedium,
                              )
                            ],
                          ),
                        )),
                    const SizedBox(height: 15),
                    Row(
                      children: [
                        Expanded(
                          child: SizedBox(
                            child: DropdownButtonFormField(
                              value: "USD",
                              icon: const Icon(Iconsax.arrow_right_34),
                              iconSize: 18,
                              items: [
                                "USD",
                                "CDF",
                              ]
                                  .map((option) => DropdownMenuItem(
                                        value: option,
                                        child: Row(
                                          children: [
                                            Image(
                                              width:
                                                  getProportionateScreenWidth(
                                                      25),
                                              height:
                                                  getProportionateScreenHeight(
                                                      25),
                                              fit: BoxFit.cover,
                                              image: option == "USD"
                                                  ? const AssetImage(
                                                      "assets/images/united-states.png",
                                                    )
                                                  : const AssetImage(
                                                      "assets/images/democratic-republic-of-congo.png"),
                                            ),
                                            const SizedBox(width: 10),
                                            Text(
                                              option,
                                            )
                                          ],
                                        ),
                                      ))
                                  .toList(),
                              onChanged: (value) {},
                            ),
                          ),
                        ),
                        const SizedBox(width: 15),
                        Expanded(
                          child: TextFormField(
                            readOnly: true,
                            decoration: const InputDecoration(
                              labelText: "Taux de Change",
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 15,
                                vertical: 18,
                              ),
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                            ),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 15),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            textAlign: TextAlign.end,
                            style: TextStyle(
                                fontSize: getProportionateScreenWidth(18)),
                            controller: controller.montantAPayer,
                            decoration: InputDecoration(
                              errorStyle: TextStyle(
                                  fontSize: getProportionateScreenWidth(14)),
                              labelText: "Montant a payer",
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 15,
                                vertical: 12,
                              ),
                              labelStyle: const TextStyle(color: Colors.grey),
                            ),
                            keyboardType: TextInputType.number,
                            onChanged: (value) {
                              if (value.isNotEmpty) {
                                double amount = double.tryParse(value) ?? 0;

                                if (amount > controller.montantTotalValue) {
                                  controller.montantAPayer.text = 0.toString();
                                  controller.distributeAmount(0);
                                  Get.snackbar(
                                    "Avertissement",
                                    "le Montant a payer ne doit pas etre superieur au montant total",
                                    isDismissible: true,
                                    backgroundColor: const Color(0xFFFEFCE9),
                                    colorText: const Color(0xFFD29B27),
                                    snackPosition: SnackPosition.BOTTOM,
                                    icon: const Icon(
                                      Iconsax.warning_2,
                                      color: Color(0xFFD29B27),
                                    ),
                                    duration: const Duration(seconds: 3),
                                  );
                                } else {
                                  controller.distributeAmount(amount);
                                }
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: factures.length,
                        itemBuilder: (_, index) {
                          return Obx(() {
                            double distributedAmount =
                                controller.distributedAmounts[index] ?? 0;
                            return SingleFacture(
                              referenceFacture: factures[index]['numFacture'],
                              prix:
                                  "${factures[index]['codeDevise']} ${factures[index]['montant'].toStringAsFixed(3)}",
                              periode: controller.factureController
                                  .convertDate(factures[index]['periode']),
                              montantPaye: distributedAmount.toStringAsFixed(3),
                            );
                          });
                        }),
                  ],
                ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Obx(
        () {
          return controller.isMontantPayerNotEmpty.value
              ? FloatingActionButton.extended(
                  backgroundColor: Colors.blue[800],
                  onPressed: () {
                    controller.paiedFactures();
                    Get.to(
                      () => const DetailPaiement(),
                    );
                  },
                  label: Text(
                    "Continuer pour Payer",
                    style: Theme.of(context).textTheme.labelLarge!.apply(
                          color: Colors.white,
                        ),
                  ),
                  icon: const Icon(
                    Iconsax.arrow_right_1,
                    color: Colors.white,
                  ),
                )
              : const SizedBox.shrink();
        },
      ),
    );
  }
}
