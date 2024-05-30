class LocationModel{
  final String locationId;
  final String address;
  final double latitude;
  final double longitude;
  final String country;
  final String city;
  final String stateProvince;
  LocationModel({
    required this.longitude,
    required this.latitude,
    required this.country,
    required this.city,
    required this.address,
    required this.locationId,
    required this.stateProvince,
});

  factory LocationModel.fromJson(Map<String,dynamic> json){
    return LocationModel(
        longitude: (json["longitude"] as num? ?? 0.0).toDouble() ,
        latitude: (json["latitude"] as num? ?? 0.0).toDouble(),
        country: json["country"] as String? ?? "",
        city: json["city"] as String? ?? "",
        address: json["address"] as String? ?? "",
        locationId: json["location_id"] as String? ?? "",
        stateProvince: json["state_province"] as String? ?? ""
    );
  }

  Map<String,dynamic> toJson(){
    return{
      "longitude":longitude,
      "latitude":latitude,
      "country":country,
      "city":city,
      "address":address,
      "location_id":locationId,
      "state_province":stateProvince,
    };
  }

}

