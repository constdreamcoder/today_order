import 'package:json_annotation/json_annotation.dart';
import 'package:today_order/domain/model/restaurant_model.dart';

import '../../core/model/model_with_id.dart';
import '../../core/utils/data_utils.dart';

part 'product_model.g.dart';

@JsonSerializable()
class ProductModel implements IModelWithId {
  final String id;
  final RestaurantModel restaurant;
  final String name;
  @JsonKey(fromJson: DataUtils.pathToUrl)
  final String imgUrl;
  final String detail;
  final int price;

  ProductModel({
    required this.id,
    required this.restaurant,
    required this.name,
    required this.imgUrl,
    required this.detail,
    required this.price,
  });
  
  factory ProductModel.fromJson(Map<String, dynamic> json) {
      return _$ProductModelFromJson(json);
    }
  
  Map<String, dynamic> toJson() => _$ProductModelToJson(this);
}
