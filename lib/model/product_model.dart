import 'package:hive/hive.dart';
import 'package:mobx/mobx.dart';

part 'product_model.g.dart';

@HiveType(typeId: 1)
class ProductModel extends HiveObject with Store {
  @HiveField(0)
  String productName;

  @HiveField(1)
  DateTime launchAt;

  @HiveField(2)
  String launchSite;

  @HiveField(3)
  int stars;

  ProductModel({
    required this.productName,
    required this.launchAt,
    required this.launchSite,
    required this.stars,
  });
}
