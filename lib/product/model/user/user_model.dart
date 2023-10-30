import 'package:json_annotation/json_annotation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';
import 'package:hive_flutter/adapters.dart';
part 'user_model.g.dart';

@HiveType(typeId: 1)


@JsonSerializable()
class UserModel extends HiveObject with EquatableMixin {
  @JsonKey(name: "user_name")
  @HiveField(0)
  final String? userName;
  @HiveField(1)
  final String? email;
  @HiveField(2)
  final String? password;
  @HiveField(3)
  final String? token;
  @HiveField(4)
  final String? uid;
  @JsonKey(name: "profile_photo_url")
  @HiveField(5)
  final String? profilePhotoUrl;
        UserModel({
    this.userName,
    this.email,
    this.password,
    this.token,
    this.uid,
    this.profilePhotoUrl
  });



  
  @override
  // TODO: implement props
  List<Object?> get props => [userName, email, password, token, uid, profilePhotoUrl];



    UserModel copyWith({
    String? id,
    String? userName,
    String? email,
    String? password,
    String? token,
    String? uid,
    String? profilePhotoUrl    
  }) {
    return UserModel(
      userName: userName ?? this.userName,
      email: email ?? this.email,
      password: password ?? this.password,
      token: token ?? this.token,
      uid: uid ?? this.uid,
      profilePhotoUrl: profilePhotoUrl ?? this.profilePhotoUrl
    );
  }



@override
String toString() {
    return 'UserModel{userName=$userName, email=$email, password=$password, token=$token, uid=$uid, profilePhotoUrl=$profilePhotoUrl}';
  }
  Map<String, dynamic> toJson() => _$UserModelToJson(this);

  factory UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);
}
