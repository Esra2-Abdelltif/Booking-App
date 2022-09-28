class SearchHotelModel {
  final int id;
  final String name;
  final String description;
  final dynamic price;
  final dynamic rate;
  final String address;
  final List<Facilities> facilities;

  SearchHotelModel({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.address,
    required this.rate,
    required this.facilities,
  });


  factory SearchHotelModel.fromJson(Map<String, dynamic> json) {
    return SearchHotelModel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      price: json['price'],
      address: json['address'],
      rate: json['rate'],
      facilities: List<Facilities>.from(
        json['facilities'].map(
              (x) => Facilities.fromJson(x),
        ),
      ),

    );
  }
}


class Facilities {
  Facilities({
    required this.id,
    required this.name,
  });

  final int id;
  final String name;


  factory Facilities.fromJson(Map<String, dynamic> json) {
    return Facilities(
      id : json['id'],
      name : json['name'],

    );
  }


}

