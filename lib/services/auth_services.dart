import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flexo_app/model/bookingList_model.dart';
import 'package:flexo_app/model/profile_model.dart';
import 'package:flexo_app/model/service_model.dart';
import 'package:flexo_app/model/service_provider_model.dart';
import 'package:flexo_app/model/time_slot_model.dart';
import 'package:flexo_app/services/api_constant.dart';
import 'package:flexo_app/services/logging_interceptor.dart';
import 'package:flutter/cupertino.dart';
import '../model/banner_model.dart';
import '../model/common_response_model.dart';
import '../model/get_cards_details_model.dart';
import '../model/login_model.dart';
import '../model/register_model.dart';
import '../model/service_provider_list_model.dart';
import '../model/sports_model.dart';
import '../storage/get_storage.dart';
import '../storage/storage_constants.dart';

class ApiProvider {
  static BaseOptions options = BaseOptions(
    receiveTimeout: Duration(seconds: 90000),
    connectTimeout: Duration(seconds: 90000),
  );
  final Dio _dio = Dio(options);

  ApiProvider() {
    _dio.interceptors.add(LoggingInterceptor());
  }

  String slash = "/";

  String _handleError(error) {
    String errorDescription = "";
    if (error is DioError) {
      DioError dioError = error;
      switch (dioError.type) {
        case DioErrorType.cancel:
          errorDescription = "Request to API server was cancelled";
          break;
        case DioErrorType.connectionTimeout:
          errorDescription = "Connection timeout with API server";
          break;
        case DioErrorType.unknown:
          errorDescription = "No internet";
          break;
        case DioErrorType.receiveTimeout:
          errorDescription = "Receive timeout in connection with API server";
          break;
        case DioErrorType.badResponse:
          errorDescription =
              "Received invalid status code: ${dioError.response?.statusCode}";
          break;
        case DioErrorType.sendTimeout:
          errorDescription = "Send timeout in connection with API server";
          break;
      }
    } else {
      errorDescription = "Invalid response from server";
    }
    return errorDescription;
  }

  /// SIgnup with Phone
  Future signUp(
      {context,
      required String? name,
      required String? email,
      required String? password,
      required String? role,
      String? categoryId}) async {
    var map = <String, dynamic>{
      'name': name,
      'email': email,
      'password': password ?? "",
      'role': role,
      'category_id': categoryId,
    };
    log("SignUp====>>>$map");
    var headerOptions = Options(
      headers: {
        StorageConst.ACCEPT: "application/json",
      },
    );
    try {
      Response response = await _dio.post(ApiUrl.register,
          data: FormData.fromMap(map), options: headerOptions);
      print("=====Signup Response====" + response.toString());
      if (response.statusCode == 200) {
        return RegisterModel.fromJson(response.data);
      }
    } catch (error, stacktrace) {
      debugPrint("Exception occured: $error stackTrace: $stacktrace");
    }
  }

  /// Login Users
  Future loginUser({
    context,
    String? email,
    String? password,
  }) async {
    var map = <String, dynamic>{
      "email": email?.trim() ?? "",
      "password": password,
    };
    log("login===>>>$map");
    var headerOptions = Options(
      headers: {
        StorageConst.ACCEPT: "application/json",
      },
    );
    try {
      Response response = await _dio.post(ApiUrl.login,
          data: FormData.fromMap(map), options: headerOptions);
      log("=====Login Response====" + response.toString());
      if (response.statusCode == 200) {
        print("=====LoginModel Response====" + response.toString());

        return LoginModel.fromJson(jsonDecode(response.data));
      }
    } catch (error, stacktrace) {
      debugPrint("Exception occured: $error stackTrace: $stacktrace");
    }
  }

  /// Forgot Password
  Future forgotPassword({
    required String? user,
  }) async {
    var map = <String, dynamic>{
      'email': user,
    };
    print(map.toString());
    var headerOptions = Options(
      headers: {
        StorageConst.ACCEPT: "application/json",
      },
    );

    Response response = await _dio.post(ApiUrl.forgotPassword,
        data: FormData.fromMap(map), options: headerOptions);
    if (response.statusCode == 200) {
      print("=====Forgot Password Response====" + response.toString());
      print(response.data);
      return RegisterModel.fromJson(jsonDecode(response.data));
    }
  }

  /// Forgot Password
  Future resetPassword(
      {required String? otp, String? email, String? password}) async {
    var map = <String, dynamic>{
      'otp': otp,
      'email': email,
      'new_password': password,
    };
    print(map.toString());
    var headerOptions = Options(
      headers: {
        StorageConst.ACCEPT: "application/json",
      },
    );

    Response response = await _dio.post(ApiUrl.resetPassword,
        data: FormData.fromMap(map), options: headerOptions);
    if (response.statusCode == 200) {
      print("=====changePassword Password Response====" + response.toString());
      print(response.data);
      return RegisterModel.fromJson(jsonDecode(response.data));
    }
  }

