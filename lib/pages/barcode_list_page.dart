import 'package:barcode_scanner/bloc/product_bloc.dart';
import 'package:barcode_scanner/models/product.dart';
import 'package:barcode_scanner/pages/scanner_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BarcodeListPage extends StatelessWidget {
  const BarcodeListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<ProductBloc, ProductState>(
        builder: (context, state) {
          switch (state.status) {
            case ProductStatus.failure:
              return const Text('Cos poszło nie tak :(');
            case ProductStatus.success:
              if (state.products.isEmpty) {
                return const Center(child: Text('Brak produktów'));
              } else {
                return ListView.builder(
                    itemCount: state.products.length,
                    itemBuilder: (context, index) {
                      final products = state.products;
                      return BarCard(product: products[index]);
                    });
              }
            default:
              return const Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => const ScannerPage()));
        },
        tooltip: 'Scan',
        child: const Icon(Icons.qr_code_scanner_rounded),
      ),
    );
  }
}

class BarCard extends StatelessWidget {
  const BarCard({Key? key, required this.product}) : super(key: key);

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.all(16),
      color: Colors.white12,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(product.code),
          const Spacer(),
          Text(product.date.timeZoneName),
          const SizedBox(width: 50),
          IconButton(
            onPressed: () {
              print('delete');
            },
            icon: const Icon(Icons.cancel),
          ),
        ],
      ),
    );
  }
}
