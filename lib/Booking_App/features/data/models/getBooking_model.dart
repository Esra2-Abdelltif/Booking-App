class GetBooking {
  Status? status;
  Data? data;

  GetBooking({this.status, this.data});

  GetBooking.fromJson(Map<String, dynamic> json) {
    status =
    json['status'] != null ? new Status.fromJson(json['status']) : null;
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }
}

class Status {
  String? type;

  Status({this.type});

  Status.fromJson(Map<String, dynamic> json) {
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    return data;
  }
}

class Data {
  int? currentPage;
  List<DataModel>? data;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  List<Links>? links;
  Null? nextPageUrl;
  String? path;
  String? perPage;
  Null? prevPageUrl;
  int? to;
  int? total;

  Data(
      {this.currentPage,
        this.data,
        this.firstPageUrl,
        this.from,
        this.lastPage,
        this.lastPageUrl,
        this.links,
        this.nextPageUrl,
        this.path,
        this.perPage,
        this.prevPageUrl,
        this.to,
        this.total});

  Data.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = <DataModel>[];
      json['data'].forEach((v) {
        data!.add(new DataModel.fromJson(v));
      });
    }else{
       null;
    }
    firstPageUrl = json['first_page_url'];
    from = json['from'];
    lastPage = json['last_page'];
    lastPageUrl = json['last_page_url'];
    if (json['links'] != null) {
      links = <Links>[];
      json['links'].forEach((v) {
        links!.add(new Links.fromJson(v));
      });
    }
    nextPageUrl = json['next_page_url'];
    path = json['path'];
    perPage = json['per_page'];
    prevPageUrl = json['prev_page_url'];
    to = json['to'];
    total = json['total'];
  }
}

class DataModel {
  int? id;
  String? userId;
  String? hotelId;
  String? type;
  String? createdAt;
  String? updatedAt;
  User? user;
  Hotel? hotel;

  DataModel(
      {this.id,
        this.userId,
        this.hotelId,
        this.type,
        this.createdAt,
        this.updatedAt,
        this.user,
        this.hotel});

  DataModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    hotelId = json['hotel_id'];
    type = json['type'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    hotel = json['hotel'] != null ? new Hotel.fromJson(json['hotel']) : null;
  }
}

class User {
  int? id;
  String? name;
  String? email;
  Null? emailVerifiedAt;
  String? apiToken;
  Null? image;
  String? createdAt;
  String? updatedAt;
  Null? googleId;
  Null? provider;

  User(
      {this.id,
        this.name,
        this.email,
        this.emailVerifiedAt,
        this.apiToken,
        this.image,
        this.createdAt,
        this.updatedAt,
        this.googleId,
        this.provider});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    emailVerifiedAt = json['email_verified_at'];
    apiToken = json['api_token'];
    image = json['image'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    googleId = json['google_id'];
    provider = json['provider'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['email_verified_at'] = this.emailVerifiedAt;
    data['api_token'] = this.apiToken;
    data['image'] = this.image;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['google_id'] = this.googleId;
    data['provider'] = this.provider;
    return data;
  }
}

class Hotel {
  int? id;
  String? name;
  String? description;
  String? price;
  String? address;
  String? longitude;
  String? latitude;
  String? rate;
  String? createdAt;
  String? updatedAt;
  List<HotelImages>? hotelImages;
  List<Facilities>? facilities;

  Hotel(
      {this.id,
        this.name,
        this.description,
        this.price,
        this.address,
        this.longitude,
        this.latitude,
        this.rate,
        this.createdAt,
        this.updatedAt,
        this.hotelImages,
        this.facilities});

  Hotel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    price = json['price'];
    address = json['address'];
    longitude = json['longitude'];
    latitude = json['latitude'];
    rate = json['rate'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['hotel_images'] != null) {
      hotelImages = <HotelImages>[];
      json['hotel_images'].forEach((v) {
        hotelImages!.add(new HotelImages.fromJson(v));
      });
    }
    if (json['facilities'] != null) {
      facilities = <Facilities>[];
      json['facilities'].forEach((v) {
        facilities!.add(new Facilities.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['price'] = this.price;
    data['address'] = this.address;
    data['longitude'] = this.longitude;
    data['latitude'] = this.latitude;
    data['rate'] = this.rate;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.hotelImages != null) {
      data['hotel_images'] = this.hotelImages!.map((v) => v.toJson()).toList();
    }
    if (this.facilities != null) {
      data['facilities'] = this.facilities!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class HotelImages {
  int? id;
  String? hotelId;
  String? image;
  Null? createdAt;
  Null? updatedAt;

  HotelImages(
      {this.id, this.hotelId, this.image, this.createdAt, this.updatedAt});

  HotelImages.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    hotelId = json['hotel_id'];
    image = json['image'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['hotel_id'] = this.hotelId;
    data['image'] = this.image;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class Facilities {
  int? id;
  String? name;
  String? image;
  String? createdAt;
  String? updatedAt;

  Facilities({this.id, this.name, this.image, this.createdAt, this.updatedAt});

  Facilities.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['image'] = this.image;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class Links {
  String? url;
  String? label;
  bool? active;

  Links({this.url, this.label, this.active});

  Links.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    label = json['label'];
    active = json['active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['url'] = this.url;
    data['label'] = this.label;
    data['active'] = this.active;
    return data;
  }
}