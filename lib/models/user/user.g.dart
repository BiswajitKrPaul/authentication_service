// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    disallowNullValues: const ['id'],
  );
  return User(
    json['id'] as String,
    json['firstname'] as String,
    json['middlename'] as String?,
    json['lastname'] as String,
    json['mobile'] as String,
    json['email'] as String?,
  );
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'firstname': instance.firstname,
      'middlename': instance.middlename,
      'lastname': instance.lastname,
      'mobile': instance.mobile,
      'email': instance.email,
    };
