import 'package:json_annotation/json_annotation.dart';
import 'package:today_order/core/model/model_with_id.dart';
import 'package:today_order/domain/model/restaurant_model.dart';

import '../../core/utils/data_utils.dart';

part 'order_model.g.dart';

@JsonSerializable()
class OrderModel implements IModelWithId {
  final String id;
  final List<OrderProductAndCountModel> products;
  final RestaurantModel restaurant;
  final int totalPrice;
  final String createdAt;

  OrderModel({
    required this.id,
    required this.products,
    required this.restaurant,
    required this.totalPrice,
    required this.createdAt,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return _$OrderModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$OrderModelToJson(this);
}

@JsonSerializable()
class OrderProductAndCountModel {
  final OrderProductModel product;
  final int count;

  OrderProductAndCountModel({
    required this.product,
    required this.count,
  });

  factory OrderProductAndCountModel.fromJson(Map<String, dynamic> json) {
      return _$OrderProductAndCountModelFromJson(json);
    }

  Map<String, dynamic> toJson() => _$OrderProductAndCountModelToJson(this);
}

@JsonSerializable()
class OrderProductModel {
  final String id;
  final String name;
  final String detail;
  @JsonKey(
    fromJson: DataUtils.pathToUrl,
  )
  final String imgUrl;
  final int price;

  OrderProductModel({
    required this.id,
    required this.name,
    required this.detail,
    required this.imgUrl,
    required this.price,
  });

  factory OrderProductModel.fromJson(Map<String, dynamic> json) {
    return _$OrderProductModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$OrderProductModelToJson(this);
}
