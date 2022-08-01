import 'package:Golo/modules/services/platform/Platform.dart';
import 'package:Golo/modules/services/platform/PlatformBase.dart';

class Lara extends PlatformBase {
  static const String baseUrlImage = "https://lara-cityguide.getgolo.com/uploads/";

  Lara(): super(){
    baseUrl = "https://lara-cityguide.getgolo.com/api/app";
    type =PlatformType.lara;
  }
}