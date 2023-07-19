class ServiceModel {
  bool? status;
  String? message;
  List<ServiceItem>? services;

  ServiceModel({this.status, this.message, this.services});

  ServiceModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['services'] != null) {
      services = <ServiceItem>[];
      json['services'].forEach((v) {
        services!.add(new ServiceItem.fromJson(v));
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

class ServiceItem {
  String? serviceId;
  String? serviceTitle;
  String? categoryId;
  String? price;
  String? description;

  ServiceItem(
      {this.serviceId,
        this.serviceTitle,
        this.categoryId,
        this.price,
        this.description});

  ServiceItem.fromJson(Map<String, dynamic> json) {
    serviceId = json['service_id'];
    serviceTitle = json['service_title'];
    categoryId = json['category_id'];
    price = json['price'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['service_id'] = this.serviceId;
    data['service_title'] = this.serviceTitle;
    data['category_id'] = this.categoryId;
    data['price'] = this.price;
    data['description'] = this.description;
    return data;
  }
}
