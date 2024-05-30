
class AppConstants {
  static RegExp emailRegExp = RegExp(
      r'^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$');
  static RegExp passwordRegExp = RegExp(
      r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$'
  );
  static RegExp name = RegExp(
      r'^[a-zA-Z0-9\s]{5,20}$' // kamida 5 ta va ko'pi bilan 20 ta belgidan iborat
  );
  static RegExp textRegExp = RegExp("[a-zA-Z]");
  static RegExp phoneRegExp = RegExp(r'(^(?:[+0]9)?[0-9]{10,12}$)');
  static String messages = "messages";
  static String contacts = "contacts";
  static String baseUrl = "18.185.248.114:8080";


}
