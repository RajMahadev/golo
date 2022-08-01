import 'package:Golo/modules/services/platform/Platform.dart';
import 'package:Golo/modules/services/platform/lara/lara.dart';

import 'Base.dart';
import 'Place.dart';

class City extends Base {
  int? count;
  String? name;
  String? description;

  // Get from other request
  String? featuredImamge; // media?slug=$slug
  String? country;
  String? intro;
  String? location;
  String? address;
  String? visitTime;
  String? currency;
  String? language;
  double? lat;
  double? long;

  City(Map<String, dynamic> json, PlatformType platformType) : super(json) {
    count = json["count"];
    name = json["name"];
    description = json["description"];
    country = json["place_city_country"];
    intro = json["place_city_banner_intro"];
    location = json["place_city_address"] != null
        ? json["place_city_address"]["location"]
        : null;
    address = json["place_city_address"] != null
        ? json["place_city_address"]["address"]
        : "Address";
    featuredImamge = platformType == PlatformType.lara
        ? "${Lara.baseUrlImage}${json["thumb"] ?? ""}"
        : json["place_city_featured_image"] != null
            ? json["place_city_featured_image"]["url"]
            : null;
    visitTime = json["place_city_visit_time"];
    currency = json["place_city_currency"];
    language = json["place_city_language"];
    if (platformType == PlatformType.lara) {
      lat = json['lat'];
      long = json['lng'];
    } else {
      if (location != null) {
        lat = double.tryParse(location!.split(",")[0]);
        long = double.tryParse(location!.split(",")[1]);
      }
    }
  }

  factory City.fromJson(Map<String, dynamic> json, PlatformType platformType) {
    return City(json, platformType);
  }
}
