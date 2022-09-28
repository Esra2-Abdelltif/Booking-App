class HotelModel {
  final int id;
  final String name;
  final String description;
  final String address;
  final dynamic price;
  final dynamic rate;
  final String latitude;
  final String longitude;
  final List<String> images;


  HotelModel({
    required this.id,
    required this.name,
    required this.description,
    required this.address,
    required this.rate,
    required this.price,
    required this.latitude,
    required this.longitude,
    required this.images,
  });

  factory HotelModel.fromJson(Map<String, dynamic> json) {
    return HotelModel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      price: json['price'],
      rate: json['rate'],
      address: json['address'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      images: List<String>.from(json['hotel_images'].map((x) => x['image'])),
    );
  }
}