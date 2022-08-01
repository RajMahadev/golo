import 'dart:convert';

import 'package:Golo/modules/services/platform/Platform.dart';
import 'package:Golo/modules/services/http/Api.dart';
import 'package:Golo/src/providers/request_services/query/PageQuery.dart';
import 'package:Golo/src/providers/request_services/response/ResponseListData.dart';

class ApiCity {
  static Future<ResponseListData> fetchCities({PageQuery? query}) {
    var url = Platform().shared.baseUrl + "place-city";
    if (Platform().shared.type == PlatformType.lara) {
      url = Platform().shared.baseUrl + "/cities/popular";
    }

    return Api.requestGetPaging(url, query).then((data) {
      if (Platform().shared.type == PlatformType.lara) {
        if (Platform().shared.type == PlatformType.lara) {
          var jsonObj = json.decode(data.json!) as Map;
          var jsonData = jsonObj["data"] as List;
          return ResponseListData(jsonData, data.error);
        }
      }
      return ResponseListData(json.decode(data.json!), data.error);
    }, onError: (e) {
      throw e;
    });
  }

  static Future<ResponseData> fetchCity(String id) {
    var url = Platform().shared.baseUrl + "place-city/$id";
    return Api.requestGet(url);
  }

  // Category
  static Future<ResponseListData> fetchCategories({PageQuery? query}) {
    var url = Platform().shared.baseUrl + "place-categories";
    return Api.requestGetPaging(url, query).then((data) {
      return ResponseListData(json.decode(data.json!), data.error);
    });
  }

  // Amenities
  static Future<ResponseListData> fetchAmenities({PageQuery? query}) {
    var url = Platform().shared.baseUrl + "place-amenities";
    return Api.requestGetPaging(url, query).then((data) {
      if (Platform().shared.type == PlatformType.lara) {
        var jsonObj = json.decode(data.json!) as Map;
        var jsonData = jsonObj["data"] as List;
        return ResponseListData(jsonData, data.error);
      }
      return ResponseListData(json.decode(data.json!), data.error);
    });
  }
}
