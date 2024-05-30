
import 'package:hotel_app/data/model/location/location_model.dart';

import '../../../utils/images/app_images.dart';


class RestaurantModel{
  final String restaurantId;
  final String restaurantName;
  final String description;
  final double rating;
  final String contactNumber;
  final String licenceUrl;
  final String websiteUrl;
  final List<String> images;
  final LocationModel locationModel;
  final bool isFavourite;
  final String openHour;

  RestaurantModel({
    required this.locationModel,
    required this.description,
    required this.contactNumber,
    required this.restaurantId,
    required this.restaurantName,
    required this.images,
    required this.licenceUrl,
    required this.rating,
    required this.websiteUrl,
    required this.isFavourite,
    required this.openHour,
  });

  factory RestaurantModel.fromJson(Map<String,dynamic> json){
    List<String> images=[];
    var b=json["images"] ?? [];
    for(var i in b){
      images.add(i["image_url"]);
    }
    return RestaurantModel(
      locationModel: LocationModel.fromJson(json["location"]),
      description: json["description"] as String? ?? "",
      contactNumber: json["contact_number"] as String? ?? "",
      restaurantId: json["restaurant_id"] as String? ?? "",
      restaurantName: json["restaurant_name"] as String? ?? "",
      images: images.isEmpty ?["https://thumbs.dreamstime.com/b/travel-world-background-concept-airplane-31844945.jpg"]:images,
      licenceUrl: json["licence_url"] as String? ?? "",
      rating: (json["rating"] as num? ?? 0.0).toDouble(),
      websiteUrl: json["website_url"] as String? ?? "",
      isFavourite: json["is_favourite"] as bool? ?? false,
      openHour: json["opening_hours"] as String? ?? "",
    );
  }

  RestaurantModel copyWith({
    bool? isFavourite,
  }){
    return RestaurantModel(
        locationModel: locationModel,
        description: description,
        contactNumber: contactNumber,
        restaurantId: restaurantId,
        restaurantName: restaurantName,
        images: images,
        licenceUrl: licenceUrl,
        rating: rating,
        websiteUrl: websiteUrl,
        isFavourite: isFavourite ?? this.isFavourite,
        openHour: openHour
    );
  }
  Map<String,dynamic> toJson(){
    return {
      "is_favourite":isFavourite,
      'description':description,
      "contact_number":contactNumber,
      "restaurant_id":restaurantId,
      "restaurant_name":restaurantName,
      "website_url":websiteUrl,
      "licence_url":licenceUrl,
      "images":images,
      "rating":rating,
      "location":locationModel.toJson(),
      "opening_hours":openHour,
    };
  }

}
























