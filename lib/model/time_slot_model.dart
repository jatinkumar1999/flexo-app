class TimeSlotModel {
  String? message;
  bool? success;
  List<TimeSlot>? results;

  TimeSlotModel({this.message, this.success, this.results});

  TimeSlotModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    success = json['success'];
    if (json['results'] != null) {
      results = <TimeSlot>[];
      json['results'].forEach((v) {
        results!.add(new TimeSlot.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['success'] = this.success;
    if (this.results != null) {
      data['results'] = this.results!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TimeSlot {
  int? timeSlotId;
  String? timeSlotValue;

  TimeSlot({this.timeSlotId, this.timeSlotValue});

  TimeSlot.fromJson(Map<String, dynamic> json) {
    timeSlotId = json['time_slot_id'];
    timeSlotValue = json['time_slot_value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['time_slot_id'] = this.timeSlotId;
    data['time_slot_value'] = this.timeSlotValue;
    return data;
  }
}
