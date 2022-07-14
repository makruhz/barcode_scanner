import 'package:barcode_scanner/models/barcode.dart';
import 'package:hive_flutter/hive_flutter.dart';

class BarCodesLocalRepository {
  Future<Box> barcodesBox() async {
    var box = await Hive.openBox<Barcode>("barcodes");
    return box;
  }

  Future<List<Barcode>> loadBarCodes() async {
    await Future.delayed(const Duration(seconds: 2));
    final box = await barcodesBox();
    final List<Barcode> barcodes = box.values.toList().cast();
    return barcodes;
  }

  Future<void> addBarCode(Barcode barcode) async {
    final box = await barcodesBox();
    await box.add(barcode);
  }

  Future<void> deleteBarCode(Barcode barcode) async {
    final box = await barcodesBox();
    await box.delete(barcode.key);
  }
}
