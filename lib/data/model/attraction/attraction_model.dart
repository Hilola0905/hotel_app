import 'package:hotel_app/data/model/location/location_model.dart';

import '../../../utils/images/app_images.dart';


class AttractionModel{
  final String attractionId;
  final String attractionName;
  final String description;
  final double rating;
  final String contactNumber;
  final String licenceUrl;
  final String websiteUrl;
  final List<String> images;
  final LocationModel locationModel;
  final bool isFavourite;

  AttractionModel({
    required this.locationModel,
    required this.description,
    required this.contactNumber,
    required this.attractionId,
    required this.attractionName,
    required this.images,
    required this.licenceUrl,
    required this.rating,
    required this.websiteUrl,
    required this.isFavourite,
  });

  factory AttractionModel.fromJson(Map<String,dynamic> json){
    List<String> images=[];
    var b=json["images"] ?? [];
    for(var i in b){
      images.add(i["image_url"]);
    }  return AttractionModel(
      locationModel: LocationModel.fromJson(json["location"]),
      description: json["description"] as String? ?? "",
      contactNumber: json["contact_number"] as String? ?? "",
      attractionId: json["attraction_id"] as String? ?? "",
      attractionName: json["attraction_name"] as String? ?? "",
      images: images.isEmpty ?["https://thumbs.dreamstime.com/b/travel-world-background-concept-airplane-31844945.jpg"]:images,
      licenceUrl: json["licence_url"] as String? ?? "",
      rating: (json["rating"] as num? ?? 0.0).toDouble(),
      websiteUrl: json["website_url"] as String? ?? "",
      isFavourite: json["is_favourite"] as bool? ?? false,
    );
  }

  AttractionModel copyWith({
    bool? isFavourite,
  }){
    return AttractionModel(
        locationModel: locationModel,
        description: description,
        contactNumber: contactNumber,
        attractionId: attractionId,
        attractionName: attractionName,
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
      "attraction_id":attractionId,
      "attraction_name":attractionName,
      "website_url":websiteUrl,
      "licence_url":licenceUrl,
      "images":images,
      "rating":rating,
      "location":locationModel.toJson()
    };
  }

}










