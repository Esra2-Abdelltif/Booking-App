class CreateBookingModel {
  Status? status;

  CreateBookingModel({this.status});

  CreateBookingModel.fromJson(Map<String, dynamic> json) {
    status =
    json['status'] != null ? new Status.fromJson(json['status']) : null;
  }
}

class Status {
  String? type;
  Title? title;
  dynamic bookingId;

  Status({this.type, this.title, this.bookingId});

  Status.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    title = json['title'] != null ? new Title.fromJson(json['title']) : null;
    bookingId = json['booking_id'];
  }

}

class Title {
  String? ar;
  String? en;

  Title({this.ar, this.en});

  Title.fromJson(Map<String, dynamic> json) {
    ar = json['ar'];
    en = json['en'];
  }

}