import 'package:freezed_annotation/freezed_annotation.dart';

part 'refreshed_token_response.freezed.dart';

part 'refreshed_token_response.g.dart';

@freezed
class RefreshedTokenResponse with _$RefreshedTokenResponse {
  const factory RefreshedTokenResponse({
    @Default('') String accessToken,
  }) = _RefreshedTokenResponse;

  factory RefreshedTokenResponse.fromJson(Map<String, dynamic> json) =>
      _$RefreshedTokenResponseFromJson(json);
}
