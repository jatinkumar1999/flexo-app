class ServiceModel {
  bool? status;
  String? message;
  List<ServiceItem>? services;
  int? totalRecords;

  ServiceModel({this.status, this.message, this.services, this.totalRecords});

  ServiceModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['services'] != null) {
      services = <ServiceItem>[];
      json['services'].forEach((v) {
        services!.add(new ServiceItem.fromJson(v));
      });
    }
    totalRecords = json['total_records'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.services != null) {
      data['services'] = this.services!.map((v) => v.toJson()).toList();
    }
    data['total_records'] = this.totalRecords;

    return data;
  }
}

class ServiceItem {
  String? serviceId;
  String? serviceTitle;
  String? categoryId;
  String? price;
  String? description;
  String? duration;
  String? image;

  ServiceItem(
      {this.serviceId,
        this.serviceTitle,
        this.categoryId,
        this.price,
        this.description,
        this.duration,
        this.image});

  ServiceItem.fromJson(Map<String, dynamic> json) {
    serviceId = json['service_id'];
    serviceTitle = json['service_title'];
    categoryId = json['category_id'];
    price = json['price'];
    description = json['description'];
    duration = json['duration'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['service_id'] = this.serviceId;
    data['service_title'] = this.serviceTitle;
    data['category_id'] = this.categoryId;
    data['price'] = this.price;
    data['description'] = this.description;
    data['duration'] = this.duration;
    data['image'] = this.image;
    return data;
  }
}
