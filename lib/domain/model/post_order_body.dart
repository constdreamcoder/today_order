import 'package:freezed_annotation/freezed_annotation.dart';

part 'post_order_body.freezed.dart';

part 'post_order_body.g.dart';

@freezed
class PostOrderBody with _$PostOrderBody {
  const factory PostOrderBody({
    @Default('') String id,
    @Default([]) List<PostOrderBodyProduct> products,
    @Default(0) int totalPrice,
    @Default('') String createdAt,
  }) = _PostOrderBody;

  factory PostOrderBody.fromJson(Map<String, Object?> json) => _$PostOrderBodyFromJson(json);
}

@freezed
class PostOrderBodyProduct with _$PostOrderBodyProduct {
  const factory PostOrderBodyProduct({
    @Default('') String productId,
    @Default(0) int count,
  }) = _PostOrderBodyProduct;

  factory PostOrderBodyProduct.fromJson(Map<String, Object?> json) => _$PostOrderBodyProductFromJson(json);
}