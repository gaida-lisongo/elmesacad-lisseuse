// ignore_for_file: implicit_dynamic_parameter

part of 'user.dart';

User _$UserFromJson(Map<String, dynamic> json) => User(
      id: json['_id'] as String,
      matricule: json['matricule'] as String,
      mail: json['mail'] as String,
      credits: (json['credits'] as num).toDouble(),
      recharges: (json['recharges'] as List<dynamic>)
          .map((e) => Recharge.fromJson(e as Map<String, dynamic>))
          .toList(),
      metrics: Metrics.fromJson(json['metrics'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      '_id': instance.id,
      'matricule': instance.matricule,
      'mail': instance.mail,
      'credits': instance.credits,
      'recharges': instance.recharges.map((e) => e.toJson()).toList(),
      'metrics': instance.metrics.toJson(),
    };

Recharge _$RechargeFromJson(Map<String, dynamic> json) => Recharge(
      id: json['_id'] as String,
      status: json['status'] as String,
      credits: (json['credits'] as num).toInt(),
      orderNumber: json['orderNumber'] as String,
      createdAt: DateTime.parse(json['ceatedAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$RechargeToJson(Recharge instance) => <String, dynamic>{
      '_id': instance.id,
      'status': instance.status,
      'credits': instance.credits,
      'orderNumber': instance.orderNumber,
      'ceatedAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
    };

Metrics _$MetricsFromJson(Map<String, dynamic> json) => Metrics(
      categories: (json['categories'] as num).toInt(),
      documents: (json['documents'] as num).toInt(),
      pages: (json['pages'] as num).toInt(),
    );

Map<String, dynamic> _$MetricsToJson(Metrics instance) => <String, dynamic>{
      'categories': instance.categories,
      'documents': instance.documents,
      'pages': instance.pages,
    };
