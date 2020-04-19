import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String documentUid;
  final String name;
  final String mail;
  final String photoUrl;
  final bool useFingerprint;

  const UserEntity(this.name, this.mail, this.photoUrl, this.useFingerprint,
      this.documentUid);

  Map<String, Object> toJson() {
    return {
      "name": name,
      "mail": mail,
      "photoUrl": photoUrl,
      "useFingerprint": useFingerprint,
      "documentUid": documentUid,
    };
  }

  @override
  List<Object> get props => [name, mail, photoUrl, useFingerprint, documentUid];

  @override
  String toString() {
    return 'UserEntity { name: $name, mail: $mail, photoUrl: $photoUrl, useFingerprint: $useFingerprint, documentUid: $documentUid }';
  }

  static UserEntity fromJson(Map<String, Object> json) {
    return UserEntity(
      json["name"] as String,
      json["mail"] as String,
      json["photoUrl"] as String,
      json["useFingerprint"] as bool,
      json["documentUid"] as String,
    );
  }

  static UserEntity fromSnapshot(DocumentSnapshot snap) {
    return UserEntity(
      snap.data['name'],
      snap.data['mail'],
      snap.data['photoUrl'],
      snap.data['useFingerprint'],
      snap.documentID,
    );
  }

  Map<String, Object> toDocument() {
    return {
      "name": name,
      "mail": mail,
      "photoUrl": photoUrl,
      "useFingerprint": useFingerprint,
      "documentUid": documentUid,
    };
  }
}
