class BookingListModel {
  String? message;
  bool? success;
  String? images;
  List<BookingItem>? results;

  BookingListModel({this.message, this.success, this.images, this.results});

  BookingListModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    success = json['success'];
    images = json['images'];
    if (json['results'] != null) {
      results = <BookingItem>[];
      json['results'].forEach((v) {
        results!.add(new BookingItem.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['success'] = this.success;
    data['images'] = this.images;
    if (this.results != null) {
      data['results'] = this.results!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class BookingItem {
  int? bookingId;
  String? status;
  String? dateTime;
  int? userId;
  String? category;
  String? image;
  String? serviceTitle;
  String? timeSlotValue;

  BookingItem(
      {this.bookingId,
        this.status,
        this.dateTime,
        this.userId,
        this.category,
        this.image,
        this.serviceTitle,
        this.timeSlotValue});

  BookingItem.fromJson(Map<String, dynamic> json) {
    bookingId = json['booking_id'];
    status = json['status'];
    dateTime = json['date_time'];
    userId = json['user_id'];
    category = json['category'];
    image = json['image'];
    serviceTitle = json['service_title'];
    timeSlotValue = json['time_slot_value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['booking_id'] = this.bookingId;
    data['status'] = this.status;
    data['date_time'] = this.dateTime;
    data['user_id'] = this.userId;
    data['category'] = this.category;
    data['image'] = this.image;
    data['service_title'] = this.serviceTitle;
    data['time_slot_value'] = this.timeSlotValue;
    return data;
  }
}
