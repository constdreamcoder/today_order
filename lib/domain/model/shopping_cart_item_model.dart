import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:today_order/domain/model/product_model.dart';

part 'shopping_cart_item_model.freezed.dart';

part 'shopping_cart_item_model.g.dart';

@freezed
class ShoppingCartItemModel with _$ShoppingCartItemModel {
  const factory ShoppingCartItemModel({
    required ProductModel product,
    @Default(0) int count,
  }) = _ShoppingCartItemModel;

  factory ShoppingCartItemModel.fromJson(Map<String, Object?> json) =>
      _$ShoppingCartItemModelFromJson(json);
}