  Future verifyAccount({required String? otp, String? email}) async {
    var map = <String, dynamic>{
      'otp': otp,
      'email': email,
    };
    print(map.toString());
    var headerOptions = Options(
      headers: {
        StorageConst.ACCEPT: "application/json",
      },
    );

    Response response = await _dio.post(ApiUrl.verifyAccount,
        data: FormData.fromMap(map), options: headerOptions);
    if (response.statusCode == 200) {
      print("=====verifyAccount Response====" + response.toString());
      print(response.data);
      return CommonResponseModel.fromJson(response.data);
    }
  }

  /// Get SportsCategoriesModel List
  Future<CategoryList> getSportsList() async {
    var headerOptions = Options(
      headers: {
        StorageConst.ACCEPT: "application/json",
      },
    );
    Response response =
        await _dio.get(ApiUrl.categoriesList, options: headerOptions);
    log("categoriesList=====>>>${response}");
    return CategoryList.fromJson(response.data);
  }

  /// Get ServicesModel List
  Future<ServiceModel> getServiceList(String serviceId, String catId) async {
    var map = <String, dynamic>{
      'provider_id': serviceId,
      'category_id': catId,
    };
    var headerOptions = Options(
      headers: {
        StorageConst.ACCEPT: "application/json",
      },
    );
    print("serviceList=====>>>${map}");
    Response response = await _dio.post(ApiUrl.serviceList,
        data: FormData.fromMap(map), options: headerOptions);
    log("serviceList=====>>>${response}");
    return ServiceModel.fromJson(response.data);
  }

  Future bookingAppointment(
      {required String? userId,
      required String? catId,
      required String? serviceId,
      required String? timeSlotId,
      required String? providerId}) async {
    var map = <String, dynamic>{
      'user_id': userId,
      'category_id': catId,
      'service_id': serviceId,
      'time_slot_id': timeSlotId,
      'provider_id': providerId,
    };
    print(map.toString());
    var headerOptions = Options(
      headers: {
        StorageConst.ACCEPT: "application/json",
      },
    );

    Response response = await _dio.post(ApiUrl.bookService,
        data: FormData.fromMap(map), options: headerOptions);
    if (response.statusCode == 200) {
      print("=====bookingAppointment Response====" + response.toString());
      print(response.data);
      return CommonResponseModel.fromJson(response.data);
    }
  }

  Future getBookingList({
    String? userId,
    required String? type,
    String? proiderId,
  }) async {
    var map;
    if (Storage().getStoreStoreMode() == 'customer') {
       map = <String, dynamic>{
        'user_id': userId,
        'booking_type': type,
        'provider_id': proiderId,
      };
    } else {
       map = <String, dynamic>{
        'booking_type': type,
        'provider_id': proiderId,
      };
    }
    print(map.toString());
    var headerOptions = Options(
      headers: {
        StorageConst.ACCEPT: "application/json",
      },
    );

    Response response = await _dio.post(ApiUrl.bookingList,
        data: FormData.fromMap(map), options: headerOptions);
    if (response.statusCode == 200) {
      print("=====getBookingList Response====" + response.toString());
      print(response.data);
      return BookingListModel.fromJson(response.data);
    }
  }

  /// Get SportsCategoriesModel List
  Future<TimeSlotModel> getTimeSlotsList() async {
    var headerOptions = Options(
      headers: {
        StorageConst.ACCEPT: "application/json",
      },
    );

    Response response =
        await _dio.get(ApiUrl.timeSlots, options: headerOptions);
    log("categoriesList=====>>>${response}");
    return TimeSlotModel.fromJson(response.data);
  }

  /// Get ServicesModel List
  Future<BannerModel> getBannerList() async {
    var headerOptions = Options(
      headers: {
        StorageConst.ACCEPT: "application/json",
      },
    );
    Response response =
        await _dio.get(ApiUrl.getBanners, options: headerOptions);
    log("BannerModel=====>>>${response}");
    return BannerModel.fromJson(response.data);
  }

  Future getServicesProvider({
    required String? categoryId,
  }) async {
    var map = <String, dynamic>{
      'category_id': categoryId,
    };
    print(map.toString());
    var headerOptions = Options(
      headers: {
        StorageConst.ACCEPT: "application/json",
      },
    );

    Response response = await _dio.post(ApiUrl.serviceProviders,
        data: FormData.fromMap(map), options: headerOptions);
    if (response.statusCode == 200) {
      print("=====serviceProviders Response====" + response.toString());
      print(response.data);
      return ServiceProviderModel.fromJson(response.data);
    }
  }

