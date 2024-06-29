class PaidFactureModel {
  final String referenceFacture;
  final double montant;
  final String codeDevise;
  final String periode;
  final double montantPayer;

  PaidFactureModel({
    required this.referenceFacture,
    required this.montant,
    required this.codeDevise,
    required this.periode,
    required this.montantPayer,
  });
}
