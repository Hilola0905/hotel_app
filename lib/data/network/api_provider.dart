import 'package:hotel_app/data/local/storage_repository.dart';

import '../model/response/network_response.dart';

class ApiProvider {

  static getHeader([String? contentType]) => {
    "Authorization":"Bear ${StorageRepository.getString(key: "token")}",
     "Content-Type":"application/json",
  };
  static Future<NetworkResponse> login() async {

}
}