  Future<ServiceProviderList> getServiceProviderList() async {
    var headerOptions = Options(
      headers: {
        StorageConst.ACCEPT: "application/json",
      },
    );

    Response response = await _dio.get(ApiUrl.userList, options: headerOptions);
    log("userList=====>>>${response}");
    return ServiceProviderList.fromJson(response.data);
  }

  Future cardDetailsSave({
    required String? userId,
    required String? cardHolderName,
    required String? cardNumber,
    required String? expiryYear,
    required String? expiryMonth,
  }) async {
    var map = <String, dynamic>{
      'user_id': userId,
      'card_holder_name': cardHolderName,
      'card_number': cardNumber,
      'year': expiryYear,
      'month': expiryMonth,
      'upi_id': '1',
    };
    print(map.toString());
    var headerOptions = Options(
      headers: {
        StorageConst.ACCEPT: "application/json",
      },
    );
    Response response = await _dio.post(ApiUrl.saveCardDetails,
        data: FormData.fromMap(map), options: headerOptions);
    if (response.statusCode == 200) {
      print("=====cardDetailsSave Response====" + response.toString());
      print(response.data);
      return ServiceProviderModel.fromJson(response.data);
    }
  }

  Future<ProfileModel> getUserProfile(String userId) async {
    var headerOptions = Options(
      headers: {
        StorageConst.ACCEPT: "application/json",
      },
    );

    Response response = await _dio.get(ApiUrl.getUserDetails + userId);
    print("getUserDetails=====>>>${response}");
    return ProfileModel.fromJson(response.data);
  }

  Future getPastBookingList({
    required String? userId,
    required String? type,
  }) async {
    var map = <String, dynamic>{
      'user_id': userId,
      'type': type,
    };
    print(map.toString());
    var headerOptions = Options(
      headers: {
        StorageConst.ACCEPT: "application/json",
      },
    );

    Response response = await _dio.post(ApiUrl.bookingList,
        data: FormData.fromMap(map), options: headerOptions);
    if (response.statusCode == 200) {
      print("=====getBookingList Response====" + response.toString());
      print(response.data);
      return BookingListModel.fromJson(response.data);
    }
  }

  Future updateProfile({
    String? userId,
    String? name,
    String? email,
    File? filepath,
  }) async {
    Dio dio = Dio();
    var multipartFile = await MultipartFile.fromFile(filepath!.path);

    log('updateProfile=====>>${{
      'user_id': await Storage().getStoreUserId(),
      'name': name,
      'email': email,
      'image': filepath,
    }}');

    FormData formData = FormData.fromMap({
      'user_id': await Storage().getStoreUserId(),
      'name': name,
      'email': email,
      'image': multipartFile,
    });
    var response = await dio.post(ApiUrl.updateProfile,
        data: formData,
        options: Options(headers: {
          StorageConst.ACCEPT: "application/json",
        }));

    print("Sdggsfg===>>$response");
    // return response;
    return CommonResponseModel.fromJson(response.data);
  }

  Future addService(
      {String? userId, String? catId, service, price, desc}) async {
    var map = <String, dynamic>{
      'user_id': userId,
      'category_id': catId,
      'service': service,
      'price': price,
      'description': desc,
    };
    print(map.toString());
    var headerOptions = Options(
      headers: {
        StorageConst.ACCEPT: "application/json",
      },
    );

    Response response = await _dio.post(ApiUrl.addService,
        data: FormData.fromMap(map), options: headerOptions);
    if (response.statusCode == 200) {
      print("=====addService Response====" + response.toString());
      print(response.data);
      return CommonResponseModel.fromJson(response.data);
    }
  }

  Future<GetCardDetailsModel> getCardDetails() async {
    String userId = await Storage().getStoreUserId().toString();
    var map = <String, dynamic>{
      'user_id': userId,
    };
    var headerOptions = Options(
      headers: {
        StorageConst.ACCEPT: "application/json",
      },
    );

    Response response = await _dio.post(ApiUrl.getCardInfo,
        data: FormData.fromMap(map), options: headerOptions);
    print("getUserDetails=====>>>${response}");
    return GetCardDetailsModel.fromJson(response.data);
  }

  Future resendOtp({String? email}) async {
    String userEmail = await Storage().getStoreEmail().toString();

    var map = <String, dynamic>{
      'email': userEmail,
    };
    print(map.toString());
    var headerOptions = Options(
      headers: {
        StorageConst.ACCEPT: "application/json",
      },
    );

    Response response = await _dio.post(ApiUrl.reSendOTP,
        data: FormData.fromMap(map), options: headerOptions);
    if (response.statusCode == 200) {
      print("=====verifyAccount Response====" + response.toString());
      print(response.data);
      return CommonResponseModel.fromJson(response.data);
    }
  }
}
