import 'package:barcode_scanner/bloc/product_bloc.dart';
import 'package:barcode_scanner/models/barcode.dart';
import 'package:barcode_scanner/pages/scanner_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class BarcodeListPage extends StatelessWidget {
  const BarcodeListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Lista produktów"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: BlocBuilder<BarcodeBloc, BarcodeState>(
          builder: (context, state) {
            switch (state.status) {
              case BarcodeStatus.initial:
                return const Center(child: CircularProgressIndicator());
              case BarcodeStatus.success:
                if (state.barcodes.isEmpty) {
                  return const Center(child: Text('Brak zeskanowanych barkodów'));
                } else {
                  return ListView.builder(
                      itemCount: state.barcodes.length,
                      itemBuilder: (context, index) {
                        return BarCodeCard(barCode: state.barcodes[index]);
                      });
                }
              default:
                return const Text('Cos poszło nie tak :(');
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => const ScannerPage()));
        },
        tooltip: 'Zrób skan barkodu',
        child: const Icon(Icons.qr_code_scanner_rounded),
      ),
    );
  }
}

class BarCodeCard extends StatelessWidget {
  const BarCodeCard({Key? key, required this.barCode}) : super(key: key);

  final Barcode barCode;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      margin: const EdgeInsets.all(16.0),
      decoration: const BoxDecoration(
        color: Colors.orangeAccent,
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(barCode.data),
          const Spacer(),
          Text(DateFormat('dd.MM.yyyy').format(barCode.date)),
          const SizedBox(width: 50),
          IconButton(
            onPressed: () {
              BlocProvider.of<BarcodeBloc>(context).add(DeleteBarcode(barCode));
            },
            icon: const Icon(Icons.cancel),
          ),
        ],
      ),
    );
  }
}
