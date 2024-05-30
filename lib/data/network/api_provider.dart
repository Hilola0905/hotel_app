import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:hotel_app/data/local/storage_repository.dart';
import 'package:hotel_app/utils/contacts/app_contacts.dart';
import 'package:http/http.dart' as http;
import '../model/response/network_response.dart';



class ApiProvider {
  static getHeader([String? contentType]) => {
    "Authorization":"Bearer ${StorageRepository.getString(key: "access_token")}",
     "Content-Type":"application/json",
  };
  static Future<NetworkResponse> login({
    required String email,
    required String password,
}) async {
      try{
        final Map<String, String> queryParams = {
          'email': email,
          'password': password,
        };
        Uri uri=Uri.http(AppConstants.baseUrl,"/v1/users/login",).replace(queryParameters: queryParams);
        debugPrint(uri.toString());
       http.Response response= await http.get(uri);

       if(response.statusCode==200){
         StorageRepository.setString(key: "access_token", value: jsonDecode(response.body)["access_token"]);
         return NetworkResponse(
           data: jsonDecode(response.body),
           token:jsonDecode(response.body)["access_token"],
         );
       }
       if(response.statusCode==400){
         return NetworkResponse(errorText: "Email yoki password xato");
       }
       return NetworkResponse(errorText: "Handler Error");
      }catch(e){
          return NetworkResponse(errorText: e.toString());
      }
  }

