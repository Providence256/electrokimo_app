// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ReclamationModel {
  final String dateSaisieRecl;
  final String docReference;
  final String motif;
  final int raccordementId;
  final String file;

  ReclamationModel({
    required this.dateSaisieRecl,
    required this.docReference,
    required this.motif,
    required this.raccordementId,
    required this.file,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'dateSaisieRecl': dateSaisieRecl,
      'docReference': docReference,
      'motif': motif,
      'raccordementId': raccordementId,
      'file': file,
    };
  }

  factory ReclamationModel.fromMap(Map<String, dynamic> map) {
    return ReclamationModel(
      dateSaisieRecl: map['dateSaisieRecl'] as String,
      docReference: map['docReference'] as String,
      motif: map['motif'] as String,
      raccordementId: map['raccordementId'] as int,
      file: map['file'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ReclamationModel.fromJson(String source) =>
      ReclamationModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
