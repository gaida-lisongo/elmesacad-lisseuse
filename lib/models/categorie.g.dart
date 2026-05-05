part of 'categorie.dart';

Categorie _$CategorieFromJson(Map<String, dynamic> json) => Categorie(
      id: json['_id'] as String,
      reference: json['reference'] as String,
      designation: json['designation'] as String,
      tags:
          (json['tags'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$CategorieToJson(Categorie instance) => <String, dynamic>{
      '_id': instance.id,
      'reference': instance.reference,
      'designation': instance.designation,
      'tags': instance.tags,
    };
