import 'package:electrokimo/size_config.dart';
import 'package:flutter/material.dart';

class SingleFacture extends StatelessWidget {
  const SingleFacture({
    super.key,
    required this.referenceFacture,
    required this.prix,
    required this.periode,
    required this.montantPaye,
  });

  final String referenceFacture, prix, periode;
  final String montantPaye;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        height: getProportionateScreenHeight(105),
        margin: EdgeInsets.only(bottom: getProportionateScreenWidth(10)),
        padding: EdgeInsets.all(getProportionateScreenWidth(16)),
        decoration: BoxDecoration(
          border: Border.all(
              width: getProportionateScreenWidth(1),
              color: Colors.grey.withOpacity(0.2)),
          borderRadius: BorderRadius.circular(10),
          color: Colors.grey.withOpacity(0.2),
        ),
        child: Stack(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(referenceFacture),
                    Text(periode),
                    Text(
                      prix,
                      style: Theme.of(context).textTheme.labelLarge!.apply(
                            color: Colors.blue[800],
                          ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    SizedBox(height: getProportionateScreenHeight(20)),
                    Text(
                      "Montant payé",
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    Text(
                      "\$ $montantPaye",
                      style: Theme.of(context)
                          .textTheme
                          .labelLarge!
                          .apply(color: Colors.red),
                    ),
                  ],
                )
              ],
            )
          ],
        ));
  }
}
