import 'package:flutter/cupertino.dart';

class ApiUrl {
  static BuildContext? context;

  static const String baseUrl = 'https://flexiyoo.com/';
  static const String imageUrl = 'https://flexiyoo.com/sport_images/';
  static const String register = baseUrl+'register.php';
  static const String login = baseUrl +'login.php';
  static const String forgotPassword = baseUrl +'forgot-password.php';
  static const String resetPassword = baseUrl +'reset-password.php';
  static const String categoriesList = baseUrl +'categories.php';
  static const String serviceDetails = baseUrl +'get_service_detail.php';
  static const String serviceList = baseUrl +'get_services.php';
  static const String bookService = baseUrl +'add_booking.php';
  static const String bookingList = baseUrl +'bookings.php';
  static const String timeSlots = baseUrl +'time_slots.php';
  static const String getBanners = baseUrl +'get_banners.php';
  static const String verifyAccount = baseUrl +'verify_account.php';
  static const String serviceProviders = baseUrl +'service_providers.php';
  static const String userList = baseUrl +'user_details.php?role=service_provider';
  static const String saveCardDetails = baseUrl +'card_details.php';
  static const String getUserDetails = baseUrl +'user_details.php?id=';
  static const String updateProfile = baseUrl +'update_profile.php';
  static const String addService = baseUrl +'add_service.php';
  static const String getCardInfo = baseUrl +'get_user_card_details.php';
  static const String reSendOTP = baseUrl +'resend_otp.php';

  static const String  publishablekey= "pk_test_51ND9yxSAsJcPidNRpyH0piUJOCpYzUp3oq3h43WsuKNI2CFWSI5B9JUkNeWZwyU79hpEqnQFcfCl63rT52b0jnwa00TFqbs30w";
  static const String secretkey="sk_test_51ND9yxSAsJcPidNR51vCqmYhPg8028XfcgCMaIFOqLCjWGCXZORjBl0X1L2L26piDQfmV5UYYGoHBcLgB2SOD5ZN00wT9TsKSq";
}
