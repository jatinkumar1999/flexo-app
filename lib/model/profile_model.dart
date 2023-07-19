class ProfileModel {
  bool? status;
  String? message;
  User? user;

  ProfileModel({this.status, this.message, this.user});

  ProfileModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    return data;
  }
}

class User {
  String? id;
  String? name;
  String? email;
  String? role;
  String? totalBalance;
  String? image;

  User(
      {this.id,
        this.name,
        this.email,
        this.role,
        this.totalBalance,
        this.image});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    role = json['role'];
    totalBalance = json['total_balance'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['role'] = this.role;
    data['total_balance'] = this.totalBalance;
    data['image'] = this.image;
    return data;
  }
}
