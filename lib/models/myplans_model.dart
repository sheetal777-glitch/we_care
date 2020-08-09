import 'package:cloud_firestore/cloud_firestore.dart';

class MyPlansModel {
  final String title, description;
  final Timestamp createdAt;

  MyPlansModel({this.title, this.description, this.createdAt});

  factory MyPlansModel.fromDocuments(DocumentSnapshot doc) {
    return MyPlansModel(
        title: doc['title'],
        description: doc['description'],
        createdAt: doc['createdAt']);
  }
}
