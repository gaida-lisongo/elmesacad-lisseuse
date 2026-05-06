import 'package:json_annotation/json_annotation.dart';

part 'document.g.dart';

/// Document commandé : pages servies en URLs d'images.
@JsonSerializable(explicitToJson: true)
class Document {
  const Document({
    required this.id,
    required this.reference,
    required this.author,
    required this.userId,
    required this.totalPages,
    required this.title,
    required this.description,
    required this.pages,
    required this.createdAt,
    required this.updatedAt,
    this.categorieId,
  });

  @JsonKey(name: '_id')
  final String id;
  final String reference;
  final Author author;
  final String userId;

  @JsonKey(name: 'total_pages')
  final int totalPages;
  final String title;
  final List<DocDescriptionBlock> description;
  final List<DocumentPage> pages;
  final DateTime createdAt;
  final DateTime updatedAt;

  /// Présent côté app / mock pour grouper en bibliothèque.
  /// Le backend renvoie le champ "categorie" (référence string).
  @JsonKey(name: 'categorie')
  final String? categorieId;

  factory Document.fromJson(Map<String, dynamic> json) =>
      _$DocumentFromJson(json);

  Map<String, dynamic> toJson() => _$DocumentToJson(this);

  List<DocumentPage> get pagesSorted =>
      List<DocumentPage>.from(pages)..sort((a, b) => a.index.compareTo(b.index));

  int get readPagesCount => pages.where((page) => page.isRead).length;

  int get unreadPagesCount => pages.length - readPagesCount;
}

@JsonSerializable(explicitToJson: true)
class Author {
  const Author({
    required this.name,
    this.photo,
    required this.email,
    required this.description,
  });

  final String name;
  final String? photo;
  final String email;

  /// Source JSON : clé `descriontion` (typo API).
  @JsonKey(name: 'descriontion')
  final List<AuthorBioSection> description;

  factory Author.fromJson(Map<String, dynamic> json) => _$AuthorFromJson(json);

  Map<String, dynamic> toJson() => _$AuthorToJson(this);
}

@JsonSerializable()
class AuthorBioSection {
  const AuthorBioSection({
    required this.title,
    required this.content,
  });

  final String title;
  final List<String> content;

  factory AuthorBioSection.fromJson(Map<String, dynamic> json) =>
      _$AuthorBioSectionFromJson(json);

  Map<String, dynamic> toJson() => _$AuthorBioSectionToJson(this);
}

@JsonSerializable()
class DocDescriptionBlock {
  const DocDescriptionBlock({
    required this.title,
    required this.content,
  });

  final String title;
  final List<String> content;

  factory DocDescriptionBlock.fromJson(Map<String, dynamic> json) =>
      _$DocDescriptionBlockFromJson(json);

  Map<String, dynamic> toJson() => _$DocDescriptionBlockToJson(this);
}

@JsonSerializable()
class DocumentPage {
  const DocumentPage({
    required this.url,
    required this.comment,
    required this.index,
    required this.isRead,
  });

  final String url;
  final String comment;
  final int index;
  final bool isRead;

  factory DocumentPage.fromJson(Map<String, dynamic> json) =>
      _$DocumentPageFromJson(json);

  Map<String, dynamic> toJson() => _$DocumentPageToJson(this);
}