  static Future<NetworkResponse> updateProfile({
    required String? card,
    required String? dateOfBirth,
    required String? email,
    required String? fullName,
    required String? gender,
    required String? password,
    required String? phoneNumber,
  }) async {
    try{
      final Map<String, String> queryParams = {
        'card': card ?? "",
        'date_of_birth': dateOfBirth ?? "",
        'password': "",
        'email': email ?? "",
        'full_name': fullName ?? "",
        'gender': gender ?? "",
        'phone_number': phoneNumber ?? "",
      };
      Uri uri=Uri.http(AppConstants.baseUrl,"/v1/users",);
      debugPrint(uri.toString());
      http.Response response= await http.put(uri,
          body: jsonEncode(
              {
                'card': card ?? "",
                'date_of_birth': dateOfBirth ?? "",
                'password': "",
                'email': email ?? "",
                'full_name': fullName ?? "",
                'gender': gender ?? "",
                'phone_number': phoneNumber ?? "",
              }
          ),
          headers: ApiProvider.getHeader());
      print(response.statusCode);
      print(response.body);
      if(response.statusCode==200){
        return NetworkResponse(
          data: jsonDecode(response.body),
          errorText: "200",
        );
      }
      if(response.statusCode==400){
        return NetworkResponse(errorText: "Email yoki password xato");
      }
      return NetworkResponse(errorText: "Handler Error");
    }catch(e){
      return NetworkResponse(errorText: e.toString());
    }
  }
  static Future<NetworkResponse> filterAttraction({
    required String? country,
    required String? city,
    required String? stateProvince,
  }) async {
    try{
      final Map<String, String> queryParams = {
        'page': "1",
        'limit': "100",
        'country': country ?? "",
        'city': city ?? "",
        "province": stateProvince ?? "",
      };
      Uri uri=Uri.http(AppConstants.baseUrl,"/v1/attraction/listlocation",).replace(queryParameters: queryParams);
      debugPrint(uri.toString());
      http.Response response= await http.get(uri);
      if(response.statusCode==200){
        return NetworkResponse(
          data: jsonDecode(response.body)["attractions"],
        );
      }
      if(response.statusCode==404){
        return NetworkResponse(data: []);
      }
      return NetworkResponse(errorText: "Handler Error");
    }catch(e){
      return NetworkResponse(errorText: e.toString());
    }
  }
  static Future<NetworkResponse> searchAttraction({
    required String name,
  }) async {
    try{
      final Map<String, String> queryParams = {
        'name': name,
      };
      Uri uri=Uri.http(AppConstants.baseUrl,"/v1/attraction/find",).replace(queryParameters: queryParams);
      debugPrint(uri.toString());
      http.Response response= await http.get(uri);
      if(response.statusCode==200){
        return NetworkResponse(
          data: jsonDecode(response.body)["attraction"],
        );
      }
      if(response.statusCode==400){
        return NetworkResponse(errorText: "Not Fount");
      }
      return NetworkResponse(errorText: "Handler Error");
    }catch(e){
      return NetworkResponse(errorText: e.toString());
    }
  }
  static Future<NetworkResponse> searchRestaurant({
    required String name,
  }) async {
    try{
      final Map<String, String> queryParams = {
        'name': name,
      };
      Uri uri=Uri.http(AppConstants.baseUrl,"/v1/restaurant/find",).replace(queryParameters: queryParams);
      debugPrint(uri.toString());
      http.Response response= await http.get(uri);
      if(response.statusCode==200){
        return NetworkResponse(
          data: jsonDecode(response.body)["restaurant"],
        );
      }
      if(response.statusCode==400){
        return NetworkResponse(errorText: "Not Fount");
      }
      return NetworkResponse(errorText: "Handler Error");
    }catch(e){
      return NetworkResponse(errorText: e.toString());
    }
  }
  static Future<NetworkResponse> searchHotel({
    required String name,
  }) async {
    try{
      final Map<String, String> queryParams = {
        'name': name,
      };
      Uri uri=Uri.http(AppConstants.baseUrl,"/v1/hotel/find",).replace(queryParameters: queryParams);
      debugPrint(uri.toString());
      http.Response response= await http.get(uri);
      if(response.statusCode==200){
        return NetworkResponse(
          data: jsonDecode(response.body)["hotels"],
        );
      }
      if(response.statusCode==400){
        return NetworkResponse(errorText: "Not Fount");
      }
      return NetworkResponse(errorText: "Handler Error");
    }catch(e){
      return NetworkResponse(errorText: e.toString());
    }
  }
  static Future<NetworkResponse> filterRestaurant({
    required String? country,
    required String? city,
    required String? stateProvince,
  }) async {
    try{
      final Map<String, String> queryParams = {
        'page': "1",
        'limit': "100",
        'country': country ?? "",
        'city': city ?? "",
        "province": stateProvince ?? "",
      };
      Uri uri=Uri.http(AppConstants.baseUrl,"/v1/restaurant/listlocation",).replace(queryParameters: queryParams);
      debugPrint(uri.toString());
      http.Response response= await http.get(uri);
      if(response.statusCode==200){
        return NetworkResponse(
          data: jsonDecode(response.body)["restaurants"],
        );
      }
      if(response.statusCode==404){
        return NetworkResponse(data: []);     }
      return NetworkResponse(errorText: "Handler Error");
    }catch(e){
      return NetworkResponse(errorText: e.toString());
    }
  }
  static Future<NetworkResponse> filterHotel({
    required String? country,
    required String? city,
    required String? stateProvince,
  }) async {
    try{
      final Map<String, String> queryParams = {
        'page': "1",
        'limit': "100",
        'country': country ?? "",
        'city': city ?? "",
        "province": stateProvince ?? "",
      };
      Uri uri=Uri.http(AppConstants.baseUrl,"/v1/hotel/listlocation",).replace(queryParameters: queryParams);
      debugPrint(uri.toString());
      http.Response response= await http.get(uri);
      if(response.statusCode==200){
        return NetworkResponse(
          data: jsonDecode(response.body)["hotels"],
        );
      }
      if(response.statusCode==404){
        return NetworkResponse(data: []);
      }
      return NetworkResponse(errorText: "Handler Error");
    }catch(e){
      return NetworkResponse(errorText: e.toString());
    }
  }
  static Future<NetworkResponse> registerOneMethod({
    required String email,
    required String password,
    required String fullName,
  }) async {
    try{

      Uri uri=Uri.http(AppConstants.baseUrl,"/v1/users/register",);
      http.Response response= await http.post(
          uri,
        body: jsonEncode(
          {
            'email': email,
            'password': password,
            "full_name":fullName,
          }
        ),
        headers: {
            "Content-Type":"application/json"
        }

      );
      if(response.statusCode==200){
        return NetworkResponse(
          data: jsonDecode(response.body),
        );
      }
      if(response.statusCode==409){
        return NetworkResponse(errorCode: 409.toString(),errorText: "email mavjud");
      }
      return NetworkResponse(errorText: "Handler Error");
    }catch(e){
      return NetworkResponse(errorText: e.toString());
    }
  }

