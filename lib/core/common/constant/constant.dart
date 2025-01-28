import 'package:flutter_dotenv/flutter_dotenv.dart';

class Constant {
  static String tempImageURL = dotenv.get('tempImageURL');
}