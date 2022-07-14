import 'package:hive/hive.dart';

part 'product.g.dart';

@HiveType(typeId: 1)
class Product {
  @HiveField(0)
  String code;

  @HiveField(1)
  DateTime date;

  Product(this.code, this.date);
}
