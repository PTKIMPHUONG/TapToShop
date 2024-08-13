import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  final String userId;
  final String username;
  final String gender;
  final String email;
  final String password;
  final String phoneNumber;

  User({
    required this.userId,
    required this.username,
    required this.gender,
    required this.email,
    required this.password,
    required this.phoneNumber,
  });
  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}
