import 'package:cloud_firestore/cloud_firestore.dart';

class NewTermModel {
  String? term;
  String? definition;

  NewTermModel({this.term, this.definition});

  Map<String, dynamic> toJson() {
    return {
      'term': term,
      'definition': definition,
    };
  }

  factory NewTermModel.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options,
      ) {
    final data = snapshot.data();
    return NewTermModel(
      term: data?['term'],
      definition: data?['definition'],
    );
  }
}