import 'package:freezed_annotation/freezed_annotation.dart';

part 'login_response.freezed.dart';

part 'login_response.g.dart';

@freezed
class LoginResponse with _$LoginResponse {
  const factory LoginResponse({
    @Default('') String accessToken,
    @Default('') String refreshToken,
  }) = _LoginResponse;

  factory LoginResponse.fromJson(Map<String, Object?> json) => _$LoginResponseFromJson(json);
}