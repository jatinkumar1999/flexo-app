class CategoryList {
  bool? status;
  String? message;
  List<Categories>? categories;
  int? totalRecords;

  CategoryList({this.status, this.message, this.categories, this.totalRecords});

  CategoryList.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['categories'] != null) {
      categories = <Categories>[];
      json['categories'].forEach((v) {
        categories!.add(new Categories.fromJson(v));
      });
    }
    totalRecords = json['total_records'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.categories != null) {
      data['categories'] = this.categories!.map((v) => v.toJson()).toList();
    }
    data['total_records'] = this.totalRecords;
    return data;
  }
}

class Categories {
  String? id;
  String? category;
  Null? categoryInfo;
  int? serviceProviderCount;
  String? image;

  Categories(
      {this.id,
        this.category,
        this.categoryInfo,
        this.serviceProviderCount,
        this.image});

  Categories.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    category = json['category'];
    categoryInfo = json['category_info'];
    serviceProviderCount = json['service_provider_count'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['category'] = this.category;
    data['category_info'] = this.categoryInfo;
    data['service_provider_count'] = this.serviceProviderCount;
    data['image'] = this.image;
    return data;
  }
}
