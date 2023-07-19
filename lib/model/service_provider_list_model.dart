class ServiceProviderList {
  bool? status;
  String? message;
  List<User>? user;

  ServiceProviderList({this.status, this.message, this.user});

  ServiceProviderList.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['user'] != null) {
      user = <User>[];
      json['user'].forEach((v) {
        user!.add(new User.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.user != null) {
      data['user'] = this.user!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class User {
  String? id;
  String? name;
  String? email;
  String? role;
  String? categoryId;
  String? totalBalance;
  String? image;

  User(
      {this.id,
        this.name,
        this.email,
        this.role,
        this.categoryId,
        this.totalBalance,
        this.image});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    role = json['role'];
    categoryId = json['category_id'];
    totalBalance = json['total_balance'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['role'] = this.role;
    data['category_id'] = this.categoryId;
    data['total_balance'] = this.totalBalance;
    data['image'] = this.image;
    return data;
  }
}
