import 'package:Golo/modules/services/platform/Platform.dart';
import 'package:Golo/modules/services/platform/lara/lara.dart';
import 'package:Golo/src/entity/Base.dart';
import 'package:html/parser.dart';

class Post extends Base {
  String? title;
  String? content;
  String? link;
  String? type;
  String? excerpt;
  String? featuredMedia; // feature image id
  String? commentStatus;
  late List<String> categories;
  String? featuredMediaUrl;

  Post(Map<String, dynamic> json, PlatformType platformType) : super(json) {
    if (platformType == PlatformType.lara) {
      title = parse(json["title"] ?? "").documentElement!.text;
      content = parse(json["content"] ?? "").documentElement!.text;
      excerpt = parse(json["excerpt"] ?? "").documentElement!.text;
      featuredMediaUrl = Lara.baseUrlImage + json["thumb"];
    } else {
      title = parse(json["title"]["rendered"] ?? "").documentElement!.text;
      content = parse(json["content"]["rendered"] ?? "").documentElement!.text;
      excerpt = parse(json["excerpt"]["rendered"] ?? "").documentElement!.text;
      // featured_media_url
      featuredMediaUrl = json["featured_media_url"];
    }

    link = json["link"];
    type = json["type"];
    featuredMedia = json["featured_media"].toString();
    commentStatus = json["comment_status"];
    // categories
    categories = [];
    List<dynamic> cats = json["categories"];
    cats.forEach((value) {
      categories.add(value.toString());
    });
  }
}
