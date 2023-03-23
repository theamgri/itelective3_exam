import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:maghari_flutter/homepage.dart';

class Item {
  final String id;
  final String name;
  final String description;
  //final String img;
  //final String itemId;
  final String task;

  Item({
    this.id = "",
    this.name = "",
    this.description = "",
    //this.img = "",
    this.task = "",
    //this.itemId = "",
  });

  factory Item.fromSnapshot(DocumentSnapshot snapshot) {
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
    return Item(
      id: snapshot.id,
      name: data['name'] ?? '',
      description: data['description'] ?? '',
      task: data['task'] ?? '',
    );
  }
}
