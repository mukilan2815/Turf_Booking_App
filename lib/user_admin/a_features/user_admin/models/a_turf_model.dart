import 'package:cloud_firestore/cloud_firestore.dart';

class AdminTurfModel {

  String id;
  int players;
  String address;
  double price;
  String title;
  DateTime? date;
  String thumbnail;
  bool? isFeatured;
  String categoryId;
  String adminId;

  AdminTurfModel({
    required this.id,
    required this.players,
    required this.title,
    required this.address,
    required this.price,
    required this.thumbnail,
    required this.adminId,
    required this.categoryId,
    this.isFeatured,
    this.date,
  });

  /// create empty
  static AdminTurfModel empty() => AdminTurfModel(id: '', title: '', address: '', price: 0.0, thumbnail: '', adminId: '', categoryId: '', players: 0,);

  /// json format
  toJson(){
    return{
      'Title':title,
      'Address':address,
      'Price':price,
      'Thumbnail':thumbnail,
      'CategoryId':categoryId,
      'IsFeatured':isFeatured,
      'AdminId':adminId,
      'Players':players,
    };
  }

  ///
  factory AdminTurfModel.fromSnapshot(DocumentSnapshot<Map<String,dynamic>> document){

    if (document.data() == null) return AdminTurfModel.empty();
    final data = document.data()!;

    return AdminTurfModel(
      id: document.id,
      title: data['Title'] ?? '',
      address: data['Address'] ?? '',
      price: double.parse((data['Price'] ?? 0.0).toString()),
      thumbnail: data['Thumbnail'] ?? '',
      isFeatured: data['IsFeatured'] ?? false,
      categoryId: data['CategoryId'] ?? '',
      adminId: data['AdminId'] ?? '',
      players: data['Players'] ?? '',
    );
  }

  factory AdminTurfModel.fromQuerySnapshot(QueryDocumentSnapshot<Object?> document){
    final data = document.data() as Map<String, dynamic>;

    return AdminTurfModel(
      id: document.id,
      title: data['Title'] ?? '',
      address: data['Address'] ?? '',
      price: double.parse((data['Price'] ?? 0.0).toString()),
      thumbnail: data['Thumbnail'] ?? '',
      isFeatured: data['IsFeatured'] is String
          ? data['IsFeatured'] == 'true'
          : data['IsFeatured'] ?? false,
      categoryId: data['Category'] ?? '',
      adminId: data['AdminId'] ?? '',
      players: data['Players'] ?? '',
    );
  }

}