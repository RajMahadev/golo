import 'dart:convert';

import 'package:Golo/modules/services/http/Api.dart';
import 'package:Golo/modules/services/platform/Platform.dart';
import 'package:Golo/src/providers/request_services/query/PageQuery.dart';
import 'package:Golo/src/providers/request_services/response/ResponseListData.dart';

class ApiPost {
  static Future<ResponseListData> fetchPosts({PageQuery? query}) {
    var url = Platform().shared.baseUrl + "posts";

    if (Platform().shared.type == PlatformType.lara) {
      url = Platform().shared.baseUrl + "/posts/inspiration";
    }
    return Api.requestGetPaging(url, query).then((data) {
      if (Platform().shared.type == PlatformType.lara) {
        var jsonObj = json.decode(data.json!) as Map;
        var jsonData = jsonObj["data"] as List;
        return ResponseListData(jsonData, data.error);
      }
      return ResponseListData(json.decode(data.json!), data.error);
    }, onError: (e) => throw e);
  }
}
