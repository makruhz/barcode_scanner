import 'package:barcode_scanner/bloc/product_bloc.dart';
import 'package:barcode_scanner/models/barcode.dart';
import 'package:barcode_scanner/pages/barcode_list_page.dart';
import 'package:barcode_scanner/repositories/barcodes_local_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(BarcodeAdapter());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          BarcodeBloc(productsLocalRepository: BarCodesLocalRepository())..add(LoadBarcodesFromLocalStorage()),
      child: MaterialApp(
        title: 'Barcode scanner',
        theme: ThemeData(
          primarySwatch: Colors.orange,
        ),
        home: const BarcodeListPage(),
      ),
    );
  }
}
