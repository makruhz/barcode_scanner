import 'package:barcode_scanner/bloc/barcode_bloc.dart';
import 'package:barcode_scanner/models/barcode.dart';
import 'package:barcode_scanner/pages/scanner_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class BarcodeListPage extends StatelessWidget {
  const BarcodeListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.barcodes_list),
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
                  return Center(child: Text(AppLocalizations.of(context)!.no_barcodes));
                } else {
                  return ListView.builder(
                      itemCount: state.barcodes.length,
                      itemBuilder: (context, index) {
                        return BarCodeCard(barCode: state.barcodes[index]);
                      });
                }
              default:
                return Text(AppLocalizations.of(context)!.went_wrong);
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => const ScannerPage()));
        },
        tooltip: AppLocalizations.of(context)!.scan_barcode,
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
      padding: const EdgeInsets.all(8.0),
      margin: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0.0),
      decoration: const BoxDecoration(
        color: Colors.orangeAccent,
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(width: 10),
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
