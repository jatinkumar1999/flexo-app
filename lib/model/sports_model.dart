class CategoryList {
  bool? status;
  String? message;
  List<Categories>? categories;

  CategoryList({this.status, this.message, this.categories});

  CategoryList.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['categories'] != null) {
      categories = <Categories>[];
      json['categories'].forEach((v) {
        categories!.add(new Categories.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.categories != null) {
      data['categories'] = this.categories!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Categories {
  String? id;
  String? category;
  String? image;

  Categories({this.id, this.category, this.image});

  Categories.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    category = json['category'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['category'] = this.category;
    data['image'] = this.image;
    return data;
  }
}
