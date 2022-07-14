import 'package:barcode_scanner/bloc/product_bloc.dart';
import 'package:barcode_scanner/models/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_qr_bar_scanner/qr_bar_scanner_camera.dart';

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
  void dispose() {
    _qrInfo = null;
    isScanned = false;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Skaner'),
      ),
      body: Column(
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
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Twój kod to: ${_qrInfo!}"),
                      const SizedBox(height: 20),
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
                            child: const Text('Skanuj ponownie'),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              final product = Product(_qrInfo!, DateTime.now());
                              BlocProvider.of<ProductBloc>(context).add(AddProduct(product));
                              Navigator.pop(context);
                            },
                            child: const Text('Dodaj'),
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              : Container(alignment: Alignment.center, height: 150, child: const Text('Proszę zeskanuj kod'))
        ],
      ),
    );
  }
}
