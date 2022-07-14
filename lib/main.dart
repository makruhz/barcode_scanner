import 'package:barcode_scanner/bloc/product_bloc.dart';
import 'package:barcode_scanner/pages/barcode_list_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  await Hive.initFlutter();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Barcode scanner',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: BlocProvider(
        create: (_) => ProductBloc()..add(LoadProductFromLocalStorage()),
        child: const BarcodeListPage(),
      ),
    );
  }
}
