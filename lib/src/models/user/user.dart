import 'package:eighttime/src/entities/user_entity.dart';
import 'package:flutter/material.dart';

@immutable
class User {
  final String documentUid;
  final String name;
  final String mail;
  final String photoUrl;
  final bool useFingerprint;

  User(this.name, this.mail, this.photoUrl,
      {this.useFingerprint, this.documentUid});

  User copyWith(
      {String name, String mail, String photoUrl, bool useFingerprint, String documentUid}) {
    return User(
      name ?? this.name,
      mail ?? this.mail,
      photoUrl ?? this.photoUrl,
      useFingerprint: useFingerprint ?? this.useFingerprint,
      documentUid: documentUid ?? this.documentUid,
    );
  }

  @override
  int get hashCode =>
      name.hashCode ^ mail.hashCode ^ photoUrl.hashCode ^ useFingerprint
          .hashCode ^ documentUid.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is User &&
              runtimeType == other.runtimeType &&
              name == other.name &&
              mail == other.mail &&
              photoUrl == other.photoUrl &&
              useFingerprint == other.useFingerprint &&
              documentUid == other.documentUid;

  @override
  String toString() {
    return 'User { name: $name, mail: $mail, photoUrl: $photoUrl, useFingerprint: $useFingerprint, documentUid: $documentUid }';
  }

  UserEntity toEntity() {
    return UserEntity(name, mail, photoUrl, useFingerprint, documentUid);
  }

  static User fromEntity(UserEntity entity) {
    return User(
      entity.name,
      entity.mail,
      entity.photoUrl,
      useFingerprint: entity.useFingerprint,
      documentUid: entity.documentUid,
    );
  }
}
