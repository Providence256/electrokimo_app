import 'package:electrokimo/common/widgets/app_bar.dart';
import 'package:electrokimo/features/paiement/controllers/paiement_controller.dart';
import 'package:electrokimo/features/paiement/screens/paiment_method.dart';
import 'package:electrokimo/features/paiement/screens/widgets/single_facture.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DetailPaiement extends StatelessWidget {
  const DetailPaiement({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(PaiementController());

    return Scaffold(
      appBar: TAppBar(
        title: Text(
          "Detail Paiement",
          style: Theme.of(context).textTheme.headlineSmall!.apply(
                color: Colors.white,
              ),
        ),
        showbackArrow: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: controller.paidFactures.length,
                itemBuilder: (context, index) {
                  var facture = controller.paidFactures[index];
                  return SingleFacture(
                    referenceFacture: facture.referenceFacture,
                    prix:
                        "${facture.codeDevise} ${facture.montant.toStringAsFixed(3)}",
                    periode: facture.periode,
                    montantPaye: facture.montantPayer.toStringAsFixed(3),
                  );
                },
              ),
              const Divider(height: 50),
              SizedBox(
                width: double.infinity,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Total à Payer:",
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    Text(
                      "\$${controller.totalAmount}",
                      style: Theme.of(context).textTheme.headlineSmall,
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(24),
        child: ElevatedButton(
          onPressed: () {
            showModalBottomSheet(
              context: context,
              builder: (context) => const PaiementMethod(),
            );
          },
          child: const Text("Payer"),
        ),
      ),
    );
  }
}
