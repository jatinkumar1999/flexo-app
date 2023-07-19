class ServiceProviderModel {
  bool? status;
  String? message;
  List<Services>? services;

  ServiceProviderModel({this.status, this.message, this.services});

  ServiceProviderModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['services'] != null) {
      services = <Services>[];
      json['services'].forEach((v) {
        services!.add(new Services.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.services != null) {
      data['services'] = this.services!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Services {
  String? categoryId;
  String? userId;
  String? userImage;
  String? serviceProvider;

  Services(
      {this.categoryId, this.userId, this.userImage, this.serviceProvider});

  Services.fromJson(Map<String, dynamic> json) {
    categoryId = json['category_id'];
    userId = json['user_id'];
    userImage = json['user_image'];
    serviceProvider = json['service_provider'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['category_id'] = this.categoryId;
    data['user_id'] = this.userId;
    data['user_image'] = this.userImage;
    data['service_provider'] = this.serviceProvider;
    return data;
  }
}
