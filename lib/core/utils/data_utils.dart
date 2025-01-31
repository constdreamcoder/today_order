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

  static RestaurantPriceRange stringToRestaurantPriceRange(String value) {
    return RestaurantPriceRange.values.firstWhere((e) => e.name == value);
  }
}