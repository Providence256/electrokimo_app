import 'package:electrokimo/features/home/controller/home_controller.dart';
import 'package:electrokimo/features/home/models/paid_facture_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PaiementController extends GetxController {
  final factureController = HomeController.instance;

  late TextEditingController montantAPayer = TextEditingController();
  final distributedAmounts = <int, double>{}.obs;
  RxList selectedFactures = [].obs;
  final Rx<String> montantTotal = ''.obs;
  final Rx<String> codeDevise = ''.obs;
  late double montantTotalValue;
  final isMontantPayerNotEmpty = false.obs;

  final paidFactures = <PaidFactureModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    final data = factureController.factureRappel['data'];
    if (data != null) {
      final devise = data['devideCode'];
      final total = data['montantTotal'];
      montantTotalValue = total;
      montantTotal.value = '${total.toStringAsFixed(3)}';
      codeDevise.value = '$devise';

      montantAPayer.addListener(() {
        double amount = double.tryParse(montantAPayer.text) ?? 0;
        distributeAmount(amount);
        isMontantPayerNotEmpty.value = montantAPayer.text.isNotEmpty &&
            (double.tryParse(montantAPayer.text) ?? 0) > 0;
      });
    }
  }

  void toggleIndex(Map<String, dynamic> data) {
    if (selectedFactures.contains(data)) {
      selectedFactures.remove(data);
    } else {
      selectedFactures.add(data);
    }
  }

  void distributeAmount(double amount) {
    final factures = factureController.factureRappel['data']['detailItems'];

    if (factures == null) return;

    distributedAmounts.clear();
    double remaingAmount = amount;

    for (var i = 0; i < factures.length; i++) {
      double factureAmount = factures[i]['montant'];

      if (remaingAmount >= factureAmount) {
        distributedAmounts[i] = factureAmount;
        remaingAmount -= factureAmount;
      } else {
        distributedAmounts[i] = remaingAmount;
        remaingAmount = 0;
        break;
      }
    }

    distributedAmounts.refresh();
  }

  void paiedFactures() {
    final factures = factureController.factureRappel['data']['detailItems'];

    paidFactures.clear();

    for (var i = 0; i < factures.length; i++) {
      double distributeAmount = distributedAmounts[i] ?? 0;

      if (distributeAmount > 0) {
        paidFactures.add(
          PaidFactureModel(
            referenceFacture: factures[i]['numFacture'],
            montant: factures[i]['montant'],
            codeDevise: factures[i]['codeDevise'],
            periode: factureController.convertDate(factures[i]['periode']),
            montantPayer: distributeAmount,
          ),
        );
      }
    }
  }

  double get totalAmount {
    double total = 0;

    for (var facture in paidFactures) {
      total += double.tryParse(facture.montantPayer.toString()) ?? 0;
    }

    return total;
  }
}
