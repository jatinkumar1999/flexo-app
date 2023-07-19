class GetCardDetailsModel {
  bool? status;
  String? message;
  List<CardDetails>? cardDetails;

  GetCardDetailsModel({this.status, this.message, this.cardDetails});

  GetCardDetailsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['Card details'] != null) {
      cardDetails = <CardDetails>[];
      json['Card details'].forEach((v) {
        cardDetails!.add(new CardDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.cardDetails != null) {
      data['Card details'] = this.cardDetails!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CardDetails {
  String? id;
  String? cardHolderName;
  String? cardNumber;
  String? year;
  String? month;
  String? upiId;

  CardDetails(
      {this.id,
        this.cardHolderName,
        this.cardNumber,
        this.year,
        this.month,
        this.upiId});

  CardDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    cardHolderName = json['card_holder_name'];
    cardNumber = json['card_number'];
    year = json['year'];
    month = json['month'];
    upiId = json['upi_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['card_holder_name'] = this.cardHolderName;
    data['card_number'] = this.cardNumber;
    data['year'] = this.year;
    data['month'] = this.month;
    data['upi_id'] = this.upiId;
    return data;
  }
}
