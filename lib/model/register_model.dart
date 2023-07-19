class RegisterModel {
  bool? success;
  String? message;
  String? userId;
  String? userName;
  String? userRole;
  String? userEmail;
  String? categoryId;

  RegisterModel(
      {this.success,
        this.message,
        this.userId,
        this.userName,
        this.userRole,
        this.userEmail,
        this.categoryId});

  RegisterModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    userId = json['user_id'];
    userName = json['user_name'];
    userRole = json['user_role'];
    userEmail = json['user_email'];
    categoryId = json['category_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    data['user_id'] = this.userId;
    data['user_name'] = this.userName;
    data['user_role'] = this.userRole;
    data['user_email'] = this.userEmail;
    data['category_id'] = this.categoryId;
    return data;
  }
}