  static Future<NetworkResponse> registerForVerify({
    required String email,
    required String password,
  }) async {
    try{
      final Map<String, String> queryParams = {
        'code': password,
        'email': email,
      };
      Uri uri=Uri.http(AppConstants.baseUrl,"/v1/users/verify",).replace(queryParameters: queryParams);
      http.Response response= await http.get(uri);
      if(response.statusCode==201){
        StorageRepository.setString(key: "access_token", value: jsonDecode(response.body)["access_token"]);
        StorageRepository.setString(key: "refresh_token", value: jsonDecode(response.body)["refresh_token"]);

        return NetworkResponse(
          data: jsonDecode(response.body),
          token:jsonDecode(response.body)["access_token"],
        );
      }
      if(response.statusCode==400){
        return NetworkResponse(errorCode: 400.toString(),errorText: "code xato");
      }
     return NetworkResponse(errorCode: response.statusCode.toString());
    }catch(e){
      return NetworkResponse(errorText: e.toString());
    }
  }


  static Future<NetworkResponse> getAllHotel() async {
    try{
      final Map<String, String> queryParams = {
        'page': "1",
        'limit': "100",
      };
      Uri uri=Uri.http(AppConstants.baseUrl,"/v1/hotel/list",).replace(queryParameters: queryParams);
      http.Response response= await http.get(uri);
      if(response.statusCode==200){
        return NetworkResponse(
          data: jsonDecode(response.body)["hotels"],
        );
      }
      if(response.statusCode==400){
        return NetworkResponse(errorCode: 400.toString());
      }
      return NetworkResponse(errorCode: response.statusCode.toString());
    }catch(e){
      return NetworkResponse(errorText: e.toString());
    }
  }
  static Future<NetworkResponse> getAllAttraction() async {
    try{
      final Map<String, String> queryParams = {
        'page': "1",
        'limit': "100",
      };
      Uri uri=Uri.http(AppConstants.baseUrl,"/v1/attraction/list",).replace(queryParameters: queryParams);
      http.Response response= await http.get(uri);
      if(response.statusCode==200){
        return NetworkResponse(
          data: jsonDecode(response.body)["attractions"],
        );
      }
      if(response.statusCode==400){
        return NetworkResponse(errorCode: 400.toString());
      }
      return NetworkResponse(errorCode: response.statusCode.toString());
    }catch(e){
      return NetworkResponse(errorText: e.toString());
    }
  }
  static Future<NetworkResponse> getAllRestaurant() async {
    try{
      final Map<String, String> queryParams = {
        'page': "1",
        'limit': "100",
      };
      Uri uri=Uri.http(AppConstants.baseUrl,"/v1/restaurant/list",).replace(queryParameters: queryParams);
      http.Response response= await http.get(uri);
      if(response.statusCode==200){
        return NetworkResponse(
          data: jsonDecode(response.body)["restaurants"],
        );
      }
      if(response.statusCode==400){
        return NetworkResponse(errorCode: 400.toString());
      }
      return NetworkResponse(errorCode: response.statusCode.toString());
    }catch(e){
      return NetworkResponse(errorText: e.toString());
    }
  }
  static Future<NetworkResponse> getAllBookingHotel({required String id}) async {
    try{
      final Map<String, String> queryParams = {
        "id":id,
        'page': "1",
        'limit': "100",
      };
      Uri uri=Uri.http(AppConstants.baseUrl,"/v1/booking/hotels/$id",).replace(queryParameters: queryParams);
      http.Response response= await http.get(uri);
      if(response.statusCode==200){
        return NetworkResponse(
          data: jsonDecode(response.body)["hotels"],
        );
      }
      if(response.statusCode==400){
        return NetworkResponse(errorCode: 400.toString());
      }
      return NetworkResponse(errorCode: response.statusCode.toString());
    }catch(e){
      return NetworkResponse(errorText: e.toString());
    }
  }
  static Future<NetworkResponse> getAllAttractionHotel({required String id}) async {
    try{
      final Map<String, String> queryParams = {
        "id":id,
        'page': "1",
        'limit': "100",
      };
      Uri uri=Uri.http(AppConstants.baseUrl,"/v1/booking/attractions/$id",).replace(queryParameters: queryParams);
      http.Response response= await http.get(uri);
      if(response.statusCode==200){
        return NetworkResponse(
          data: jsonDecode(response.body)["attractions"],
        );
      }
      if(response.statusCode==400){
        return NetworkResponse(errorCode: 400.toString());
      }
      return NetworkResponse(errorCode: response.statusCode.toString());
    }catch(e){
      return NetworkResponse(errorText: e.toString());
    }
  }
  static Future<NetworkResponse> getAllRestaurantHotel({required String id}) async {
    try{
      final Map<String, String> queryParams = {
        "id":id,
        'page': "1",
        'limit': "100",
      };
      Uri uri=Uri.http(AppConstants.baseUrl,"/v1/booking/restaurants/$id",).replace(queryParameters: queryParams);
      http.Response response= await http.get(uri);
      if(response.statusCode==200){
        return NetworkResponse(
          data: jsonDecode(response.body)["restaurant"],
        );
      }
      if(response.statusCode==400){
        return NetworkResponse(errorCode: 400.toString());
      }
      return NetworkResponse(errorCode: response.statusCode.toString());
    }catch(e){
      return NetworkResponse(errorText: e.toString());
    }
  }
  static Future<NetworkResponse> bookingHotel({
    required String numberOfPeople,
    required String id,
    required String willArrive,
    required String willLeave,
}) async {
    try{
      final Map<String, String> queryParams = {
        'hra_id': id,
        'is_canceled': "false",
        'number_of_people': numberOfPeople,
        'reason':"",
        'will_arrive': willArrive,
        'will_leave': willLeave,
      };
      Uri uri=Uri.http(AppConstants.baseUrl,"/v1/booking/hotels",).replace(queryParameters: queryParams);
      http.Response response= await http.get(uri,headers: ApiProvider.getHeader());
      print(response.statusCode);
      if(response.statusCode==200){
        return NetworkResponse(
          data: jsonDecode(response.body),
        );
      }
      if(response.statusCode==400){
        return NetworkResponse(errorCode: 400.toString());
      }
      return NetworkResponse(errorCode: response.statusCode.toString());
    }catch(e){
      return NetworkResponse(errorText: e.toString());
    }
  }
  static Future<NetworkResponse> bookingRestaurant({
    required String numberOfPeople,
    required String id,
    required String willArrive,
    required String willLeave,
  }) async {
    try{
      final Map<String, String> queryParams = {
        'hra_id': id,
        'is_canceled': "false",
        'number_of_people': numberOfPeople,
        'reason':"",
        'will_arrive': willArrive,
        'will_leave': willLeave,
      };
      Uri uri=Uri.http(AppConstants.baseUrl,"/v1/booking/restaurants",).replace(queryParameters: queryParams);
      http.Response response= await http.get(uri,headers: ApiProvider.getHeader());
      if(response.statusCode==200){
        return NetworkResponse(
          data: jsonDecode(response.body),
        );
      }
      if(response.statusCode==400){
        return NetworkResponse(errorCode: 400.toString());
      }
      return NetworkResponse(errorCode: response.statusCode.toString());
    }catch(e){
      return NetworkResponse(errorText: e.toString());
    }
  }
  static Future<NetworkResponse> bookingAttraction({
    required String numberOfPeople,
    required String id,
    required String willArrive,
    required String willLeave,
  }) async {
    try{
      final Map<String, String> queryParams = {
        'hra_id': id,
        'is_canceled': "false",
        'number_of_people': numberOfPeople,
        'reason':"",
        'will_arrive': willArrive,
        'will_leave': willLeave,
      };
      Uri uri=Uri.http(AppConstants.baseUrl,"/v1/booking/attractions",).replace(queryParameters: queryParams);
      http.Response response= await http.get(uri,headers: ApiProvider.getHeader());
      if(response.statusCode==200){
        return NetworkResponse(
          data: jsonDecode(response.body),
        );
      }
      if(response.statusCode==400){
        return NetworkResponse(errorCode: 400.toString());
      }
      return NetworkResponse(errorCode: response.statusCode.toString());
    }catch(e){
      return NetworkResponse(errorText: e.toString());
    }
  }
  static Future<NetworkResponse> getUserByToken() async {
    try{
      // ApiProvider.getHeader();
      Uri uri=Uri.http(AppConstants.baseUrl,"/v1/users/token",);
      http.Response response= await http.get(uri,headers: ApiProvider.getHeader());
      if(response.statusCode==200){
        return NetworkResponse(
          data: jsonDecode(response.body),
        );
      }
      if(response.statusCode==400){
        return NetworkResponse(errorCode: 400.toString());
      }
      return NetworkResponse(errorCode: response.statusCode.toString());
    }catch(e){
      return NetworkResponse(errorText: e.toString());
    }
  }

}
