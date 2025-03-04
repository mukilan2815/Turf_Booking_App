import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../../utils/formatters/formatter.dart';

class AdminUserModel{
  final String id;
  final String username;
  final String email;
  String phoneNumber;

  AdminUserModel({
    required this.id,
    required this.username,
    required this.email,
    required this.phoneNumber,
  });

  /// phone number
  String get formattedPhoneNo => KFormatter.formatPhoneNumber(phoneNumber);

  static List<String> nameParts(fullName) => fullName.split(" ");

  static String generateUserName(fullName){
    List<String> nameParts = fullName.split(" ");
    String firstName = nameParts[0].toLowerCase();
    String lastName = nameParts.length > 1 ? nameParts[1].toLowerCase() : "";

    String camelCaseUsername="$firstName$lastName";
    String usernameWithPrefix = "cwt_$camelCaseUsername";
    return usernameWithPrefix;
  }

  /// empty
  static AdminUserModel empty() => AdminUserModel(id: '', username: '', email: '', phoneNumber: '');

  /// tojson
  Map<String, dynamic> toJson(){
    return{
      'UserName':username,
      'Email':email,
      'PhoneNumber':phoneNumber,
    };
  }

  /// firebase document snapshot
  factory AdminUserModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document){
    if (document.data() != null ) {
      final data = document.data()!;
      return AdminUserModel(
        id: document.id,
        username: data['UserName'] ?? '',
        email: data['Email'] ?? '',
        phoneNumber: data['PhoneNumber'] ?? '',
      );
    }
    return AdminUserModel.empty();
  }

}