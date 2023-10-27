import 'package:equatable/equatable.dart';
import 'package:hive_flutter/adapters.dart';

part 'user_model.g.dart';

@HiveType(typeId: 1)
class User extends HiveObject with EquatableMixin {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String username;
  @HiveField(2)
  final String email;
  @HiveField(3)
  final String password;
  @HiveField(4)
  final String token;

    User({
    required this.id,
    required this.username,
    required this.email,
    required this.password,
    required this.token
  });

  
  @override
  // TODO: implement props
  List<Object?> get props => [id, username, email, password, token];

  User copyWith({
    String? id,
    String? username,
    String? email,
    String? password,
    String? token    
  }) {
    return User(
          id: id ?? this.id,
      username: username ?? this.username,
      email: email ?? this.email,
      password: password ?? this.password,
      token: token ?? this.token
    );
  }
}
