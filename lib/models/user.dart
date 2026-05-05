import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable(explicitToJson: true)
class User {
  const User({
    required this.id,
    required this.matricule,
    required this.mail,
    required this.credits,
    required this.recharges,
    required this.metrics,
  });

  @JsonKey(name: '_id')
  final String id;
  final String matricule;
  final String mail;
  final int credits;
  final List<Recharge> recharges;
  final Metrics metrics;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);

  User copyWith({
    String? id,
    String? matricule,
    String? mail,
    int? credits,
    List<Recharge>? recharges,
    Metrics? metrics,
  }) {
    return User(
      id: id ?? this.id,
      matricule: matricule ?? this.matricule,
      mail: mail ?? this.mail,
      credits: credits ?? this.credits,
      recharges: recharges ?? this.recharges,
      metrics: metrics ?? this.metrics,
    );
  }
}

@JsonSerializable()
class Recharge {
  const Recharge({
    required this.id,
    required this.status,
    required this.credits,
    required this.orderNumber,
    required this.createdAt,
    required this.updatedAt,
  });

  @JsonKey(name: '_id')
  final String id;

  /// API : `'pending' | 'paid' | 'failed' | 'completed'`
  final String status;
  final int credits;
  final String orderNumber;

  /// Source JSON : clé `ceatedAt` (typo API).
  @JsonKey(name: 'ceatedAt')
  final DateTime createdAt;
  final DateTime updatedAt;

  factory Recharge.fromJson(Map<String, dynamic> json) =>
      _$RechargeFromJson(json);

  Map<String, dynamic> toJson() => _$RechargeToJson(this);
}

@JsonSerializable()
class Metrics {
  const Metrics({
    required this.categories,
    required this.documents,
    required this.pages,
  });

  final int categories;
  final int documents;
  final int pages;

  factory Metrics.fromJson(Map<String, dynamic> json) =>
      _$MetricsFromJson(json);

  Map<String, dynamic> toJson() => _$MetricsToJson(this);
}
