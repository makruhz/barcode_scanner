import 'package:barcode_scanner/models/barcode.dart';
import 'package:hive_flutter/hive_flutter.dart';

class BarCodesLocalRepository {
  Future<Box> productBox() async {
    var box = await Hive.openBox<Barcode>("products");
    return box;
  }

  Future<List<Barcode>> loadBarCodes() async {
    await Future.delayed(const Duration(seconds: 2));
    final box = await productBox();
    final List<Barcode> products = box.values.toList().cast();
    return products;
  }

  Future<void> addBarCode(Barcode product) async {
    final box = await productBox();
    await box.add(product);
  }

  Future<void> deleteBarCode(Barcode product) async {
    final box = await productBox();
    await box.delete(product.key);
  }
}
