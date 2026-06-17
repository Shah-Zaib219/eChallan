import 'package:cloud_firestore/cloud_firestore.dart';

class WardenModel {
  final String firstName;
  final String lastName;
  final String id;

  WardenModel(
      {required this.firstName, required this.lastName, required this.id});

  factory WardenModel.fromDocumentSnapshot(DocumentSnapshot doc) {
    return WardenModel(
      firstName: doc['first_name'],
      lastName: doc['last_name'],
      id: doc['id'],
    );
  }
}
