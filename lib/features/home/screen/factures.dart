import 'package:electrokimo/common/widgets/app_bar.dart';
import 'package:electrokimo/features/home/controller/home_controller.dart';
import 'package:electrokimo/features/paiement/screens/pas_facture.dart';
import 'package:electrokimo/size_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class FacturesScreen extends StatelessWidget {
  const FacturesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeController());
    return Scaffold(
      appBar: TAppBar(
        showbackArrow: false,
        title: Text(
          "Historique Factures",
          style: Theme.of(context).textTheme.headlineSmall!.apply(
                color: Colors.white,
              ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(getProportionateScreenWidth(20)),
          child: Column(
            children: [
              //Dropdown
              DropdownButtonFormField(
                value: controller.selectedFactureType.value,
                hint: const Text("Trier Facture"),
                decoration: const InputDecoration(
                  prefixIcon: Icon(
                    Iconsax.sort,
                    color: Colors.black,
                  ),
                ),
                items: [
                  'Facture Payée',
                  'Factures non Payées',
                ]
                    .map(
                      (option) => DropdownMenuItem(
                        value: option,
                        child: Text(option),
                      ),
                    )
                    .toList(),
                onChanged: (value) {
                  controller.selectedFactureType.value = value as String;
                },
              ),

              Obx(() {
                final factures;
                // = controller.selectedFactureType.value ==
                //         "Factures non Payées"
                //     ? controller.factureRappel['data']['detailItems']
                //     : controller.paidFactures['data']?['detailItems'];
                if (controller.selectedFactureType.value ==
                    "Factures non Payées") {
                  factures = controller.factureRappel['data']?['detailItems'];
                } else {
                  factures = controller.paidFactures['data']?['detailItems'];
                }

                if (factures == null) {
                  return const PasFactureScreen(
                    image: "assets/images/bill.png",
                    text: "Aucune facture disponible",
                  );
                }

                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: factures.length,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (_, index) => Column(
                    children: [
                      ListTile(
                        leading: IconButton(
                            style: IconButton.styleFrom(
                              backgroundColor: Colors.grey[200],
                            ),
                            onPressed: () {},
                            icon: Icon(
                              Iconsax.receipt,
                              color: Colors.blue.shade900,
                              size: getProportionateScreenWidth(30),
                            )),
                        title: Text(
                          factures[index]['numFacture'],
                          style: Theme.of(context)
                              .textTheme
                              .labelMedium!
                              .apply(fontWeightDelta: 1),
                        ),
                        subtitle: Text(
                          "${factures[index]['codeDevise']} ${factures[index]['montant'].toStringAsFixed(3)}",
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall!
                              .apply(
                                color: controller.selectedFactureType.value ==
                                        "Factures non Payées"
                                    ? Colors.red
                                    : Colors.green,
                              ),
                        ),
                        trailing: Column(
                          children: [
                            Text(
                              controller
                                  .convertDate(factures[index]['periode']),
                              style: Theme.of(context).textTheme.labelMedium,
                            ),
                            Expanded(
                              child: IconButton(
                                onPressed: () {},
                                icon: const Icon(
                                  Iconsax.document_download,
                                  color: Colors.green,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      const Divider(thickness: 1),
                    ],
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
