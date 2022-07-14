import 'package:hive/hive.dart';

part 'barcode.g.dart';

@HiveType(typeId: 1)
class Barcode extends HiveObject {
  @HiveField(0)
  String data;

  @HiveField(1)
  DateTime date;

  Barcode(this.data, this.date);
}
