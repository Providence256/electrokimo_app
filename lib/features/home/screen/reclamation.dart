import 'package:electrokimo/common/widgets/app_bar.dart';
import 'package:electrokimo/features/home/controller/reclamation_controller.dart';
import 'package:electrokimo/utils/validators/validators.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class ReclamationScreen extends StatelessWidget {
  const ReclamationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ReclamationController());
    return Scaffold(
      appBar: TAppBar(
        showbackArrow: true,
        title: Text(
          "Enregistrer votre Réclamation",
          style: Theme.of(context)
              .textTheme
              .headlineSmall!
              .apply(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: controller.reclamatonFormKey,
            child: Column(
              children: [
                const SizedBox(height: 20),
                TextFormField(
                  controller: controller.dateController,
                  validator: (value) =>
                      TValidators.validateInput("Date", value),
                  decoration: const InputDecoration(
                    prefixIcon: Icon(
                      Iconsax.calendar,
                      color: Colors.blue,
                    ),
                    labelText: "Selectionner date",
                  ),
                  onTap: () => controller.selectDate(context),
                ),
                const SizedBox(height: 15),
                TextFormField(
                  controller: controller.numDocumentController,
                  validator: (value) =>
                      TValidators.validateInput("Numero Document", value),
                  decoration: const InputDecoration(
                    prefixIcon: Icon(
                      Iconsax.receipt,
                      color: Colors.blue,
                    ),
                    labelText: "Numero Document",
                  ),
                ),
                const SizedBox(height: 15),
                TextFormField(
                  maxLines: 3,
                  controller: controller.motifController,
                  validator: (value) =>
                      TValidators.validateInput("Motif", value),
                  decoration: const InputDecoration(
                    prefixIcon: Icon(
                      Iconsax.document,
                      color: Colors.blue,
                    ),
                    labelText: "Motif de la réclamation",
                  ),
                ),
                const SizedBox(height: 15),
                TextFormField(
                  controller: controller.fileController,
                  validator: (value) =>
                      TValidators.validateInput("Fichier", value),
                  readOnly: true,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Iconsax.attach_circle),
                    suffixIcon: IconButton(
                      icon: const Icon(Iconsax.document_upload),
                      color: Colors.blue,
                      onPressed: () async {
                        await controller.pickFile();
                      },
                    ),
                    labelText: "Importer votre fichier",
                  ),
                ),
                const SizedBox(height: 15),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => controller.sendReclamation(),
                    child: const Text("Envoyer"),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
