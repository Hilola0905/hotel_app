
import 'package:flutter/material.dart';
import 'package:hotel_app/utils/style/app_text_style.dart';

import '../data/model/attraction/attraction_model.dart';
import '../data/model/hotel/hotel_model.dart';
import '../data/model/restaurant/restaurant_model.dart';

showSnackBar({required BuildContext context, required String message}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: Colors.orangeAccent,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(16), topLeft: Radius.circular(16))),
      content: Text(
        message,
        textAlign: TextAlign.center,
        style: AppTextStyle.interSemiBold
            .copyWith(fontSize: 20, color: Colors.white),
      ),
    ),
  );
}

showErrorForRegister(
    String code,
    BuildContext context,
    ) {
  if (code == 'weak-password') {
    debugPrint('The password provided is too weak.');
    if (!context.mounted) return;
    showSnackBar(
      context: context,
      message: "Passwordni xato kiritdingiz",
    );
  } else if (code == 'email-already-in-use') {
    debugPrint('The account already exists for that email.');
    if (!context.mounted) return;
    showSnackBar(
      context: context,
      message: "Bu e-pochta uchun hisob allaqachon mavjud.",
    );
  }
}

showErrorForLogin(
    String code,
    BuildContext context,
    ) {
  if (code == 'wrong-password') {
    debugPrint('The password provided is wrong.');
    if (!context.mounted) return;
    showSnackBar(
      context: context,
      message: "Passwordni xato kiritdingiz",
    );
  } else if (code == 'invalid-email') {
    debugPrint('The e-mail is invalid.');
    if (!context.mounted) return;
    showSnackBar(
      context: context,
      message: "Bu e-pochta yaqroqsiz.",
    );
  } else if (code == 'user-disabled') {
    debugPrint('The user is blocked.');
    if (!context.mounted) return;
    showSnackBar(
      context: context,
      message: "Foydalanuvchi bloklangan.",
    );
  } else {
    debugPrint('The user is not found.');
    if (!context.mounted) return;
    showSnackBar(
      context: context,
      message: "not fount user.",
    );
  }
}



 alertDialog(BuildContext context,VoidCallback onTap){
   return AlertDialog(
     title : const  Text(" really sign out "),
     actions: [
       TextButton(
           onPressed: onTap,
           child: const Text("ok",style: TextStyle(
           fontWeight: FontWeight.w500,
           fontSize: 18
       ),)),
       TextButton(onPressed: (){
         Navigator.of(context).pop();
       }, child: const Text("cancel",style: TextStyle(
           fontWeight: FontWeight.w500,
           fontSize: 18
       ),
       ),
       ),
     ],
   );
 }

List<String> getCityHotel(List<HotelModel> list){
  List<String> city=[];
  for(int i=0;i<list.length;i++){
    city.add(list[i].locationModel.city);
  }
  Set<String> mySet = city.toSet();
  city=mySet.toList();
  return city;
}
List<String> getCityAttraction(List<AttractionModel> list){
  List<String> city=[];
  for(int i=0;i<list.length;i++){
    city.add(list[i].locationModel.city);
  }
  Set<String> mySet = city.toSet();
  city=mySet.toList();
  return city;
}
List<String> getCityRestaurant(List<RestaurantModel> list){
  List<String> city=[];
  for(int i=0;i<list.length;i++){
    city.add(list[i].locationModel.city);
  }
  Set<String> mySet = city.toSet();
  city=mySet.toList();
  return city;
}
List<String> getCountryAttraction(List<AttractionModel> list){
  List<String> country=[];
  for(int i=0;i<list.length;i++){
    country.add(list[i].locationModel.country);
  }
  Set<String> mySet = country.toSet();
  country=mySet.toList();
  return country;
}
List<String> getCountryRestaurant(List<RestaurantModel> list){
  List<String> country=[];
  for(int i=0;i<list.length;i++){
    country.add(list[i].locationModel.country);
  }
  Set<String> mySet = country.toSet();
  country=mySet.toList();
  return country;
}
List<String> getCountryHotel(List<HotelModel> list){
  List<String> country=[];
  for(int i=0;i<list.length;i++){
    country.add(list[i].locationModel.country);
  }
  Set<String> mySet = country.toSet();
  country=mySet.toList();
  return country;
}
List<String> getProvinceAttraction(List<AttractionModel> list){
  List<String> province=[];
  for(int i=0;i<list.length;i++){
    province.add(list[i].locationModel.country);
  }
  Set<String> mySet = province.toSet();
  province=mySet.toList();
  return province;
}
List<String> getProvinceRestaurant(List<RestaurantModel> list){
  List<String> province=[];
  for(int i=0;i<list.length;i++){
    province.add(list[i].locationModel.country);
  }
  Set<String> mySet = province.toSet();
  province=mySet.toList();
  return province;
}
List<String> getProvinceHotel(List<HotelModel> list){
  List<String> province=[];
  for(int i=0;i<list.length;i++){
    province.add(list[i].locationModel.country);
  }
   Set<String> mySet = province.toSet();
   province=mySet.toList();
  return province;
}
