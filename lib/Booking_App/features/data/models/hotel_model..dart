class HotelModel {
  final int id;
  final String name;
  final String description;
  final String adresse;
  final dynamic price;
  final dynamic rate;

  HotelModel({
    required this.id,
    required this.name,
    required this.description,
    required this.adresse,
    required this.rate,
    required this.price,
  });

  factory HotelModel.fromJson(Map<String, dynamic> json) {
    return HotelModel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      price: json['price'],
      rate: json['rate'],
      adresse: json['address'],
    );
  }
}