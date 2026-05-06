import 'package:json_annotation/json_annotation.dart';

import 'document.dart';

part 'categorie.g.dart';

@JsonSerializable(explicitToJson: true)
class Categorie {
  const Categorie({
    required this.id,
    required this.reference,
    required this.designation,
    required this.tags,
    required this.documents,
  });

  @JsonKey(name: '_id')
  final String id;
  final String reference;
  final String designation;
  final List<String> tags;
  final List<Document> documents;

  factory Categorie.fromJson(Map<String, dynamic> json) =>
      _$CategorieFromJson(json);

  Map<String, dynamic> toJson() => _$CategorieToJson(this);
}
