class SearchHotelModel {
  final int id;
  final String name;
  final String description;
  final dynamic price;
  final dynamic rate;
  final String address;
  final String latitude;
  final String longitude;
  final List<String> images;
   final List<String>  facilitiesName;
    final List<int>  facilitiesID;
  final List<String> facilitiesimages;



  //final List<Facilities> facilities;

  SearchHotelModel({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.address,
    required this.rate,
    required this.latitude,
    required this.longitude,
    required this.images,
     required this.facilitiesID,
     required this.facilitiesName,
    required this.facilitiesimages
    //required this.facilities,
  });


  factory SearchHotelModel.fromJson(Map<String, dynamic> json) {
    return SearchHotelModel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      price: json['price'],
      address: json['address'],
      rate: json['rate'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      images: List<String>.from(json['hotel_images'].map((x) => x['image'])),
      facilitiesName: List<String>.from(json['facilities'].map((x) => x['name'])),
      facilitiesID:  List<int>.from(json['facilities'].map((x) => x['id'])),
      facilitiesimages:  List<String>.from(json['facilities'].map((x) => x['image'])),


      //facilitiesID: json['facilities'][0]['id'] ,
      //facilitiesName: json['facilities'][0]['name'] ,


      // facilities: List<Facilities>.from(
      //   json['facilities'].map(
      //         (x) => Facilities.fromJson(x),
      //   ),
      // ),

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

