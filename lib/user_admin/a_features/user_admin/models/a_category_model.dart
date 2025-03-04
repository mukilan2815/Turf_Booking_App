import 'package:cloud_firestore/cloud_firestore.dart';

class AdminCategoryModel{

  String id;
  String name;
  String parentId;
  bool isFeatured;

  AdminCategoryModel({
    required this.id,
    required this.name,
    required this.isFeatured,
    this.parentId ='',
  });

  /// empty helper
  static AdminCategoryModel empty() => AdminCategoryModel(id: '', name: '', parentId: '', isFeatured: false);

  /// convert model to json struct so that you can store data in firebase
  Map<String, dynamic> toJson() {
    return {
      'Name':name,
      'ParentId': parentId,
      'IsFeatured':isFeatured,
    };
  }

  /// map json oriented document from firebase to user model
  factory AdminCategoryModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document){
    if (document.data() != null) {
      final data = document.data()!;

      return AdminCategoryModel(
        id: document.id,
        name: data['Name'] ?? '',
        parentId: data['ParentId'] ?? '',
        isFeatured: data['IsFeatured'] is String
            ? data['IsFeatured'] == 'true'
            : data['IsFeatured'] ?? false,
      );
    }  else{
      return AdminCategoryModel.empty();
    }
  }

}