import 'package:freezed_annotation/freezed_annotation.dart';

part 'patch_shopping_cart_body.freezed.dart';

part 'patch_shopping_cart_body.g.dart';

@freezed
class PatchShoppingCartBody with _$PatchShoppingCartBody {
  const factory PatchShoppingCartBody({
    @Default([]) List<PatchShoppingCartBodyItem> basket,
  }) = _PatchShoppingCartBody;

  factory PatchShoppingCartBody.fromJson(Map<String, Object?> json) =>
      _$PatchShoppingCartBodyFromJson(json);
}

@freezed
class PatchShoppingCartBodyItem with _$PatchShoppingCartBodyItem {
  const factory PatchShoppingCartBodyItem({
    @Default('') String productId,
    @Default(0) int count,
  }) = _PatchShoppingCartBodyItem;

  factory PatchShoppingCartBodyItem.fromJson(Map<String, Object?> json) =>
      _$PatchShoppingCartBodyItemFromJson(json);
}