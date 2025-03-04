import 'package:cloud_firestore/cloud_firestore.dart';

class ClientCategoryModel{

  String id;
  String name;
  String parentId;
  bool isFeatured;

  ClientCategoryModel({
    required this.id,
    required this.name,
    required this.isFeatured,
    this.parentId ='',
  });

  /// empty helper
  static ClientCategoryModel empty() => ClientCategoryModel(id: '', name: '', parentId: '', isFeatured: false);

  /// convert model to json struct so that you can store data in firebase
  Map<String, dynamic> toJson() {
    return {
      'Name':name,
      'ParentId': parentId,
      'IsFeatured':isFeatured,
    };
  }

  /// map json oriented document from firebase to user model
  factory ClientCategoryModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document){
    if (document.data() != null) {
      final data = document.data()!;

      return ClientCategoryModel(
          id: document.id,
          name: data['Name'] ?? '',
          parentId: data['ParentId'] ?? '',
          isFeatured: data['IsFeatured'] is String
              ? data['IsFeatured'] == 'true'
              : data['IsFeatured'] ?? false,
      );
    }  else{
      return ClientCategoryModel.empty();
    }
  }

}