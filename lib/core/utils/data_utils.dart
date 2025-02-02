import 'dart:convert';

import '../../domain/model/restaurant_model.dart';
import '../constant/constant.dart';

class DataUtils {

  static String pathToUrl(String value) {
    return '${Constant.baseUrl}$value';
  }
  static String plainToBase64(String plain) {
    Codec<String, String> stringToBase64 = utf8.fuse(base64);

    String encoded = stringToBase64.encode(plain);

    return encoded;
  }

  static List<String> listPathsToUrls(List paths) {
    return paths.map((e) => pathToUrl(e)).toList();
  }

  static DateTime stringToDateTime(String value) {
    return DateTime.parse(value);
  }
}