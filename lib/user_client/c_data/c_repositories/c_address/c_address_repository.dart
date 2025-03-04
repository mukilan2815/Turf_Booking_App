import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../../../c_features/c_personalization/models/c_address_model.dart';
import '../c_authentication/c_authentication_repository.dart';

class ClientAddressRepository extends GetxController{
  static ClientAddressRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;

  Future<List<ClientAddressModel>>  clientFetchUserAddress() async{
    try{
      final clientUserId = AuthenticationRepositoryClient.instance.clientAuthUser!.uid;
      if(clientUserId.isEmpty) throw "Unable to find user information. Try again in few minutes";

      final result = await _db.collection('ClientUsers').doc(clientUserId).collection('Addresses').get();
      return result.docs.map((
          documentSnapshot) => ClientAddressModel.fromDocumentSnapshot(documentSnapshot)).toList();
    } catch(e){
      throw "$e";
    }
  }

  /// clear the selected field for all address
  Future<void> updateSelectedField(String addressId,bool selected) async{
    try{
      final clientUserId = AuthenticationRepositoryClient.instance.clientAuthUser!.uid;
      await _db.collection('ClientUsers')
          .doc(clientUserId).collection("Addresses").doc(addressId).update({'SelectedAddress':selected});
    } catch (e){
      throw 'Unable to update your address selection. Try again later';
      //throw "$e";
    }
  }

  /// store new user order
  Future<String> addAddress(ClientAddressModel address) async{
    try{
      final clientUserId= AuthenticationRepositoryClient.instance.clientAuthUser!.uid;
      final currentAddress = await _db.collection('ClientUsers')
          .doc(clientUserId).collection("Addresses").add(address.toJson());

      return currentAddress.id;
    } catch (e){
      throw'Something went wrong while saving Address information. try again later';
    }
  }

}