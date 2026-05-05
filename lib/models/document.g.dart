part of 'document.dart';

Document _$DocumentFromJson(Map<String, dynamic> json) => Document(
      id: json['_id'] as String,
      reference: json['reference'] as String,
      author: Author.fromJson(json['author'] as Map<String, dynamic>),
      userId: json['userId'] as String,
      totalPages: (json['total_pages'] as num).toInt(),
      title: json['title'] as String,
      description: (json['description'] as List<dynamic>)
          .map((e) => DocDescriptionBlock.fromJson(e as Map<String, dynamic>))
          .toList(),
      pages: (json['pages'] as List<dynamic>)
          .map((e) => DocumentPage.fromJson(e as Map<String, dynamic>))
          .toList(),
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      categorieId: json['categorieId'] as String?,
    );

Map<String, dynamic> _$DocumentToJson(Document instance) => <String, dynamic>{
      '_id': instance.id,
      'reference': instance.reference,
      'author': instance.author.toJson(),
      'userId': instance.userId,
      'total_pages': instance.totalPages,
      'title': instance.title,
      'description': instance.description.map((e) => e.toJson()).toList(),
      'pages': instance.pages.map((e) => e.toJson()).toList(),
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      if (instance.categorieId != null) 'categorieId': instance.categorieId,
    };

Author _$AuthorFromJson(Map<String, dynamic> json) => Author(
      name: json['name'] as String,
      photo: json['photo'] as String?,
      email: json['email'] as String,
      description: (json['descriontion'] as List<dynamic>)
          .map((e) => AuthorBioSection.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AuthorToJson(Author instance) => <String, dynamic>{
      'name': instance.name,
      if (instance.photo != null) 'photo': instance.photo,
      'email': instance.email,
      'descriontion': instance.description.map((e) => e.toJson()).toList(),
    };

AuthorBioSection _$AuthorBioSectionFromJson(Map<String, dynamic> json) =>
    AuthorBioSection(
      title: json['title'] as String,
      content:
          (json['content'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$AuthorBioSectionToJson(AuthorBioSection instance) =>
    <String, dynamic>{
      'title': instance.title,
      'content': instance.content,
    };

DocDescriptionBlock _$DocDescriptionBlockFromJson(Map<String, dynamic> json) =>
    DocDescriptionBlock(
      title: json['title'] as String,
      content:
          (json['content'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$DocDescriptionBlockToJson(DocDescriptionBlock instance) =>
    <String, dynamic>{
      'title': instance.title,
      'content': instance.content,
    };

DocumentPage _$DocumentPageFromJson(Map<String, dynamic> json) =>
    DocumentPage(
      url: json['url'] as String,
      comment: json['comment'] as String,
      index: (json['index'] as num).toInt(),
      isRead: json['isRead'] as bool,
    );

Map<String, dynamic> _$DocumentPageToJson(DocumentPage instance) =>
    <String, dynamic>{
      'url': instance.url,
      'comment': instance.comment,
      'index': instance.index,
      'isRead': instance.isRead,
    };
