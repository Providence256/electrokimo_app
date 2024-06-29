import 'package:electrokimo/common/widgets/app_bar.dart';
import 'package:electrokimo/features/home/controller/reclamation_controller.dart';
import 'package:electrokimo/features/home/screen/reclamation.dart';
import 'package:electrokimo/size_config.dart';
import 'package:electrokimo/utils/formatters/formatters.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class ListeReclamation extends StatelessWidget {
  const ListeReclamation({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ReclamationController());

    return Scaffold(
      appBar: TAppBar(
        title: Text(
          "Liste des réclamations",
          style: Theme.of(context)
              .textTheme
              .headlineSmall!
              .apply(color: Colors.white),
        ),
        showbackArrow: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              Obx(() {
                final reclamations = controller.reclamations['data'];
                return reclamations == null
                    ? const Center(
                        child: Padding(
                        padding: EdgeInsets.only(top: 8.0),
                        child: CircularProgressIndicator(),
                      ))
                    : ListView.builder(
                        shrinkWrap: true,
                        itemCount: reclamations.length,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (_, index) => Column(
                          children: [
                            ListTile(
                              leading: const Icon(
                                Icons.edit_document,
                                color: Colors.blue,
                              ),
                              title: Text(
                                reclamations[index]['docReference'],
                              ),
                              subtitle: Text(
                                reclamations[index]['motif'],
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              trailing: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(reclamations[index]['dateSaisieRecl']),
                                  Container(
                                    height: getProportionateScreenHeight(18),
                                    width: getProportionateScreenWidth(77),
                                    decoration: BoxDecoration(
                                      color: reclamations[index]['etatRecl']
                                          ? Colors.green[300]
                                          : Colors.red,
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: Center(
                                      child: Text(
                                        Formatter.reclamationStatus(
                                            reclamations[index]['etatRecl']),
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelSmall!
                                            .apply(color: Colors.white),
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
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.blue[800],
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
        onPressed: () => Get.to(() => const ReclamationScreen()),
        label: Text("Ajouter réclamation",
            style: Theme.of(context)
                .textTheme
                .labelLarge!
                .apply(color: Colors.white)),
        icon: const Icon(
          Iconsax.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
