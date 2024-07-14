class Area {
  final int id;
  final String area;
  final String areaid;
  final String cityid;
  final String lng;
  final String lat;

  Area(
      {required this.id,
      required this.area,
      required this.areaid,
      required this.cityid,
      required this.lng,
      required this.lat});

  factory Area.fromJson(Map<String, dynamic> json) {
    return Area(
      id: json['id'],
      area: json['area'],
      areaid: json['areaid'],
      cityid: json['cityid'],
      lng: json['lng'],
      lat: json['lat'],
    );
  }
}

class City {
  final int id;
  final String city;
  final String cityid;
  final String provinceid;
  final String lng;
  final String lat;
  final List<Area> district;

  City(
      {required this.id,
      required this.city,
      required this.cityid,
      required this.provinceid,
      required this.lng,
      required this.lat,
      required this.district});

  factory City.fromJson(Map<String, dynamic> json) {
    var list = json['district'] as List;
    List<Area> districtList = list.map((i) => Area.fromJson(i)).toList();

    return City(
      id: json['id'],
      city: json['city'],
      cityid: json['cityid'],
      provinceid: json['provinceid'],
      lng: json['lng'],
      lat: json['lat'],
      district: districtList,
    );
  }
}

class Province {
  final int id;
  final String provinceid;
  final String province;
  final String lng;
  final String lat;
  final List<City> cities;

  Province(
      {required this.id,
      required this.provinceid,
      required this.province,
      required this.lng,
      required this.lat,
      required this.cities});

  factory Province.fromJson(Map<String, dynamic> json) {
    var list = json['cities'] as List;
    List<City> cityList = list.map((i) => City.fromJson(i)).toList();

    return Province(
      id: json['id'],
      provinceid: json['provinceid'],
      province: json['province'],
      lng: json['lng'],
      lat: json['lat'],
      cities: cityList,
    );
  }
}
