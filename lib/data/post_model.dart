import 'package:cloud_firestore/cloud_firestore.dart';

class PostModel {
  final String title;
  final String imageUrl;
  final String id;
  final String description;
  final String price;
  final time;

  const PostModel({
    required this.title,
    required this.price,
    required this.id,
    required this.time,
    required this.imageUrl,
    required this.description,
  });

  Map<String, dynamic> toJson() => {
        "title": title,
        "id": id,
        "price": price,
        'time': time,
        "description": description,
        "imageUrl": imageUrl,
      };

  factory PostModel.fromDocSnapshot(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return PostModel(
      title: snapshot['title'],
      id: snapshot['id'],
      price: snapshot['price'],
      time: snapshot['time'],
      description: snapshot['description'],
      imageUrl: snapshot['imageUrl'],
    );
  }
}
