import 'dart:io';

import 'package:flutter_dotenv/flutter_dotenv.dart';

class Constant {
  static final String tempImageURL = dotenv.get('tempImageURL');

  // 토큰 관련
  static final String ACCESS_TOKEN_KEY = dotenv.get('ACCESS_TOKEN_KEY');
  static final String REFRESH_TOKEN_KEY = dotenv.get('REFRESH_TOKEN_KEY');

  static String baseUrl =
      Platform.isIOS ? dotenv.get('simulatorUrl') : dotenv.get('emulatorUrl');
}
