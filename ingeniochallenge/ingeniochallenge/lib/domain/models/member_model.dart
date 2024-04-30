import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

List<Member> memberFromJson(String str) =>
    List<Member>.from(json.decode(str).map((x) => Member.fromJson(x)));

String memberToJson(List<Member> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

@freezed
class Member {
  String avatar;
  String bio;
  String firstName;
  String id;
  String lastName;
  String title;

  Member({
    required this.avatar,
    required this.bio,
    required this.firstName,
    required this.id,
    required this.lastName,
    required this.title,
  });

  Member copyWith({
    String? avatar,
    String? bio,
    String? firstName,
    String? id,
    String? lastName,
    String? title,
  }) =>
      Member(
        avatar: avatar ?? this.avatar,
        bio: bio ?? this.bio,
        firstName: firstName ?? this.firstName,
        id: id ?? this.id,
        lastName: lastName ?? this.lastName,
        title: title ?? this.title,
      );

  factory Member.fromJson(Map<String, dynamic> json) => Member(
        avatar: json["avatar"],
        bio: json["bio"],
        firstName: json["firstName"],
        id: json["id"],
        lastName: json["lastName"],
        title: json["title"],
      );

  Map<String, dynamic> toJson() => {
        "avatar": avatar,
        "bio": bio,
        "firstName": firstName,
        "id": id,
        "lastName": lastName,
        "title": title,
      };

  String getCompleteName() {
    return "$firstName,  $lastName";
  }
}
