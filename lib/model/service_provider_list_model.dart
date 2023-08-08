class ServiceProviderList {
  bool? status;
  String? message;
  List<Providers>? services;
  int? totalRecords;

  ServiceProviderList(
      {this.status, this.message, this.services, this.totalRecords});

  ServiceProviderList.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['providers'] != null) {
      services = <Providers>[];
      json['providers'].forEach((v) {
        services!.add(new Providers.fromJson(v));
      });
    }
    totalRecords = json['total_records'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.services != null) {
      data['providers'] = this.services!.map((v) => v.toJson()).toList();
    }
    data['total_records'] = this.totalRecords;
    return data;
  }
}

class Providers {
  String? categoryId;
  String? category;
  String? userId;
  String? userImage;
  String? serviceProvider;

  Providers(
      {this.categoryId,
        this.category,
        this.userId,
        this.userImage,
        this.serviceProvider});

  Providers.fromJson(Map<String, dynamic> json) {
    categoryId = json['category_id'];
    category = json['category'];
    userId = json['user_id'];
    userImage = json['user_image'];
    serviceProvider = json['service_provider'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['category_id'] = this.categoryId;
    data['category'] = this.category;
    data['user_id'] = this.userId;
    data['user_image'] = this.userImage;
    data['service_provider'] = this.serviceProvider;
    return data;
  }
}
