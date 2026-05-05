import 'package:json_annotation/json_annotation.dart';

part 'categorie.g.dart';

@JsonSerializable()
class Categorie {
  const Categorie({
    required this.id,
    required this.reference,
    required this.designation,
    required this.tags,
  });

  @JsonKey(name: '_id')
  final String id;
  final String reference;
  final String designation;
  final List<String> tags;

  factory Categorie.fromJson(Map<String, dynamic> json) =>
      _$CategorieFromJson(json);

  Map<String, dynamic> toJson() => _$CategorieToJson(this);
}
