import 'package:barcode_scanner/bloc/barcode_bloc.dart';
import 'package:barcode_scanner/models/barcode.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_qr_bar_scanner/qr_bar_scanner_camera.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ScannerPage extends StatefulWidget {
  const ScannerPage({Key? key}) : super(key: key);

  @override
  State<ScannerPage> createState() => _ScannerPageState();
}

class _ScannerPageState extends State<ScannerPage> {
  String? _qrInfo;
  bool isScanned = false;

  _qrCallback(String? code) {
    setState(() {
      isScanned = true;
      _qrInfo = code;
    });
  }

  @override
  void initState() {
    isScanned = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.scanner),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Center(
                child: QRBarScannerCamera(
                  onError: (context, error) => Text(
                    error.toString(),
                    style: const TextStyle(color: Colors.red),
                  ),
                  qrCodeCallback: (code) {
                    _qrCallback(code);
                  },
                ),
              ),
            ),
            isScanned
                ? SizedBox(
                    height: 150,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text("${AppLocalizations.of(context)!.your_bardcode} ${_qrInfo!}"),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  isScanned = false;
                                  _qrInfo = null;
                                });
                              },
                              child: Text(AppLocalizations.of(context)!.scan_again),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                final product = Barcode(_qrInfo!, DateTime.now());
                                BlocProvider.of<BarcodeBloc>(context).add(AddBarcode(product));
                                Navigator.pop(context);
                              },
                              child: Text(AppLocalizations.of(context)!.add),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                : Container(
                    alignment: Alignment.center,
                    height: 150,
                    child: Text(AppLocalizations.of(context)!.please_scan_barcode),
                  )
          ],
        ),
      ),
    );
  }
}
