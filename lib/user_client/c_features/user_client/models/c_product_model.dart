import 'package:cloud_firestore/cloud_firestore.dart';

class ClientProductModel {

  String id;
  int players;
  double price;
  String title;
  DateTime? date;
  String thumbnail;
  bool? isFeatured;
  String? address;
  String? categoryId;
  String? adminId;

  ClientProductModel({
    required this.id,
    required this.players,
    required this.title,
    required this.price,
    required this.thumbnail,
    this.categoryId,
    this.isFeatured,
    this.date,
    this.address,
    this.adminId
  });

  /// create empty
  static ClientProductModel empty() => ClientProductModel(id: '', title: '', price: 0.0, thumbnail: '', players: 0);

  /// json format
  toJson(){
    return{
      'Title':title,
      'Price':price,
      'Thumbnail':thumbnail,
      'CategoryId':categoryId,
      'IsFeatured':isFeatured,
      'Address':address,
      'AdminId':adminId,
      'Players':players,
    };
  }

  ///
  factory ClientProductModel.fromSnapshot(DocumentSnapshot<Map<String,dynamic>> document){

    if (document.data() == null) return ClientProductModel.empty();
    final data = document.data()!;

    return ClientProductModel(
      id: document.id,
      title: data['Title'] ?? '',
      price: double.parse((data['Price'] ?? 0.0).toString()),
      thumbnail: data['Thumbnail'] ?? '',
      isFeatured: data['IsFeatured'] ?? false,
      address: data['Address'] ?? '',
      categoryId: data['CategoryId'] ?? '',
      adminId: data['AdminId'] ?? '',
      players: data['Players'] ?? '',
    );
  }

  factory ClientProductModel.fromQuerySnapshot(QueryDocumentSnapshot<Object?> document){
    final data = document.data() as Map<String, dynamic>;

    return ClientProductModel(
      id: document.id,
      title: data['Title'] ?? '',
      price: double.parse((data['Price'] ?? 0.0).toString()),
      thumbnail: data['Thumbnail'] ?? '',
      isFeatured: data['IsFeatured'] ?? false,
      address: data['Address'] ?? '',
      categoryId: data['Category'] ?? '',
      adminId: data['AdminId'] ?? '',
      players: data['Players'] ?? '',
    );
  }

  factory ClientProductModel.fromMap(Map<String,dynamic> data){
    return ClientProductModel(
      id: data['Id'] ?? '',
      title: data['Title'] ?? '',
      price: double.parse((data['Price'] ?? 0.0).toString()),
      thumbnail: data['Thumbnail'] ?? '',
      isFeatured: data['IsFeatured'] ?? false,
      address: data['Address'] ?? '',
      categoryId: data['Category'] ?? '',
      adminId: data['AdminId'] ?? '',
      players: data['Players'] ?? '',
    );

  }

}