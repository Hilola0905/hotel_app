import 'dart:convert';
import 'package:hotel_app/data/model/location/location_model.dart';

import '../../../utils/images/app_images.dart';


class HotelModel{
  final String hotelId;
  final String hotelName;
  final String description;
  final double rating;
  final String contactNumber;
  final String licenceUrl;
  final String websiteUrl;
  final List<String> images;
  final LocationModel locationModel;
  final bool isFavourite;

  HotelModel({
    required this.locationModel,
    required this.description,
    required this.contactNumber,
    required this.hotelId,
    required this.hotelName,
    required this.images,
    required this.licenceUrl,
    required this.rating,
    required this.websiteUrl,
    required this.isFavourite,
 });

  factory HotelModel.fromJson(Map<String,dynamic> json){
    List<String> images=[];
    var b=json["images"] ?? [];
   for(var i in b){
     images.add(i["image_url"]);
   }
    return HotelModel(
        locationModel: LocationModel.fromJson(json["location"]),
        description: json["description"] as String? ?? "",
        contactNumber: json["contact_number"] as String? ?? "",
        hotelId: json["hotel_id"] as String? ?? "",
        hotelName: json["hotel_name"] as String? ?? "",
        images: images.isEmpty ?["https://thumbs.dreamstime.com/b/travel-world-background-concept-airplane-31844945.jpg"]:images,
        licenceUrl: json["licence_url"] as String? ?? "",
        rating: (json["rating"] as num? ?? 0.0).toDouble(),
        websiteUrl: json["website_url"] as String? ?? "",
      isFavourite: json["is_favourite"] as bool? ?? false,
    );
  }

  HotelModel copyWith({
    bool? isFavourite,
 }){
    return HotelModel(
        locationModel: locationModel,
        description: description,
        contactNumber: contactNumber,
        hotelId: hotelId,
        hotelName: hotelName,
        images: images,
        licenceUrl: licenceUrl,
        rating: rating,
        websiteUrl: websiteUrl,
        isFavourite: isFavourite ?? this.isFavourite
    );
  }
  Map<String,dynamic> toJson(){
    return {
      "is_favourite":isFavourite,
      'description':description,
      "contact_number":contactNumber,
      "hotel_id":hotelId,
      "hotel_name":hotelName,
      "website_url":websiteUrl,
      "licence_url":licenceUrl,
      "images":images,
      "rating":rating,
       "location":locationModel.toJson()
    };
  }

}


