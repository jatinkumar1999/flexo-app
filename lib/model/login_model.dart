class LoginModel {
  bool? success;
  String? message;
  User? user;

  LoginModel({this.success, this.message, this.user});

  LoginModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    return data;
  }
}

class User {
  int? id;
  String? name;
  String? image;
  String? email;
  String? password;
  String? otp;
  String? otpExpiry;
  String? role;
  int? categoryId;
  int? totalBalance;
 var registerOtp;
 var registerOtpExpiry;
  String? verified;

  User(
      {this.id,
        this.name,
        this.image,
        this.email,
        this.password,
        this.otp,
        this.otpExpiry,
        this.role,
        this.categoryId,
        this.totalBalance,
        this.registerOtp,
        this.registerOtpExpiry,
        this.verified});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    email = json['email'];
    password = json['password'];
    otp = json['otp'];
    otpExpiry = json['otp_expiry'];
    role = json['role'];
    categoryId = json['category_id'];
    totalBalance = json['total_balance'];
    registerOtp = json['register_otp'];
    registerOtpExpiry = json['register_otp_expiry'];
    verified = json['verified'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['image'] = this.image;
    data['email'] = this.email;
    data['password'] = this.password;
    data['otp'] = this.otp;
    data['otp_expiry'] = this.otpExpiry;
    data['role'] = this.role;
    data['category_id'] = this.categoryId;
    data['total_balance'] = this.totalBalance;
    data['register_otp'] = this.registerOtp;
    data['register_otp_expiry'] = this.registerOtpExpiry;
    data['verified'] = this.verified;
    return data;
  }
}
