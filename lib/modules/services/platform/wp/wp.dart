import 'package:Golo/modules/services/platform/Platform.dart';
import 'package:Golo/modules/services/platform/PlatformBase.dart';

class WP extends PlatformBase {
  WP() : super() {
    baseUrl = "https://wp.getgolo.com/city-guide/wp-json/wp/v2/";
    type = PlatformType.wp;
  }
}
