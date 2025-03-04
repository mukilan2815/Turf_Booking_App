import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../utils/formatters/formatter.dart';

class ClientAddressModel{
  String id;
  final String name;
  final String phoneNumber;
  final String street;
  final String city;
  final String state;
  final String postalCode;
  final String country;
  final DateTime? dateTime;
  bool selectedAddress;

  ClientAddressModel({
    required this.id,
    required this.name,
    required this.phoneNumber,
    required this.street,
    required this.city,
    required this.state,
    required this.postalCode,
    required this.country,
    this.dateTime,
    this.selectedAddress = true,
  });

  String get formattedPhoneNo => KFormatter.formatPhoneNumber(phoneNumber);

   static ClientAddressModel empty() => ClientAddressModel(id: '', name: '', phoneNumber: '', street: '', city: '', state: '', postalCode: '', country: '');

   Map<String, dynamic> toJson(){
     return{
       "Id": id,
       "Name" : name,
       "PhoneNumber" : phoneNumber,
       "Street" : street,
       "City" : city,
       "State" : state,
       "PostalCode" : postalCode,
       "Country" : country,
       "DateTime" : DateTime.now(),
       "SelectedAddress" : selectedAddress,
     };
   }

   factory ClientAddressModel.fromMap(Map<String, dynamic> data) {
     return ClientAddressModel(
         id: data['Id'] as String,
         name: data['Name'] as String,
         phoneNumber: data['PhoneNumber'] as String,
         street: data['Street'] as String,
         city: data['City'] as String,
         state: data['State'] as String,
         postalCode: data['PostalCode'] as String,
         country: data['Country'] as String,
         selectedAddress: data['SelectedAddress'] as bool,
         dateTime: (data ['DateTime'] as Timestamp).toDate(),
     );
   }

   factory ClientAddressModel.fromDocumentSnapshot(DocumentSnapshot<Map<String, dynamic>> document){
     if (document.data() != null ){
     final data = document.data()!;
     return ClientAddressModel(
       id: document.id,
       name: data['Name'] ?? '',
       phoneNumber: data['PhoneNumber'] ?? '',
       street: data['Street'] ?? '',
       city: data['City']  ?? '',
       state: data['State']  ?? '',
       postalCode: data['PostalCode']  ?? '',
       country: data['Country']  ?? '',
       selectedAddress: data['SelectedAddress'] as bool,
       dateTime: (data ['DateTime'] as Timestamp).toDate(),
     );
     }
     return ClientAddressModel.empty();
   }

   @override
   String toString() {
     return '$street,$city,$state,$postalCode,$country';
   }

}